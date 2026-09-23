import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class PrinterActionButtons extends StatelessWidget {
  const PrinterActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NeomorphicContainer(
          borderRadius: 14,
          padding: const EdgeInsets.symmetric(vertical: 16),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengaturan printer thermal & format struk berhasil disimpan!'))),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.save, size: 20, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Simpan Konfigurasi Printer', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        NeomorphicContainer(
          borderRadius: 14,
          isInset: true,
          padding: const EdgeInsets.symmetric(vertical: 14),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cetak lembar diagnosa koneksi & alignment...'))),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.print, size: 18, color: AppColors.onSurfaceVariant),
              SizedBox(width: 8),
              Text('Cetak Halaman Uji Lengkap (Self-Test Page)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
            ],
          ),
        ),
      ],
    );
  }
}
