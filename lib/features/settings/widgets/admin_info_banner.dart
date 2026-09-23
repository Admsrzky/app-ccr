import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class AdminInfoBanner extends StatelessWidget {
  const AdminInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Pengaturan Admin & Owner', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4)]),
              child: const Text('Akses Penuh / Owner & Supervisor', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ),
          ],
        ),
        NeomorphicContainer(
          borderRadius: 16,
          width: 40,
          height: 40,
          child: const Center(
            child: Icon(Icons.admin_panel_settings, size: 20, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
