import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class OperationalFooter extends StatelessWidget {
  const OperationalFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.cloud_done,
                size: 14,
                color: AppColors.primary,
              ),
              const SizedBox(width: 4),
              const Text(
                'Online POS v2.4.1',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.devices,
                size: 14,
                color: AppColors.secondary,
              ),
              const SizedBox(width: 4),
              const Text(
                'Terminal POS-02',
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
