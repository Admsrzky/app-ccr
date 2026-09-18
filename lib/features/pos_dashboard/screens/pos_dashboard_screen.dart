import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../checkout/screens/checkout_screen.dart';
import '../providers/pos_provider.dart';
import '../widgets/pos_header.dart';
import '../widgets/category_tabs.dart';
import '../widgets/product_card_widget.dart';
import '../widgets/floating_cart_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class PosDashboardScreen extends ConsumerWidget {
  const PosDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posState = ref.watch(posProvider);
    final posNotifier = ref.read(posProvider.notifier);
    final filteredProducts = posNotifier.filteredProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top Header
            const PosHeader(),
            // Main Body Content
            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Search and Category Tabs
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // Search Bar
                          NeomorphicContainer(
                            borderRadius: 12,
                            isInset: true,
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Row(
                              children: [
                                const Icon(Icons.search, size: 20, color: AppColors.primary),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    onChanged: (val) => posNotifier.setSearchQuery(val),
                                    decoration: const InputDecoration(
                                      hintText: 'Cari varian roll, saus celup, filling...',
                                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                      border: InputBorder.none,
                                    ),
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.onSurface),
                                  ),
                                ),
                                NeomorphicContainer(
                                  borderRadius: 8,
                                  width: 32,
                                  height: 32,
                                  child: const Center(
                                    child: Icon(Icons.tune, size: 16, color: AppColors.onSurfaceVariant),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          // Category Tabs
                          CategoryTabs(
                            selectedCategory: posState.selectedCategory,
                            onCategorySelected: (cat) => posNotifier.setCategory(cat),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Product Grid
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 0.72,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final product = filteredProducts[index];
                          final qty = posState.cart[product.id] ?? 0;
                          return ProductCardWidget(
                            product: product,
                            qty: qty,
                            onAdd: () => posNotifier.incrementQty(product.id),
                            onMinus: () => posNotifier.decrementQty(product.id),
                          );
                        },
                        childCount: filteredProducts.length,
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Floating Cart Bar
          if (posState.totalItemsCount() > 0)
            FloatingCartBar(
              totalItems: posState.totalItemsCount(),
              totalPrice: posState.calculateTotal(posNotifier.products),
              onCheckout: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutScreen()),
                );
              },
            ),
          const SizedBox(height: 8),
          // Bottom Navigation Bar
          BottomNavBar(
            activeIndex: posState.activeNavIndex,
            onTabSelected: (index) {
              posNotifier.setActiveNavIndex(index);
              if (index != 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigasi ke tab: ${['Kasir POS', 'Pesanan', 'Laporan', 'Pengaturan'][index]}')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
