import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../../core/utils/page_transitions.dart';
import '../screens/kitchen_receipt_screen.dart';

class ReceiptActionBar extends StatelessWidget {
  final bool isWhatsAppSent;
  final bool isPdfDownloaded;
  final bool isPrinting;
  final VoidCallback onWhatsAppTap;
  final VoidCallback onDownloadPdfTap;
  final VoidCallback onPrintTap;

  const ReceiptActionBar({
    super.key,
    required this.isWhatsAppSent,
    required this.isPdfDownloaded,
    required this.isPrinting,
    required this.onWhatsAppTap,
    required this.onDownloadPdfTap,
    required this.onPrintTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), offset: Offset(0, -4), blurRadius: 16),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 12,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onTap: onWhatsAppTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(isWhatsAppSent ? Icons.check : Icons.chat, size: 16, color: AppColors.primary),
                      const SizedBox(width: 6),
                      const Text('Kirim WhatsApp', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 12,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  onTap: onDownloadPdfTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(isPdfDownloaded ? Icons.check : Icons.download, size: 16, color: AppColors.secondary),
                      const SizedBox(width: 6),
                      const Text('Unduh PDF', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          NeomorphicContainer(
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(vertical: 14),
            onTap: onPrintTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(isPrinting ? Icons.autorenew : Icons.print, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(isPrinting ? 'Mencetak Struk...' : 'Cetak Struk Pelanggan', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          NeomorphicContainer(
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(vertical: 14),
            onTap: () {
              Navigator.push(
                context,
                AppRoute.fadeSlide(const KitchenReceiptScreen()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.restaurant, size: 18, color: AppColors.secondary),
                SizedBox(width: 8),
                Text('Lihat Struk Dapur (KOT)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.secondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
