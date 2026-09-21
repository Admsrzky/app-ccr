import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class StoreHeroCard extends StatelessWidget {
  const StoreHeroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(color: Color(0x08000000), offset: Offset(2, 2), blurRadius: 4, spreadRadius: -1),
                    BoxShadow(color: Color(0x99FFFFFF), offset: Offset(-2, -2), blurRadius: 4, spreadRadius: -1),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.tag, size: 14, color: AppColors.primary),
                    SizedBox(width: 4),
                    Text('CCR-JKT-01', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(color: Color(0x08000000), offset: Offset(2, 2), blurRadius: 4, spreadRadius: -1),
                    BoxShadow(color: Color(0x99FFFFFF), offset: Offset(-2, -2), blurRadius: 4, spreadRadius: -1),
                  ],
                ),
                child: Row(
                  children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('Aktif / Buka', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Logo Avatar
          Stack(
            alignment: Alignment.center,
            children: [
              NeomorphicContainer(
                borderRadius: 999,
                width: 100,
                height: 100,
                padding: const EdgeInsets.all(6),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida/AEtjO1WNNYWJG_hysU6DyW0zPliMgmAAmXRZxv5guQgwMG3XejB8Opgw66UrHEdAowdLlGOgIWCxPWg4NI6hrXV3ZBXeGMfCs2Skwz7LcLrSvQQUv4hl_QcQvX9YtUhOMtQ9MO4Y0ToRYGJTqHIrodOc2lhafgo-WgYQUDauFY0Q1-J7pZoOkUOSajHGfigqtwISzpEY0VH-ZST5B1f1uwJbL8JR_Zz3szHgp7H-ki2SWJfbIb9r1LFwG6gdYw',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.store, size: 40, color: AppColors.primary),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: NeomorphicContainer(
                  borderRadius: 999,
                  width: 34,
                  height: 34,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ubah Logo Struk'))),
                  child: const Center(
                    child: Icon(Icons.photo_camera, size: 16, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Chicken Crunchy Roll', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          const SizedBox(height: 2),
          const Text('Cabang Senopati 01 • Flagship Store', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
          const SizedBox(height: 14),
          NeomorphicContainer(
            borderRadius: 999,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ubah Logo Struk...'))),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.receipt_long, size: 16, color: AppColors.primary),
                SizedBox(width: 6),
                Text('Ubah Logo Struk', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
