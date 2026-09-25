import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../models/store_model.dart';

const kFallbackStore = StoreModel(
  id: 'store-ccr',
  brandName: 'Chicken Crunchy Roll',
  branchName: 'Outlet Senopati 01',
  slogan: 'Renyahnya Bikin Nagih',
  businessType: 'Ayam Crispy',
  storeCode: 'CCR-JKT-01',
  address: 'Jl. Senopati No. 45, Kebayoran Baru, Jakarta Selatan',
  latitude: '-6.2285',
  longitude: '106.8091',
  phone: '0812-3456-7890',
  email: 'halo@chickencrunchyroll.id',
  instagram: '@chickencrunchyroll',
  tagline: 'Crunchy Outside, Juicy Inside',
  isOpen: true,
  hours: [
    StoreHoursModel(day: 'Senin', openTime: '10:00', closeTime: '22:00'),
    StoreHoursModel(day: 'Selasa', openTime: '10:00', closeTime: '22:00'),
    StoreHoursModel(day: 'Rabu', openTime: '10:00', closeTime: '22:00'),
    StoreHoursModel(day: 'Kamis', openTime: '10:00', closeTime: '22:00'),
    StoreHoursModel(day: 'Jumat', openTime: '10:00', closeTime: '21:00', isClosed: true),
    StoreHoursModel(day: 'Sabtu', openTime: '10:00', closeTime: '22:00'),
    StoreHoursModel(day: 'Minggu', openTime: '10:00', closeTime: '22:00'),
  ],
  printers: [
    PrinterModel(
      id: 'printer-kasir-1',
      name: 'Printer Kasir 1',
      model: 'Epson TM-T82X',
      connectionType: 'USB',
      macAddress: '00:11:22:33:44:55',
      paperWidth: '80mm',
      isActive: true,
    ),
    PrinterModel(
      id: 'printer-kasir-2',
      name: 'Printer Kasir 2',
      model: 'Zijiang POS-5802',
      connectionType: 'Network',
      ipAddress: '192.168.1.120:9100',
      macAddress: '66:77:88:99:AA:BB',
      paperWidth: '58mm',
      isActive: true,
    ),
  ],
);

const kProfileDraftKeys = [
  'brandName',
  'branchName',
  'slogan',
  'businessType',
  'address',
  'phone',
  'email',
  'instagram',
  'tagline',
];

class StoreState {
  final StoreModel store;
  final Map<String, String> draft;
  final bool isLoading;
  final bool isSaving;
  final bool isOffline;
  final String? errorMessage;

  const StoreState({
    this.store = kFallbackStore,
    this.draft = const {},
    this.isLoading = false,
    this.isSaving = false,
    this.isOffline = false,
    this.errorMessage,
  });

  StoreState copyWith({
    StoreModel? store,
    Map<String, String>? draft,
    bool? isLoading,
    bool? isSaving,
    bool? isOffline,
    String? errorMessage,
    bool clearError = false,
    bool clearDraft = false,
  }) {
    return StoreState(
      store: store ?? this.store,
      draft: clearDraft ? const {} : (draft ?? this.draft),
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  /// Nilai tampilan untuk field profil: draft (belum disimpan) menang atas data toko.
  String displayValue(String key) {
    final d = draft[key];
    if (d != null) return d;
    return switch (key) {
      'brandName' => store.brandName,
      'branchName' => store.branchName,
      'slogan' => store.slogan ?? '',
      'businessType' => store.businessType ?? '',
      'address' => store.address ?? '',
      'phone' => store.phone ?? '',
      'email' => store.email ?? '',
      'instagram' => store.instagram ?? '',
      'tagline' => store.tagline ?? '',
      _ => '',
    };
  }

  bool get hasUnsavedDraft => draft.isNotEmpty;
}

class StoreNotifier extends StateNotifier<StoreState> {
  StoreNotifier() : super(const StoreState()) {
    load();
  }

  bool _isNetworkError(ApiException e) => e.statusCode == 0 || e.statusCode == 408;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final json = await apiClient.get('/store');
      final store = StoreModel.fromJson(json['data'] as Map<String, dynamic>);
      if (!mounted) return;
      state = state.copyWith(
        store: store,
        isLoading: false,
        isOffline: false,
        clearDraft: true,
        clearError: true,
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        isOffline: true,
        errorMessage: 'Profil toko offline — menampilkan data lokal (${e.message})',
      );
    } catch (_) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        isOffline: true,
        errorMessage: 'Profil toko offline — menampilkan data lokal',
      );
    }
  }

  void setDraft(String key, String value) {
    final draft = Map<String, String>.from(state.draft);
    if (value == _serverValue(key)) {
      draft.remove(key);
    } else {
      draft[key] = value;
    }
    state = state.copyWith(draft: draft, clearError: true);
  }

  String _serverValue(String key) => switch (key) {
        'brandName' => state.store.brandName,
        'branchName' => state.store.branchName,
        'slogan' => state.store.slogan ?? '',
        'businessType' => state.store.businessType ?? '',
        'address' => state.store.address ?? '',
        'phone' => state.store.phone ?? '',
        'email' => state.store.email ?? '',
        'instagram' => state.store.instagram ?? '',
        'tagline' => state.store.tagline ?? '',
        _ => '',
      };

  /// Simpan perubahan profil ke server. Return true bila tersimpan (server / lokal).
  Future<bool> saveProfile() async {
    if (state.isSaving) return false;
    if (state.draft.isEmpty) return true;

    state = state.copyWith(isSaving: true, clearError: true);
    final draft = Map<String, String>.from(state.draft);

    try {
      final json = await apiClient.patch('/store', body: draft);
      final store = StoreModel.fromJson(json['data'] as Map<String, dynamic>);
      if (!mounted) return false;
      state = state.copyWith(
        store: store,
        isSaving: false,
        isOffline: false,
        clearDraft: true,
        clearError: true,
      );
      return true;
    } on ApiException catch (e) {
      if (!mounted) return false;

      if (_isNetworkError(e)) {
        // Terapkan draft secara lokal agar user tetap bisa bekerja.
        state = state.copyWith(
          store: _applyDraft(state.store, draft),
          isSaving: false,
          isOffline: true,
          clearDraft: true,
          errorMessage: 'Server tidak tersedia — perubahan disimpan lokal',
        );
        return true;
      }

      state = state.copyWith(isSaving: false, errorMessage: e.message);
      return false;
    } catch (_) {
      if (!mounted) return false;
      state = state.copyWith(isSaving: false, errorMessage: 'Terjadi kesalahan tidak terduga');
      return false;
    }
  }

  StoreModel _applyDraft(StoreModel store, Map<String, String> draft) => store.copyWith(
        brandName: draft['brandName'],
        branchName: draft['branchName'],
        slogan: draft['slogan'],
        businessType: draft['businessType'],
        address: draft['address'],
        phone: draft['phone'],
        email: draft['email'],
        instagram: draft['instagram'],
        tagline: draft['tagline'],
      );

  /// Update jam operasional satu hari (optimistic, lalu sinkron ke API).
  Future<void> updateHours(
    String day, {
    String? openTime,
    String? closeTime,
    bool? isClosed,
  }) async {
    final hours = state.store.hours.map((h) {
      if (h.day != day) return h;
      return h.copyWith(openTime: openTime, closeTime: closeTime, isClosed: isClosed);
    }).toList();

    state = state.copyWith(store: state.store.copyWith(hours: hours), clearError: true);

    try {
      await apiClient.patch('/store/hours/$day', body: {
        'openTime': ?openTime,
        'closeTime': ?closeTime,
        'isClosed': ?isClosed,
      });
    } on ApiException catch (e) {
      if (!mounted) return;
      if (_isNetworkError(e)) {
        state = state.copyWith(
          isOffline: true,
          errorMessage: 'Server tidak tersedia — jam $day diperbarui lokal',
        );
      } else {
        state = state.copyWith(errorMessage: e.message);
      }
    }
  }

  /// Toggle status buka/tutup satu hari.
  Future<void> toggleDay(String day) async {
    final current = state.store.hours.firstWhere(
      (h) => h.day == day,
      orElse: () => const StoreHoursModel(day: '', openTime: '', closeTime: ''),
    );
    if (current.day.isEmpty) return;
    await updateHours(day, isClosed: !current.isClosed);
  }

  /// Aktif/nonaktifkan printer (optimistic, lalu sinkron ke API).
  Future<void> setPrinterActive(String id, bool active) async {
    final printers = state.store.printers
        .map((p) => p.id == id ? p.copyWith(isActive: active) : p)
        .toList();

    state = state.copyWith(store: state.store.copyWith(printers: printers), clearError: true);

    try {
      await apiClient.patch('/store/printers/$id', body: {'isActive': active});
    } on ApiException catch (e) {
      if (!mounted) return;
      if (_isNetworkError(e)) {
        state = state.copyWith(
          isOffline: true,
          errorMessage: 'Server tidak tersedia — status printer diperbarui lokal',
        );
      } else {
        state = state.copyWith(errorMessage: e.message);
      }
    }
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

final storeProvider = StateNotifierProvider<StoreNotifier, StoreState>((ref) {
  return StoreNotifier();
});
