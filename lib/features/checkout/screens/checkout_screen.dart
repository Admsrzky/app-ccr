import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../cashier_shift/providers/cashier_provider.dart';
import '../../pos_dashboard/providers/pos_provider.dart';
import '../providers/checkout_provider.dart';
import '../widgets/checkout_header.dart';
import '../widgets/order_type_selector.dart';
import '../widgets/order_items_recap_card.dart';
import '../widgets/payment_methods_section.dart';
import '../widgets/success_payment_modal.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  late final TextEditingController _customerNameController;
  late final TextEditingController _tableController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(checkoutProvider);
    _customerNameController = TextEditingController(text: state.customerName);
    _tableController = TextEditingController(text: state.tableNumber);
    Future.microtask(() {
      final entries = ref.read(posProvider.notifier).cartEntries;
      ref.read(checkoutProvider.notifier).loadCart(entries);
    });
  }

  @override
  void dispose() {
    _customerNameController.dispose();
    _tableController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final notifier = ref.read(checkoutProvider.notifier);
    await notifier.submitOrder();
    if (!mounted) return;
    final state = ref.read(checkoutProvider);
    if (!state.isSuccessModalVisible && state.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.errorMessage!)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkoutProvider);
    final notifier = ref.read(checkoutProvider.notifier);
    final cashierName = ref.watch(cashierProvider).cashierName;

    final subtotal = state.subtotal;
    final tax = state.tax;
    final totalBill = state.totalBill;
    final change = state.change;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const CheckoutHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status & Table Info Pill
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  NeomorphicContainer(
                                    borderRadius: 12,
                                    width: 36,
                                    height: 36,
                                    child: const Center(
                                      child: Icon(Icons.receipt_long, color: AppColors.primary, size: 20),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('Nomor Order', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                      Text(
                                        state.lastOrder != null ? '#${state.lastOrder!.orderNumber}' : 'Order Baru',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            NeomorphicContainer(
                              borderRadius: 12,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    state.orderType == 'Dine In'
                                        ? 'Meja ${state.tableNumber.isEmpty ? '-' : state.tableNumber} • $cashierName'
                                        : 'Takeaway • $cashierName',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OrderTypeSelector(state: state, notifier: notifier),
                        const SizedBox(height: 12),
                        // Customer Name & Table Number Input
                        Row(
                          children: [
                            Expanded(
                              child: NeomorphicContainer(
                                borderRadius: 12,
                                isInset: true,
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    const Icon(Icons.person_outline, size: 18, color: AppColors.outline),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        controller: _customerNameController,
                                        onChanged: (val) => notifier.setCustomerName(val),
                                        decoration: const InputDecoration(
                                          hintText: 'Nama Pelanggan (Opsional)',
                                          hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                                          border: InputBorder.none,
                                        ),
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.onSurface),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (state.orderType == 'Dine In') ...[
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 90,
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.table_restaurant_outlined, size: 18, color: AppColors.outline),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: TextField(
                                          controller: _tableController,
                                          onChanged: (val) => notifier.setTableNumber(val),
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: 'No. Meja',
                                            hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                                            border: InputBorder.none,
                                          ),
                                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.onSurface),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (state.items.isEmpty)
                          NeomorphicContainer(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(24),
                            child: const Center(
                              child: Text(
                                'Belum ada item di keranjang.\nTambahkan produk terlebih dahulu dari dashboard POS.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
                              ),
                            ),
                          )
                        else ...[
                          OrderItemsRecapCard(
                            state: state,
                            notifier: notifier,
                            subtotal: subtotal,
                            tax: tax,
                            totalBill: totalBill,
                            formatPrice: _formatPrice,
                          ),
                          const SizedBox(height: 20),
                          PaymentMethodsSection(
                            state: state,
                            notifier: notifier,
                            totalBill: totalBill,
                            change: change,
                            formatPrice: _formatPrice,
                            showCustomCashDialog: _showCustomCashDialog,
                          ),
                        ],
                        const SizedBox(height: 24),
                        // Confirm Pay Button
                        NeomorphicContainer(
                          borderRadius: 16,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onTap: state.items.isEmpty || state.isSubmitting ? null : _submit,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              state.isSubmitting
                                  ? const SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                                    )
                                  : const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                              const SizedBox(width: 8),
                              Text(
                                state.isSubmitting
                                    ? 'Memproses order...'
                                    : 'Konfirmasi Bayar Rp ${_formatPrice(totalBill)}',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SuccessPaymentModal(
              state: state,
              notifier: notifier,
              totalBill: totalBill,
              formatPrice: _formatPrice,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _showCustomCashDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Input Nominal Tunai'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Contoh: 150000'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
