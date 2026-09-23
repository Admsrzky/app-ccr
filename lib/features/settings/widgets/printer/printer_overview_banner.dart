import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class PrinterOverviewBanner extends StatelessWidget {
  const PrinterOverviewBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  NeomorphicContainer(
                    borderRadius: 12,
                    width: 44,
                    height: 44,
                    child: const Center(
                      child: Icon(Icons.print, size: 24, color: AppColors.primary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PERANGKAT KERAS',
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 1),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Manajemen Cetak & Hardware',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                    ],
                  ),
                ],
              ),
              NeomorphicContainer(
                borderRadius: 999,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 6),
                    const Text('BT & USB Aktif', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Kelola koneksi printer kasir & dapur, ukuran kertas, serta format cetakan struk untuk efisiensi transaksi harian.',
            style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, height: 1.4),
          ),
        ],
      ),
    );
  }
}
