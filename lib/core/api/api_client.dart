import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final List<dynamic> errors;

  ApiException(this.statusCode, this.message, {this.errors = const []});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class ApiClient {
  final String baseUrl;
  final Duration timeout;

  ApiClient({String? baseUrl, Duration? timeout})
      : baseUrl = baseUrl ?? ApiConfig.baseUrl,
        timeout = timeout ?? ApiConfig.timeout;

  Future<Map<String, dynamic>> get(String path, {Map<String, String>? query}) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query);
    return _send(() => http.get(uri).timeout(timeout));
  }

  Future<Map<String, dynamic>> post(String path, {Object? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    return _send(() => http
        .post(uri, headers: _headers, body: jsonEncode(body ?? const {}))
        .timeout(timeout));
  }

  Future<Map<String, dynamic>> patch(String path, {Object? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    return _send(() => http
        .patch(uri, headers: _headers, body: jsonEncode(body ?? const {}))
        .timeout(timeout));
  }

  Map<String, String> get _headers => {'Content-Type': 'application/json'};

  Future<Map<String, dynamic>> _send(Future<http.Response> Function() request) async {
    final http.Response response;
    try {
      response = await request();
    } on TimeoutException {
      throw ApiException(408, 'Server tidak merespons (timeout)');
    } catch (e) {
      throw ApiException(0, 'Tidak dapat terhubung ke server');
    }

    Map<String, dynamic> json;
    try {
      json = jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException(response.statusCode, 'Respons server tidak valid');
    }

    if (response.statusCode >= 400 || json['success'] != true) {
      throw ApiException(
        response.statusCode,
        (json['message'] ?? 'Terjadi kesalahan').toString(),
        errors: (json['errors'] as List?) ?? const [],
      );
    }

    return json;
  }

  /// Jalankan request [fetch]; jika gagal (network/HTTP), kembalikan [fallback].
  /// [onError] dipanggil dengan pesan error untuk ditampilkan ke user.
  static Future<T> fetchOrFallback<T>(
    Future<T> Function() fetch, {
    required T fallback,
    void Function(String message)? onError,
  }) async {
    try {
      return await fetch();
    } on ApiException catch (e) {
      onError?.call(e.message);
      return fallback;
    } catch (_) {
      onError?.call('Terjadi kesalahan tidak terduga');
      return fallback;
    }
  }
}

final apiClient = ApiClient();
