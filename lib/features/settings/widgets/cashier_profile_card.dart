import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class CashierProfileCard extends StatelessWidget {
  const CashierProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeomorphicContainer(
                borderRadius: 14,
                width: 64,
                height: 64,
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDz77hkX202Nw0LnyUIIDF80qu2euN7KwaclONf_A1LFeu3aFEzo1UF66Wyvi6BLC64oiG14DNH11cIGc_aRdc3YUijRzd-unSzy02I09udnAqAJDV2JvbfS1klPZLuLYxMKh_IgKb3jYocbbLNMdUbVm-HkLpDVl8vfg4Rk6BAIXSiqPMCwKxz5wrNg4VT6IhfwkoAWjCZfpEoWqQkwdVDZUwv6QACpI3dwiR7pNxH7kLw_6yqstuj',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999)),
                      child: const Text('Shift Pagi Aktif • Kasir #02', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ),
                    const SizedBox(height: 4),
                    const Text('Sarah Amelia', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    const Text('Supervisor & Kasir Utama', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Quick Info Badges
          Row(
            children: [
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 12,
                  isInset: true,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.badge, size: 18, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('ID Staf', style: TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant)),
                          const Text('CCR-8821', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 12,
                  isInset: true,
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule, size: 18, color: AppColors.tertiary),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Jam Masuk', style: TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant)),
                          const Text('08:30 WIB', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 12,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit Profil Kasir'))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 16, color: AppColors.primary),
                      SizedBox(width: 6),
                      Text('Edit Profil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 12,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ganti PIN Akses'))),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.key, size: 16, color: AppColors.onSurface),
                      SizedBox(width: 6),
                      Text('Ganti PIN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
