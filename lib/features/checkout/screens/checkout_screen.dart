import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';
import '../widgets/checkout_header.dart';
import '../widgets/order_type_selector.dart';
import '../widgets/order_items_recap_card.dart';
import '../widgets/payment_methods_section.dart';
import '../widgets/success_payment_modal.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutProvider);
    final notifier = ref.read(checkoutProvider.notifier);

    final double subtotal = 110000;
    final double tax = 11000;
    final double totalBill = subtotal + tax;
    final double change = state.cashReceived > totalBill ? state.cashReceived - totalBill : 0;

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
                            Row(
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
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nomor Order', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                    Text('#CR-1049', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                  ],
                                ),
                              ],
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
                                  const Text('Meja 04 • Sarah A.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        OrderTypeSelector(state: state, notifier: notifier),
                        const SizedBox(height: 12),
                        // Customer Name Input (Optional)
                        NeomorphicContainer(
                          borderRadius: 12,
                          isInset: true,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline, size: 18, color: AppColors.outline),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(text: state.customerName),
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
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 24),
                        // Confirm Pay Button
                        NeomorphicContainer(
                          borderRadius: 16,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onTap: () => notifier.setSuccessModalVisible(true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                              const SizedBox(width: 8),
                              Text('Konfirmasi Bayar Rp ${_formatPrice(totalBill)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
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
