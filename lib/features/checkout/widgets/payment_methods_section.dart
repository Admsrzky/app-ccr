import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';

class PaymentMethodsSection extends StatelessWidget {
  final CheckoutState state;
  final CheckoutNotifier notifier;
  final double totalBill;
  final double change;
  final String Function(double) formatPrice;
  final Future<String?> Function(BuildContext) showCustomCashDialog;

  const PaymentMethodsSection({
    super.key,
    required this.state,
    required this.notifier,
    required this.totalBill,
    required this.change,
    required this.formatPrice,
    required this.showCustomCashDialog,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('METODE PEMBAYARAN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant, letterSpacing: 0.5)),
            Row(
              children: const [
                Icon(Icons.bolt, size: 14, color: AppColors.tertiary),
                SizedBox(width: 4),
                Text('Instan Settlement', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.tertiary)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildMethodTab(notifier, state.selectedMethod, 'qris', Icons.qr_code_scanner, 'QRIS Digital'),
              const SizedBox(width: 8),
              _buildMethodTab(notifier, state.selectedMethod, 'cash', Icons.payments, 'Tunai (Cash)'),
              const SizedBox(width: 8),
              _buildMethodTab(notifier, state.selectedMethod, 'edc', Icons.credit_card, 'EDC Kartu'),
              const SizedBox(width: 8),
              _buildMethodTab(notifier, state.selectedMethod, 'transfer', Icons.account_balance, 'Transfer Bank'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (state.selectedMethod == 'qris') ...[
          NeomorphicContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                NeomorphicContainer(
                  borderRadius: 14,
                  width: 48,
                  height: 48,
                  child: const Center(
                    child: Icon(Icons.qr_code_scanner, color: AppColors.primary, size: 24),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'QRIS Outlet Aktif',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Silakan arahkan pelanggan untuk memindai stiker QRIS yang tertempel di kasir / meja untuk membayar Rp ${formatPrice(totalBill)}.',
                        style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else if (state.selectedMethod == 'cash') ...[
          NeomorphicContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Rekomendasi Uang Diterima:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 2.2,
                  children: [
                    _cashButton(notifier, state.cashReceived, totalBill, totalBill, 'Uang Pas'),
                    _cashButton(notifier, state.cashReceived, totalBill, 150000, 'Pecahan 150K'),
                    _cashButton(notifier, state.cashReceived, totalBill, 200000, 'Pecahan 2x 100K'),
                    GestureDetector(
                      onTap: () async {
                        String? res = await showCustomCashDialog(context);
                        if (res != null && double.tryParse(res) != null) {
                          notifier.setCashReceived(double.parse(res));
                        }
                      },
                      child: NeomorphicContainer(
                        borderRadius: 12,
                        padding: const EdgeInsets.all(10),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Input Manual', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                            Text('Nominal Lain...', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                NeomorphicContainer(
                  borderRadius: 12,
                  isInset: true,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Uang Kembali:', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                          Text('Rp ${formatPrice(change)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                      const Icon(Icons.toll, color: AppColors.primary, size: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else if (state.selectedMethod == 'edc') ...[
          NeomorphicContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    NeomorphicContainer(
                      borderRadius: 12,
                      width: 40,
                      height: 40,
                      child: const Center(child: Icon(Icons.point_of_sale, color: AppColors.primary)),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Swipe / Dip Kartu pada Mesin EDC', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text('Support BCA, Mandiri, BRI, Visa, Mastercard', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                NeomorphicContainer(
                  borderRadius: 12,
                  isInset: true,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nominal Tertera:', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                      Text('Rp ${formatPrice(totalBill)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ] else if (state.selectedMethod == 'transfer') ...[
          NeomorphicContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(16),
            child: NeomorphicContainer(
              borderRadius: 12,
              isInset: true,
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('BCA Bisnis (Chicken Crunchy Roll)', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                      Text('882-901-4431', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                    ],
                  ),
                  NeomorphicContainer(
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    onTap: () {
                      Clipboard.setData(const ClipboardData(text: '8829014431'));
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nomor Rekening disalin!')));
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.content_copy, size: 14, color: AppColors.primary),
                        SizedBox(width: 4),
                        Text('Salin', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMethodTab(CheckoutNotifier notifier, String current, String id, IconData icon, String label) {
    final isSelected = current == id;
    return GestureDetector(
      onTap: () => notifier.setPaymentMethod(id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                  BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                ],
                gradient: const LinearGradient(colors: [Color(0xFFDCDFE6), Color(0xFFF0F2F8)]),
              )
            : BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(3, 3), blurRadius: 6),
                  BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-3, -3), blurRadius: 6),
                ],
              ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? AppColors.primary : AppColors.secondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cashButton(CheckoutNotifier notifier, double currentReceived, double totalBill, double amount, String label) {
    final isSelected = currentReceived == amount;
    return GestureDetector(
      onTap: () => notifier.setCashReceived(amount),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? const [
                  BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                  BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                ]
              : const [
                  BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(3, 3), blurRadius: 6),
                  BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-3, -3), blurRadius: 6),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 2),
            Text('Rp ${formatPrice(amount)}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? AppColors.primary : AppColors.onSurface)),
          ],
        ),
      ),
    );
  }
}
