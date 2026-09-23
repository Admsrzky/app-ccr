import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../../core/utils/page_transitions.dart';
import '../providers/checkout_provider.dart';
import '../screens/receipt_screen.dart';

class SuccessPaymentModal extends StatelessWidget {
  final CheckoutState state;
  final CheckoutNotifier notifier;
  final double totalBill;
  final String Function(double) formatPrice;

  const SuccessPaymentModal({
    super.key,
    required this.state,
    required this.notifier,
    required this.totalBill,
    required this.formatPrice,
  });

  @override
  Widget build(BuildContext context) {
    if (!state.isSuccessModalVisible) return const SizedBox.shrink();

    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(color: Color(0x20000000), blurRadius: 24, offset: Offset(0, 10)),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NeomorphicContainer(
                borderRadius: 20,
                width: 64,
                height: 64,
                child: const Center(
                  child: Icon(Icons.verified, size: 32, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 4, offset: Offset(2, 2))]),
                child: const Text('Lunas • ID: TR-20241012', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ),
              const SizedBox(height: 8),
              const Text('Transaksi Berhasil!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              const SizedBox(height: 4),
              const Text('Pesanan #CR-1049 telah diteruskan ke dapur roll dan tercatat pada cloud POS.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
              const SizedBox(height: 16),
              NeomorphicContainer(
                borderRadius: 12,
                isInset: true,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _receiptRow('Metode Bayar:', state.selectedMethod.toUpperCase()),
                    const SizedBox(height: 4),
                    _receiptRow('Waktu:', 'Hari ini, 13:42 WIB'),
                    const SizedBox(height: 4),
                    _receiptRow('Total Dibayar:', 'Rp ${formatPrice(totalBill)}', isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Quick Action Buttons
              NeomorphicContainer(
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(vertical: 12),
                onTap: () {
                  notifier.setSuccessModalVisible(false);
                  Navigator.push(
                    context,
                    AppRoute.fadeSlide(const ReceiptScreen()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt, size: 16, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('Lihat Struk Pelanggan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              NeomorphicContainer(
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(vertical: 12),
                onTap: () {
                  notifier.setPrinting(true);
                  Future.delayed(const Duration(seconds: 1), () {
                    if (!context.mounted) return;
                    notifier.setPrinting(false);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Struk thermal sukses dicetak!')));
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.print, size: 16, color: AppColors.primary),
                    const SizedBox(width: 8),
                    Text(state.isPrinting ? 'Mencetak...' : 'Cetak Struk Thermal (Bluetooth)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              NeomorphicContainer(
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(vertical: 12),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link struk terkirim via WhatsApp')));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat, size: 16, color: AppColors.tertiary),
                    SizedBox(width: 8),
                    Text('Kirim Struk via WhatsApp', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              NeomorphicContainer(
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(vertical: 12),
                onTap: () {
                  notifier.setSuccessModalVisible(false);
                  Navigator.pop(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, size: 16, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('Pesanan Baru (+)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _receiptRow(String title, String val, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
        Text(val, style: TextStyle(fontSize: 11, fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: isBold ? AppColors.primary : AppColors.onSurface)),
      ],
    );
  }
}
