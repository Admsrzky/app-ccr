import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/cashier_session.dart';

class CashierNotifier extends StateNotifier<CashierSession> {
  CashierNotifier() : super(const CashierSession());

  void enterPin(String digit, Function(bool success) onShiftStarted) {
    if (state.pinCode.length < 4 && !state.isLoading && !state.isShiftActive) {
      final newPin = state.pinCode + digit;
      state = state.copyWith(pinCode: newPin);

      if (newPin.length == 4) {
        startShift(onShiftStarted);
      }
    }
  }

  void deletePin() {
    if (state.pinCode.isNotEmpty && !state.isLoading && !state.isShiftActive) {
      state = state.copyWith(pinCode: state.pinCode.substring(0, state.pinCode.length - 1));
    }
  }

  void biometricLogin(Function(bool success) onShiftStarted) {
    if (!state.isLoading && !state.isShiftActive) {
      state = state.copyWith(pinCode: '9999');
      startShift(onShiftStarted);
    }
  }

  Future<void> startShift(Function(bool success) onShiftStarted) async {
    if (state.isLoading || state.isShiftActive) return;

    state = state.copyWith(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    state = state.copyWith(
      isLoading: false,
      isShiftActive: true,
    );

    onShiftStarted(true);
  }

  void endShift() {
    state = const CashierSession();
  }

  void switchCashier(String newName, String newRole) {
    state = state.copyWith(
      cashierName: newName,
      cashierRole: newRole,
      pinCode: '',
    );
  }
}

final cashierProvider = StateNotifierProvider<CashierNotifier, CashierSession>((ref) {
  return CashierNotifier();
});
