import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';

class OrderItemsRecapCard extends StatelessWidget {
  final CheckoutState state;
  final CheckoutNotifier notifier;
  final double subtotal;
  final double tax;
  final double totalBill;
  final String Function(double) formatPrice;

  const OrderItemsRecapCard({
    super.key,
    required this.state,
    required this.notifier,
    required this.subtotal,
    required this.tax,
    required this.totalBill,
    required this.formatPrice,
  });

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => notifier.toggleSummaryExpanded(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    NeomorphicContainer(
                      borderRadius: 12,
                      width: 36,
                      height: 36,
                      isInset: true,
                      child: const Center(
                        child: Icon(Icons.fastfood, color: AppColors.primary, size: 20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ringkasan Pesanan (${state.totalQty} Item)',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                        const Text('Tap untuk rincian belanja', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
                NeomorphicContainer(
                  borderRadius: 8,
                  width: 32,
                  height: 32,
                  child: Center(
                    child: Icon(
                      state.isSummaryExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 18,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (state.isSummaryExpanded) ...[
            const Divider(height: 24),
            Column(
              children: [
                for (final item in state.items) ...[
                  _OrderItemRow(
                    name: item.product.name,
                    detail: '${item.quantity}x @ Rp ${formatPrice(item.product.price)}',
                    price: 'Rp ${formatPrice(item.lineTotal)}',
                    imageUrl: item.product.imageUrl,
                  ),
                  const SizedBox(height: 12),
                ],
              ],
            ),
            NeomorphicContainer(
              borderRadius: 12,
              isInset: true,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _calcRow('Subtotal Makanan', 'Rp ${formatPrice(subtotal)}'),
                  const SizedBox(height: 6),
                  _calcRow('PB1 Resto (10%)', 'Rp ${formatPrice(tax)}'),
                  const Divider(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Tagihan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('Rp ${formatPrice(totalBill)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _calcRow(String title, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
        Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      ],
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final String name;
  final String detail;
  final String price;
  final String imageUrl;

  const _OrderItemRow({
    required this.name,
    required this.detail,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 44,
                    height: 44,
                    color: AppColors.surfaceContainer,
                    child: imageUrl.isEmpty
                        ? const Icon(Icons.fastfood, size: 20, color: AppColors.primary)
                        : Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.fastfood, size: 20, color: AppColors.primary),
                          ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      Text(detail, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
