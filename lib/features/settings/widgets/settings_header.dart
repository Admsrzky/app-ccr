import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), offset: Offset(0, 4), blurRadius: 16),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 44, height: 44),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ANDROID POS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.secondary, letterSpacing: 1)),
              Text('Pengaturan Outlet', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
            ],
          ),
          NeomorphicContainer(
            borderRadius: 999,
            width: 44,
            height: 44,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terminal ID: CCR-SENOPATI-POS02 • Online'))),
            child: const Center(
              child: Icon(Icons.settings, size: 20, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
