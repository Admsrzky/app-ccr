import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class NeomorphicContainer extends StatelessWidget {
  final Widget child;
  final bool isInset;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const NeomorphicContainer({
    super.key,
    required this.child,
    this.isInset = false,
    this.borderRadius = 16.0,
    this.padding,
    this.margin,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = isInset
        ? BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [
              BoxShadow(
                color: Color(0x10000000),
                offset: Offset(4, 4),
                blurRadius: 8,
              ),
              BoxShadow(
                color: Color(0x80FFFFFF),
                offset: Offset(-4, -4),
                blurRadius: 8,
              ),
            ],
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFDCDFE6),
                Color(0xFFF0F2F8),
              ],
            ),
          )
        : BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [
              BoxShadow(
                color: AppColors.neoDarkShadow,
                offset: Offset(6, 6),
                blurRadius: 12,
              ),
              BoxShadow(
                color: AppColors.neoLightShadow,
                offset: Offset(-6, -6),
                blurRadius: 12,
              ),
            ],
          );

    Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
