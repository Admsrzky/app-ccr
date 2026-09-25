import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../models/category_model.dart';

class CategoryTabs extends StatelessWidget {
  final List<CategoryModel> categories;
  final String selectedCategory;
  final ValueChanged<String> onCategorySelected;

  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final label = cat.slug == 'all'
              ? 'Semua'
              : cat.name.replaceAllMapped(
                  RegExp(r'(\w+)(\s\+)'),
                  (m) => m[1]! + ' +',
                );
          final isSelected = selectedCategory == cat.slug;

          return GestureDetector(
            onTap: () => onCategorySelected(cat.slug),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: isSelected
                  ? BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(999),
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
                        colors: [Color(0xFFDCDFE6), Color(0xFFF0F2F8)],
                      ),
                    )
                  : BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.neoDarkShadow,
                          offset: Offset(4, 4),
                          blurRadius: 8,
                        ),
                        BoxShadow(
                          color: AppColors.neoLightShadow,
                          offset: Offset(-4, -4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isSelected) ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
