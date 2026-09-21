import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutState {
  final String selectedMethod; // 'qris', 'cash', 'edc', 'transfer'
  final bool isSummaryExpanded;
  final double cashReceived;
  final bool isSuccessModalVisible;
  final bool isPrinting;
  final String customerName;
  final String orderType; // 'Dine In' or 'Takeaway'

  const CheckoutState({
    this.selectedMethod = 'qris',
    this.isSummaryExpanded = true,
    this.cashReceived = 121000,
    this.isSuccessModalVisible = false,
    this.isPrinting = false,
    this.customerName = 'Bpk. Kevin',
    this.orderType = 'Dine In',
  });

  CheckoutState copyWith({
    String? selectedMethod,
    bool? isSummaryExpanded,
    double? cashReceived,
    bool? isSuccessModalVisible,
    bool? isPrinting,
    String? customerName,
    String? orderType,
  }) {
    return CheckoutState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
      isSummaryExpanded: isSummaryExpanded ?? this.isSummaryExpanded,
      cashReceived: cashReceived ?? this.cashReceived,
      isSuccessModalVisible: isSuccessModalVisible ?? this.isSuccessModalVisible,
      isPrinting: isPrinting ?? this.isPrinting,
      customerName: customerName ?? this.customerName,
      orderType: orderType ?? this.orderType,
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

  void setCustomerName(String name) {
    state = state.copyWith(customerName: name);
  }

  void setOrderType(String type) {
    state = state.copyWith(orderType: type);
  }
}

final checkoutProvider = StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier();
});
