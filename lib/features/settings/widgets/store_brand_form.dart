import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class StoreBrandForm extends StatelessWidget {
  const StoreBrandForm({super.key});

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.badge, size: 20, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Informasi Brand & Usaha', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('Nama Usaha / Brand', 'Chicken Crunchy Roll', Icons.store),
          const SizedBox(height: 12),
          _buildTextField('Nama Cabang / Outlet', 'Cabang Senopati 01', Icons.apartment),
          const SizedBox(height: 12),
          _buildTextField('Slogan / Tagline Cetak Struk', 'Crunchy, Cheesy, Happy!', Icons.format_quote),
          const SizedBox(height: 12),
          _buildTextField('Kategori Usaha', 'Restoran Cepat Saji & Snack Roll', Icons.fastfood),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant)),
        const SizedBox(height: 6),
        NeomorphicContainer(
          borderRadius: 12,
          isInset: true,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: initialValue),
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
