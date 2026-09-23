import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class ReceiptHeader extends StatelessWidget {
  final bool isPrinting;
  final VoidCallback onPrintTap;

  const ReceiptHeader({
    super.key,
    required this.isPrinting,
    required this.onPrintTap,
  });

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
          NeomorphicContainer(
            borderRadius: 999,
            width: 44,
            height: 44,
            onTap: () => Navigator.pop(context),
            child: const Center(
              child: Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.onSurface),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ANDROID POS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.secondary, letterSpacing: 1)),
              Text('Struk Pelanggan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
            ],
          ),
          NeomorphicContainer(
            borderRadius: 999,
            width: 44,
            height: 44,
            onTap: onPrintTap,
            child: Center(
              child: Icon(
                isPrinting ? Icons.autorenew : Icons.print,
                size: 20,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
