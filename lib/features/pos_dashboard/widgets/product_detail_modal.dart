import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../models/product_model.dart';

class ProductDetailModal extends ConsumerStatefulWidget {
  final ProductModel product;

  const ProductDetailModal({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailModal> createState() => _ProductDetailModalState();
}

class _ProductDetailModalState extends ConsumerState<ProductDetailModal> {
  String selectedSize = 'Reguler';
  double unitPrice = 21000;
  int quantity = 1;
  final Set<String> selectedAddons = {};
  final TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    unitPrice = widget.product.price;
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  double get totalPrice {
    double addonTotal = 0;
    if (selectedAddons.contains('keju')) addonTotal += 4000;
    if (selectedAddons.contains('mayo')) addonTotal += 3000;
    if (selectedAddons.contains('bbq')) addonTotal += 2000;
    if (selectedAddons.contains('sambal')) addonTotal += 2000;
    return (unitPrice + addonTotal) * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Grabber handle
            Center(
              child: Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: const [
                    BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    NeomorphicContainer(
                      borderRadius: 12,
                      width: 36,
                      height: 36,
                      child: const Center(
                        child: Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DETAIL PESANAN',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.5),
                        ),
                        Text(
                          'Konfirmasi ukuran & catatan pesanan',
                          style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                NeomorphicContainer(
                  borderRadius: 999,
                  width: 32,
                  height: 32,
                  onTap: () => Navigator.pop(context),
                  child: const Center(
                    child: Icon(Icons.close, size: 16, color: AppColors.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Product Showcase Card
            NeomorphicContainer(
              borderRadius: 16,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 72,
                      height: 72,
                      color: AppColors.surfaceContainer,
                      child: Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: AppColors.primary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: const [
                              BoxShadow(color: Color(0x10000000), blurRadius: 4, offset: Offset(2, 2)),
                            ],
                          ),
                          child: Text(
                            widget.product.badgeText,
                            style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.primary),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Varian rasa terpilih di POS Kasir',
                          style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rp ${_formatPrice(unitPrice)}',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(999),
                                boxShadow: const [
                                  BoxShadow(color: Color(0x10000000), blurRadius: 4, offset: Offset(2, 2)),
                                ],
                              ),
                              child: Text(
                                '$selectedSize Terpilih',
                                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.tertiary),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Select Size Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Pilih Ukuran', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    SizedBox(width: 6),
                    Text('(Wajib Pilih 1)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.tertiary)),
                  ],
                ),
                Text('Porsi Menu', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildSizeChip('Small', 17000),
                const SizedBox(width: 8),
                _buildSizeChip('Reguler', 21000),
                const SizedBox(width: 8),
                _buildSizeChip('Jumbo', 28000),
              ],
            ),
            const SizedBox(height: 16),
            // Additional / Tambahan Addons
            const Row(
              children: [
                Icon(Icons.add_circle, size: 14, color: AppColors.primary),
                SizedBox(width: 4),
                Text('Additional / Tambahan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              ],
            ),
            const SizedBox(height: 8),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 3.2,
              children: [
                _buildAddonCheckbox('Ekstra Saus Keju', 'keju', 4000),
                _buildAddonCheckbox('Ekstra Saus Mayo', 'mayo', 3000),
                _buildAddonCheckbox('Ekstra Tabur BBQ', 'bbq', 2000),
                _buildAddonCheckbox('Ekstra Sambal Pedas', 'sambal', 2000),
              ],
            ),
            const SizedBox(height: 16),
            // Kitchen Notes
            const Row(
              children: [
                Icon(Icons.restaurant, size: 14, color: AppColors.primary),
                SizedBox(width: 4),
                Text('Catatan Dapur', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              ],
            ),
            const SizedBox(height: 8),
            NeomorphicContainer(
              borderRadius: 12,
              isInset: true,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.edit_note, size: 18, color: AppColors.outline),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: notesController,
                      decoration: const InputDecoration(
                        hintText: 'Goreng garing, saus celup dipisah',
                        hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 11, color: AppColors.onSurface),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Subtotal & Action Bar
            NeomorphicContainer(
              borderRadius: 16,
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('SUBTOTAL ITEM', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                          const SizedBox(height: 2),
                          Text('Rp ${_formatPrice(totalPrice)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                      // Stepper
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                            BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                          ],
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (quantity > 1) setState(() => quantity--);
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
                                  ],
                                ),
                                child: const Icon(Icons.remove, size: 14),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text('$quantity', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => setState(() => quantity++),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: const [
                                    BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
                                  ],
                                ),
                                child: const Icon(Icons.add, size: 14, color: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: NeomorphicContainer(
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${widget.product.name} ($selectedSize) disimpan ke pesanan!')),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag, size: 16, color: AppColors.primary),
                              SizedBox(width: 6),
                              Text('Simpan Pesanan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Pembayaran langsung untuk ${widget.product.name} ($selectedSize)')),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bolt, size: 16),
                              SizedBox(width: 6),
                              Text('Langsung Bayar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeChip(String size, double price) {
    final isSelected = selectedSize == size;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSize = size;
            unitPrice = price;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: isSelected
              ? BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary.withOpacity(0.4)),
                  boxShadow: const [
                    BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 6),
                    BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 6),
                  ],
                  gradient: const LinearGradient(
                    colors: [Color(0xFFDCDFE6), Color(0xFFF0F2F8)],
                  ),
                )
              : BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(4, 4), blurRadius: 8),
                    BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-4, -4), blurRadius: 8),
                  ],
                ),
          child: Column(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface,
                  boxShadow: const [
                    BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
                    BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-1, -1), blurRadius: 2),
                  ],
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    size,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primary : AppColors.onSurface,
                    ),
                  ),
                  if (size == 'Reguler') ...[
                    const SizedBox(width: 2),
                    const Icon(Icons.star, size: 10, color: AppColors.primary),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                'Rp ${_formatPrice(price)}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? AppColors.primary : AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddonCheckbox(String label, String key, double price) {
    final isChecked = selectedAddons.contains(key);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isChecked) {
            selectedAddons.remove(key);
          } else {
            selectedAddons.add(key);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isChecked
              ? const [
                  BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4, spreadRadius: 0),
                  BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4, spreadRadius: 0),
                ]
              : const [
                  BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(3, 3), blurRadius: 6),
                  BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-3, -3), blurRadius: 6),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.surface,
                    boxShadow: const [
                      BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      size: 10,
                      color: isChecked ? AppColors.primary : Colors.transparent,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
              ],
            ),
            Text(
              '+${_formatPrice(price)}',
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
          ],
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
