import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../models/cashier_model.dart';
import '../models/cashier_session.dart';

class CashierNotifier extends StateNotifier<CashierSession> {
  CashierNotifier() : super(const CashierSession());

  static const Map<String, CashierModel> _offlineCashiers = {
    '1234': CashierModel(
      id: 'cashier-sarah',
      name: 'Sarah Amelia',
      role: 'Kasir #02',
      branchName: 'Cabang Senopati',
    ),
    '9999': CashierModel(
      id: 'cashier-admin',
      name: 'Google Auth (Owner / Manager)',
      role: 'Admin Outlet',
      branchName: 'Cabang Senopati',
    ),
  };

  void enterPin(String digit, Function(bool success) onLoggedIn) {
    if (state.pinCode.length < 4 && !state.isLoading && !state.isLoggedIn) {
      final newPin = state.pinCode + digit;
      state = state.copyWith(pinCode: newPin, clearError: true);

      if (newPin.length == 4) {
        login(onLoggedIn);
      }
    }
  }

  void deletePin() {
    if (state.pinCode.isNotEmpty && !state.isLoading && !state.isLoggedIn) {
      state = state.copyWith(
        pinCode: state.pinCode.substring(0, state.pinCode.length - 1),
        clearError: true,
      );
    }
  }

  void biometricLogin(Function(bool success) onLoggedIn) {
    if (!state.isLoading && !state.isLoggedIn) {
      state = state.copyWith(pinCode: '9999', clearError: true);
      login(onLoggedIn);
    }
  }

  Future<void> googleLogin(Function(bool success) onLoginSuccess) async {
    if (state.isLoading || state.isLoggedIn) return;

    state = state.copyWith(isLoading: true, clearError: true);

    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;

    state = state.copyWith(
      isLoading: false,
      isLoggedIn: true,
      cashierId: 'cashier-admin',
      cashierName: 'Google Auth (Owner / Manager)',
      cashierRole: 'Admin Outlet',
    );

    onLoginSuccess(true);
  }

  Future<void> login(Function(bool success) onLoggedIn) async {
    if (state.isLoading || state.isLoggedIn) return;
    final pin = state.pinCode;
    if (pin.length != 4) return;

    state = state.copyWith(isLoading: true, clearError: true);

    CashierModel? cashier;
    String? error;
    bool offline = false;

    try {
      final json = await apiClient.post('/auth/login', body: {'pin': pin});
      cashier = CashierModel.fromJson(json['data'] as Map<String, dynamic>);
    } on ApiException catch (e) {
      error = e.message;
      // Fallback offline: PIN demo dikenali lokal
      final local = _offlineCashiers[pin];
      if (local != null) {
        cashier = local;
        offline = true;
        error = 'Server tidak tersedia — masuk mode offline';
      }
    }

    if (!mounted) return;

    if (cashier == null) {
      state = state.copyWith(
        isLoading: false,
        pinCode: '',
        errorMessage: error ?? 'Login gagal',
      );
      onLoggedIn(false);
      return;
    }

    state = state.copyWith(
      isLoading: false,
      isLoggedIn: true,
      isOffline: offline,
      cashierId: cashier.id,
      cashierName: cashier.name,
      cashierRole: cashier.role,
      branchName: cashier.branchName,
      errorMessage: offline ? error : null,
      clearError: !offline,
    );
    onLoggedIn(true);
  }

  void logout() {
    state = const CashierSession();
  }

  void switchCashier(String newName, String newRole) {
    state = state.copyWith(
      cashierName: newName,
      cashierRole: newRole,
      pinCode: '',
      clearError: true,
    );
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

final cashierProvider = StateNotifierProvider<CashierNotifier, CashierSession>((ref) {
  return CashierNotifier();
});
