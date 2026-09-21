import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../models/product_model.dart';
import 'product_detail_modal.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final int qty;
  final VoidCallback onAdd;
  final VoidCallback onMinus;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.qty,
    required this.onAdd,
    required this.onMinus,
  });

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 14,
      padding: const EdgeInsets.all(8),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => ProductDetailModal(product: product),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image & Badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1.15,
                  child: Container(
                    color: AppColors.surfaceContainer,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: AppColors.primary),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 6,
                left: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: product.isPedas ? AppColors.error.withOpacity(0.9) : AppColors.surface.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: const [
                      BoxShadow(color: Color(0x14000000), blurRadius: 4, offset: Offset(2, 2)),
                    ],
                  ),
                  child: Text(
                    product.badgeText,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                      color: product.isPedas ? Colors.white : AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          // Title & Description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant),
                ),
                // S R J Size Indicators in card as requested
                Row(
                  children: [
                    _sizeBadge('S', false),
                    const SizedBox(width: 2),
                    _sizeBadge('R', true),
                    const SizedBox(width: 2),
                    _sizeBadge('J', false),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Price & Qty Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Mulai', style: TextStyle(fontSize: 8, color: AppColors.onSurfaceVariant)),
                  Text(
                    'Rp ${_formatPrice(product.price)}',
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                  ),
                ],
              ),
              Row(
                children: [
                  if (qty > 0) ...[
                    GestureDetector(
                      onTap: onMinus,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(1.5, 1.5), blurRadius: 3),
                            BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-1.5, -1.5), blurRadius: 3),
                          ],
                        ),
                        child: const Center(
                          child: Icon(Icons.remove, size: 12, color: AppColors.onSurfaceVariant),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$qty',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                    ),
                    const SizedBox(width: 4),
                  ],
                  GestureDetector(
                    onTap: onAdd,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(1.5, 1.5), blurRadius: 3),
                          BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-1.5, -1.5), blurRadius: 3),
                        ],
                      ),
                      child: const Center(
                        child: Icon(Icons.add, size: 14, color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sizeBadge(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(4),
        boxShadow: const [
          BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
          BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-1, -1), blurRadius: 2),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        );
  }
}
