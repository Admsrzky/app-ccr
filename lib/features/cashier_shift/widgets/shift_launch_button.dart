import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class ShiftLaunchButton extends StatelessWidget {
  final bool isLoading;
  final bool isShiftActive;
  final VoidCallback onPressed;

  const ShiftLaunchButton({
    super.key,
    required this.isLoading,
    required this.isShiftActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    String text;
    Widget icon;

    if (isLoading) {
      text = 'Membuka Kasir...';
      icon = const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      );
    } else if (isShiftActive) {
      text = 'Shift Dimulai!';
      icon = const Icon(Icons.check_circle, color: AppColors.primary, size: 20);
    } else {
      text = 'Buka Kasir & Mulai Shift';
      icon = const Icon(Icons.point_of_sale, color: AppColors.primary, size: 20);
    }

    return NeomorphicContainer(
      borderRadius: 14,
      onTap: isLoading ? null : onPressed,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
