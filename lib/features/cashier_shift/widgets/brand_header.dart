import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class BrandHeader extends StatefulWidget {
  const BrandHeader({super.key});

  @override
  State<BrandHeader> createState() => _BrandHeaderState();
}

class _BrandHeaderState extends State<BrandHeader> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Brand & Mascot Extruded Emblem
        Stack(
          alignment: Alignment.center,
          children: [
            NeomorphicContainer(
              borderRadius: 999,
              width: 112,
              height: 112,
              child: Center(
                child: NeomorphicContainer(
                  borderRadius: 999,
                  width: 80,
                  height: 80,
                  padding: const EdgeInsets.all(8),
                  isInset: true,
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuA7MkxtrL7thVUMWnDJcquOboUmLMXH_5jSIRDj_YQczCMoT6AWvmmu3U5oOVcl1r9IY9_LGysN1b47Ez1k7l23_4aDjg3cyE0JbhlzUfJyCWHtZWik_ZBgKJIuk4uhR92RuMawk1SymjvPORfhgEm1maombKGv6UxHVwRrKNseOxVa0ExrCf3abKHzEH03xaRJZ5I_OeLtvzL9T5ZDIsDcnN-xWfj_lfezvp7jQ3Ra83aRhtXVXx98',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.fastfood,
                      color: AppColors.primary,
                      size: 36,
                    ),
                  ),
                ),
              ),
            ),
            // Pulsing status dot top-right
            Positioned(
              top: 8,
              right: 8,
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 16 * _pulseController.value,
                        height: 16 * _pulseController.value,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary.withOpacity(0.6 * (1 - _pulseController.value)),
                        ),
                      ),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Title & Subtitle
        Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Chicken Crunchy Roll',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  NeomorphicContainer(
                    borderRadius: 999,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: const Text(
                      'POS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Cita Rasa Gurih & Renyah di Setiap Gulungan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
