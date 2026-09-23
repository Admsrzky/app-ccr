import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class ReceiptPreviewSection extends StatelessWidget {
  const ReceiptPreviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.visibility, size: 18, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'PRATINJAU KERTAS 80MM',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface, letterSpacing: 0.5),
                  ),
                ],
              ),
              Text('EMULASI POS', style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        NeomorphicContainer(
          borderRadius: 16,
          padding: const EdgeInsets.all(16),
          child: NeomorphicContainer(
            borderRadius: 12,
            isInset: true,
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('CHICKEN CRUNCHY ROLL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, fontFamily: 'monospace', letterSpacing: 1)),
                const SizedBox(height: 2),
                const Text('Grand City Mall Lt. 2 • Kasir: Indah', style: TextStyle(fontSize: 9, fontFamily: 'monospace', color: AppColors.onSurfaceVariant)),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 8),
                _previewRow('1x Crunchy Roll Spicy BBQ', 'Rp 28.000'),
                const SizedBox(height: 4),
                _previewRow('1x Teh Tarik Original', 'Rp 12.000'),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 1),
                const SizedBox(height: 8),
                _previewRow('TOTAL BAYAR', 'Rp 40.000', isBold: true),
                const SizedBox(height: 12),
                const Text(
                  '*** Terima kasih atas kunjungannya! Nikmati gurih & renyahnya roll kami ***',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 8, fontFamily: 'monospace', color: AppColors.onSurfaceVariant, height: 1.3),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _previewRow(String item, String price, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(item, style: TextStyle(fontSize: 10, fontFamily: 'monospace', fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        Text(price, style: TextStyle(fontSize: 10, fontFamily: 'monospace', fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? AppColors.primary : AppColors.onSurface)),
      ],
    );
  }
}
