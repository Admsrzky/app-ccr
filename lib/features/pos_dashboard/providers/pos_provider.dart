import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_client.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

const kFallbackCategories = <CategoryModel>[
  CategoryModel(id: 'cat-all', slug: 'all', name: 'Semua'),
  CategoryModel(id: 'cat-celup', slug: 'celup', name: 'Celup'),
  CategoryModel(id: 'cat-filling', slug: 'filling', name: 'Filling'),
  CategoryModel(id: 'cat-tabur', slug: 'tabur', name: 'Tabur'),
  CategoryModel(id: 'cat-celup-filling', slug: 'celup-filling', name: 'Celup + Filling'),
  CategoryModel(id: 'cat-tabur-filling', slug: 'tabur-filling', name: 'Tabur + Filling'),
];

const _imgBbq = 'https://lh3.googleusercontent.com/aida/AEtjO1X61ItoULu6he1GZP2FwTKG2kzor9QTe1ZFMbvcKixZk3KEysY0nj2PSDpK1AW3KPUZv-wNnRzBdwQEJl1YTCEtG_RX6P3cz-8_s3OZCm2-1x9opc_8EVFrejBBAIp3__0zOZszhzWeZ53gpuZ1uUQCbFMJ52d2l1VNJJWkWStN1leSoPoYtpGG1dNhUUNm_CjREiwc6TB-rZgaWI1LSXmeOoEXUIggumQI_7H4noo4pOrPtiEbBe_yWsc';
const _imgCheese = 'https://lh3.googleusercontent.com/aida/AEtjO1UjaB4WS-PK0OSx9oTDu01fausjldWxA56hutMIWTCebb5OpUlIIeHwFDTCIAC_Z3g1ba8r1NlOyZtkXAObpYEukX49HNSzOSRNHkNWLqquoJDFkorIvn7ra8aePI7h5cnmkLiEPsxOG7NMzf8j7uRR4FuN18aT9cWs2ZCKVqaH3VBaV-XMCEqceCbvxRVCR16X9tsPxDpKuFZ_QPk0EEamotxwOvEmdhfafEhk0QIMcZcqzJoh14RaziE';

const kFallbackProducts = <ProductModel>[
  ProductModel(id: 'prod-1', name: 'Celup BBQ', category: 'celup', description: 'Smoky barbekyu gurih khas', price: 14000, imageUrl: _imgBbq, badgeText: 'Celup'),
  ProductModel(id: 'prod-2', name: 'Celup Saus Keju', category: 'celup', description: 'Celup keju cheddar creamy', price: 18000, imageUrl: _imgCheese, badgeText: 'Celup'),
  ProductModel(id: 'prod-3', name: 'Celup Red Hot Spicy', category: 'celup', description: 'Sensasi pedas membakar mantap', price: 18000, imageUrl: _imgBbq, badgeText: 'Pedas Hot', isPedas: true),
  ProductModel(id: 'prod-4', name: 'Celup Mayo Gurih', category: 'celup', description: 'Saus mayo lembut asam manis', price: 18000, imageUrl: _imgCheese, badgeText: 'Celup'),
  ProductModel(id: 'prod-5', name: 'Filling Keju', category: 'filling', description: 'Mozzarella lumer di bagian dalam', price: 17000, imageUrl: _imgBbq, badgeText: 'Filling'),
  ProductModel(id: 'prod-6', name: 'Filling Mentai', category: 'filling', description: 'Isian torched mentai gurih creamy', price: 17000, imageUrl: _imgCheese, badgeText: 'Filling'),
  ProductModel(id: 'prod-7', name: 'Tabur Bumbu Keju', category: 'tabur', description: 'Bubuk keju cheddar gurih renyah', price: 18000, imageUrl: _imgBbq, badgeText: 'Tabur'),
  ProductModel(id: 'prod-8', name: 'Tabur Balado Manis', category: 'tabur', description: 'Pedas manis harum daun jeruk', price: 18000, imageUrl: _imgCheese, badgeText: 'Tabur', isPedas: true),
  ProductModel(id: 'prod-9', name: 'Tabur Sweet Corn', category: 'tabur', description: 'Jagung bakar wangi manis nagih', price: 18000, imageUrl: _imgBbq, badgeText: 'Tabur'),
  ProductModel(id: 'prod-10', name: 'Celup BBQ + Fill Keju', category: 'celup-filling', description: 'Mozzarella lumer & celup smoky', price: 21000, imageUrl: _imgBbq, badgeText: 'Celup + Filling'),
  ProductModel(id: 'prod-11', name: 'Celup Keju + Fill Keju', category: 'celup-filling', description: 'Double cheese leleh & gurih ekstra', price: 21000, imageUrl: _imgCheese, badgeText: 'Celup + Filling'),
  ProductModel(id: 'prod-12', name: 'Spicy + Fill Mentai', category: 'celup-filling', description: 'Sensasi pedas celup & mentai bakar', price: 21000, imageUrl: _imgBbq, badgeText: 'Celup + Filling', isPedas: true),
  ProductModel(id: 'prod-13', name: 'Tabur Keju + Fill Keju', category: 'tabur-filling', description: 'Bubuk keju gurih & isian mozzarella', price: 21000, imageUrl: _imgCheese, badgeText: 'Tabur + Filling'),
  ProductModel(id: 'prod-14', name: 'Tabur Balado + Fill Keju', category: 'tabur-filling', description: 'Balado gurih pedas & keju leleh', price: 21000, imageUrl: _imgBbq, badgeText: 'Tabur + Filling', isPedas: true),
];

class PosState {
  final String selectedCategory;
  final String searchQuery;
  final Map<String, int> cart; // productId -> quantity
  final int activeNavIndex;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final bool isLoading;
  final bool isOffline;
  final String? errorMessage;

  const PosState({
    this.selectedCategory = 'all',
    this.searchQuery = '',
    this.cart = const {},
    this.activeNavIndex = 0,
    this.products = kFallbackProducts,
    this.categories = kFallbackCategories,
    this.isLoading = false,
    this.isOffline = false,
    this.errorMessage,
  });

  PosState copyWith({
    String? selectedCategory,
    String? searchQuery,
    Map<String, int>? cart,
    int? activeNavIndex,
    List<ProductModel>? products,
    List<CategoryModel>? categories,
    bool? isLoading,
    bool? isOffline,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PosState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      cart: cart ?? this.cart,
      activeNavIndex: activeNavIndex ?? this.activeNavIndex,
      products: products ?? this.products,
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  double calculateTotal() {
    double total = 0;
    cart.forEach((productId, qty) {
      final matches = products.where((p) => p.id == productId);
      if (matches.isEmpty) return;
      total += matches.first.price * qty;
    });
    return total;
  }

  int totalItemsCount() {
    int count = 0;
    for (final qty in cart.values) {
      count += qty;
    }
    return count;
  }

  List<ProductModel> get filteredProducts {
    return products.where((product) {
      final matchesCategory =
          selectedCategory == 'all' || product.category == selectedCategory;
      final q = searchQuery.toLowerCase();
      final matchesSearch = q.isEmpty ||
          product.name.toLowerCase().contains(q) ||
          product.description.toLowerCase().contains(q);
      return matchesCategory && matchesSearch;
    }).toList();
  }
}

class PosNotifier extends StateNotifier<PosState> {
  PosNotifier() : super(const PosState()) {
    loadCatalog();
  }

  List<ProductModel> get products => state.products;

  Future<void> loadCatalog() async {
    state = state.copyWith(isLoading: true, clearError: true);

    String? error;
    bool offline = false;
    var products = state.products;
    var categories = state.categories;

    try {
      final catJson = await apiClient.get('/categories');
      final prodJson = await apiClient.get('/products');

      final fetchedCats = ((catJson['data'] as List?) ?? const [])
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .where((c) => c.slug.isNotEmpty)
          .toList();
      final fetchedProducts = ((prodJson['data'] as List?) ?? const [])
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList();

      if (fetchedProducts.isNotEmpty) products = fetchedProducts;
      if (fetchedCats.isNotEmpty) {
        categories = [
          const CategoryModel(id: 'cat-all', slug: 'all', name: 'Semua'),
          ...fetchedCats,
        ];
      }
    } on ApiException catch (e) {
      error = e.message;
      offline = true;
    } catch (_) {
      error = 'Terjadi kesalahan tidak terduga';
      offline = true;
    }

    if (!mounted) return;

    // Buang item cart yang tidak ada di katalog baru
    final cart = Map<String, int>.from(state.cart)
      ..removeWhere((id, _) => !products.any((p) => p.id == id));

    state = state.copyWith(
      isLoading: false,
      products: products,
      categories: categories,
      cart: cart,
      isOffline: offline,
      errorMessage:
          offline ? 'Katalog offline — menampilkan data lokal (${error ?? 'gagal'})' : null,
      clearError: !offline,
    );
  }

  void setCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setActiveNavIndex(int index) {
    state = state.copyWith(activeNavIndex: index);
  }

  void incrementQty(String productId) {
    final cart = Map<String, int>.from(state.cart);
    cart[productId] = (cart[productId] ?? 0) + 1;
    state = state.copyWith(cart: cart);
  }

  void decrementQty(String productId) {
    final cart = Map<String, int>.from(state.cart);
    if (cart.containsKey(productId)) {
      if (cart[productId]! > 1) {
        cart[productId] = cart[productId]! - 1;
      } else {
        cart.remove(productId);
      }
      state = state.copyWith(cart: cart);
    }
  }

  void clearCart() {
    state = state.copyWith(cart: const {});
  }

  /// Item keranakan siap dikirim ke checkout: (product, qty)
  List<MapEntry<ProductModel, int>> get cartEntries {
    final entries = <MapEntry<ProductModel, int>>[];
    state.cart.forEach((productId, qty) {
      final matches = state.products.where((p) => p.id == productId);
      if (matches.isNotEmpty) entries.add(MapEntry(matches.first, qty));
    });
    return entries;
  }

  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

final posProvider = StateNotifierProvider<PosNotifier, PosState>((ref) {
  return PosNotifier();
});
