import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutState {
  final String selectedMethod; // 'qris', 'cash', 'edc', 'transfer'
  final bool isSummaryExpanded;
  final double cashReceived;
  final bool isSuccessModalVisible;
  final bool isPrinting;

  const CheckoutState({
    this.selectedMethod = 'qris',
    this.isSummaryExpanded = true,
    this.cashReceived = 121000,
    this.isSuccessModalVisible = false,
    this.isPrinting = false,
  });

  CheckoutState copyWith({
    String? selectedMethod,
    bool? isSummaryExpanded,
    double? cashReceived,
    bool? isSuccessModalVisible,
    bool? isPrinting,
  }) {
    return CheckoutState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
      isSummaryExpanded: isSummaryExpanded ?? this.isSummaryExpanded,
      cashReceived: cashReceived ?? this.cashReceived,
      isSuccessModalVisible: isSuccessModalVisible ?? this.isSuccessModalVisible,
      isPrinting: isPrinting ?? this.isPrinting,
    );
  }
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier() : super(const CheckoutState());

  void setPaymentMethod(String method) {
    state = state.copyWith(selectedMethod: method);
  }

  void toggleSummaryExpanded() {
    state = state.copyWith(isSummaryExpanded: !state.isSummaryExpanded);
  }

  void setCashReceived(double amount) {
    state = state.copyWith(cashReceived: amount);
  }

  void setSuccessModalVisible(bool visible) {
    state = state.copyWith(isSuccessModalVisible: visible);
  }

  void setPrinting(bool printing) {
    state = state.copyWith(isPrinting: printing);
  }
}

final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
});
