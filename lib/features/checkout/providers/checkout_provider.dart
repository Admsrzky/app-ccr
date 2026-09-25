import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../../cashier_shift/providers/cashier_provider.dart';
import '../../pos_dashboard/models/product_model.dart';
import '../../pos_dashboard/providers/pos_provider.dart';
import '../models/order_model.dart';

const double kTaxRate = 0.1;

class CheckoutItem {
  final ProductModel product;
  final int quantity;

  const CheckoutItem({required this.product, required this.quantity});

  double get lineTotal => product.price * quantity;

  Map<String, dynamic> toPayload() => {
        'productId': product.id,
        'productName': product.name,
        'unitPrice': product.price.round(),
        'quantity': quantity,
        'addons': <Map<String, dynamic>>[],
      };

  factory CheckoutItem.fromEntry(MapEntry<ProductModel, int> entry) =>
      CheckoutItem(product: entry.key, quantity: entry.value);
}

class CheckoutState {
  final String selectedMethod; // 'qris', 'cash', 'edc', 'transfer'
  final bool isSummaryExpanded;
  final double cashReceived;
  final bool isSuccessModalVisible;
  final bool isPrinting;
  final String customerName;
  final String tableNumber;
  final String orderType; // 'Dine In' or 'Takeaway'
  final List<CheckoutItem> items;
  final OrderModel? lastOrder;
  final bool isSubmitting;
  final bool isOffline;
  final String? errorMessage;

  const CheckoutState({
    this.selectedMethod = 'qris',
    this.isSummaryExpanded = true,
    this.cashReceived = 0,
    this.isSuccessModalVisible = false,
    this.isPrinting = false,
    this.customerName = '',
    this.tableNumber = '04',
    this.orderType = 'Dine In',
    this.items = const [],
    this.lastOrder,
    this.isSubmitting = false,
    this.isOffline = false,
    this.errorMessage,
  });

  CheckoutState copyWith({
    String? selectedMethod,
    bool? isSummaryExpanded,
    double? cashReceived,
    bool? isSuccessModalVisible,
    bool? isPrinting,
    String? customerName,
    String? tableNumber,
    String? orderType,
    List<CheckoutItem>? items,
    OrderModel? lastOrder,
    bool clearLastOrder = false,
    bool? isSubmitting,
    bool? isOffline,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CheckoutState(
      selectedMethod: selectedMethod ?? this.selectedMethod,
      isSummaryExpanded: isSummaryExpanded ?? this.isSummaryExpanded,
      cashReceived: cashReceived ?? this.cashReceived,
      isSuccessModalVisible: isSuccessModalVisible ?? this.isSuccessModalVisible,
      isPrinting: isPrinting ?? this.isPrinting,
      customerName: customerName ?? this.customerName,
      tableNumber: tableNumber ?? this.tableNumber,
      orderType: orderType ?? this.orderType,
      items: items ?? this.items,
      lastOrder: clearLastOrder ? null : (lastOrder ?? this.lastOrder),
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  int get totalQty => items.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal => items.fold(0, (sum, item) => sum + item.lineTotal);

  double get tax => (subtotal * kTaxRate).roundToDouble();

  double get totalBill => subtotal + tax;

  double get change =>
      selectedMethod == 'cash' && cashReceived > totalBill ? cashReceived - totalBill : 0;

  String get paymentLabel => switch (selectedMethod) {
        'cash' => 'Tunai (Cash)',
        'edc' => 'EDC Kartu',
        'transfer' => 'Transfer Bank',
        _ => 'QRIS (GoPay/BCA)',
      };
}

class CheckoutNotifier extends StateNotifier<CheckoutState> {
  CheckoutNotifier(this._ref) : super(const CheckoutState());

  final Ref _ref;

  void loadCart(List<MapEntry<ProductModel, int>> entries) {
    final items = entries.map(CheckoutItem.fromEntry).toList();
    state = state.copyWith(items: items, clearLastOrder: true, clearError: true);
  }

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

  void setTableNumber(String number) {
    state = state.copyWith(tableNumber: number);
  }

  void setOrderType(String type) {
    state = state.copyWith(orderType: type);
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }

  /// Kirim order ke API. Return true bila order tercatat (server / fallback offline).
  Future<bool> submitOrder() async {
    if (state.isSubmitting || state.items.isEmpty) return false;

    state = state.copyWith(isSubmitting: true, clearError: true);

    final cashierId = _ref.read(cashierProvider).cashierId;
    final payload = <String, dynamic>{
      'orderType': state.orderType,
      'paymentMethod': state.selectedMethod,
      'customerName': state.customerName.trim().isEmpty ? null : state.customerName.trim(),
      'tableNumber':
          state.orderType == 'Dine In' && state.tableNumber.trim().isNotEmpty
              ? state.tableNumber.trim()
              : null,
      'cashierId': cashierId.isEmpty ? null : cashierId,
      'cashReceived': state.selectedMethod == 'cash' ? state.cashReceived.round() : null,
      'items': state.items.map((item) => item.toPayload()).toList(),
    };

    try {
      final json = await apiClient.post('/orders', body: payload);
      final order = OrderModel.fromJson(json['data'] as Map<String, dynamic>);
      if (!mounted) return false;
      state = state.copyWith(
        isSubmitting: false,
        lastOrder: order,
        isSuccessModalVisible: true,
        isOffline: false,
        clearError: true,
      );
      _ref.read(posProvider.notifier).clearCart();
      return true;
    } on ApiException catch (e) {
      if (!mounted) return false;

      final isNetworkError = e.statusCode == 0 || e.statusCode == 408;
      if (!isNetworkError) {
        state = state.copyWith(isSubmitting: false, errorMessage: e.message);
        return false;
      }

      // Fallback offline: catat order secara lokal agar shift tetap jalan.
      final order = _buildLocalOrder(payload);
      state = state.copyWith(
        isSubmitting: false,
        lastOrder: order,
        isSuccessModalVisible: true,
        isOffline: true,
        errorMessage: 'Server tidak tersedia — order dicatat lokal, sinkron nanti',
      );
      _ref.read(posProvider.notifier).clearCart();
      return true;
    } catch (_) {
      if (!mounted) return false;
      state = state.copyWith(
        isSubmitting: false,
        errorMessage: 'Terjadi kesalahan tidak terduga',
      );
      return false;
    }
  }

  OrderModel _buildLocalOrder(Map<String, dynamic> payload) {
    double subtotal = 0;
    for (final item in state.items) {
      subtotal += item.lineTotal;
    }
    final tax = (subtotal * kTaxRate).roundToDouble();
    final total = subtotal + tax;
    final cash = payload['cashReceived'] as int?;
    final seq = 9000 + (DateTime.now().millisecondsSinceEpoch % 900);

    return OrderModel(
      id: 'local-${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: 'CR-$seq',
      customerName: payload['customerName'] as String?,
      tableNumber: payload['tableNumber'] as String?,
      orderType: state.orderType,
      paymentMethod: state.selectedMethod,
      status: 'paid',
      subtotal: subtotal,
      taxRate: kTaxRate,
      tax: tax,
      total: total,
      cashReceived: cash?.toDouble(),
      change: cash != null ? (cash - total).clamp(0, double.infinity) : null,
      cashierId: payload['cashierId'] as String?,
      cashierName: _ref.read(cashierProvider).cashierName,
      items: state.items
          .map((item) => OrderItemModel(
                productName: item.product.name,
                unitPrice: item.product.price,
                quantity: item.quantity,
                subtotal: item.lineTotal,
              ))
          .toList(),
      createdAt: DateTime.now(),
    );
  }

  /// Reset untuk order berikutnya (dipanggil dari tombol "Pesanan Baru").
  void startNewOrder() {
    state = state.copyWith(
      isSuccessModalVisible: false,
      clearLastOrder: true,
      items: const [],
      cashReceived: 0,
      customerName: '',
      clearError: true,
    );
  }
}

final checkoutProvider =
    StateNotifierProvider<CheckoutNotifier, CheckoutState>((ref) {
  return CheckoutNotifier(ref);
});
