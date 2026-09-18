import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class NeomorphicKeypad extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onBiometricPressed;

  const NeomorphicKeypad({
    super.key,
    required this.onKeyPressed,
    required this.onDeletePressed,
    required this.onBiometricPressed,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 320),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 1.25,
        children: [
          ...keys.map((key) => _buildKeyButton(
                label: key,
                onTap: () => onKeyPressed(key),
              )),
          // Fingerprint button
          _buildSpecialButton(
            icon: Icons.fingerprint,
            color: AppColors.primary,
            onTap: onBiometricPressed,
          ),
          // '0' button
          _buildKeyButton(
            label: '0',
            onTap: () => onKeyPressed('0'),
          ),
          // Backspace button
          _buildSpecialButton(
            icon: Icons.backspace_outlined,
            color: AppColors.secondary,
            onTap: onDeletePressed,
          ),
        ],
      ),
    );
  }

  Widget _buildKeyButton({required String label, required VoidCallback onTap}) {
    return NeomorphicContainer(
      borderRadius: 12,
      onTap: onTap,
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialButton({required IconData icon, required Color color, required VoidCallback onTap}) {
    return NeomorphicContainer(
      borderRadius: 12,
      onTap: onTap,
      child: Center(
        child: Icon(
          icon,
          size: 24,
          color: color,
        ),
      ),
    );
  }
}
