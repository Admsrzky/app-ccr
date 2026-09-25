class ProductSizeModel {
  final String id;
  final String name;
  final double price;

  const ProductSizeModel({required this.id, required this.name, required this.price});

  factory ProductSizeModel.fromJson(Map<String, dynamic> json) => ProductSizeModel(
        id: (json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        price: ((json['price'] as num?) ?? 0).toDouble(),
      );
}

class ProductAddonModel {
  final String key;
  final String name;
  final double price;
  final bool isActive;

  const ProductAddonModel({
    required this.key,
    required this.name,
    required this.price,
    this.isActive = true,
  });

  factory ProductAddonModel.fromJson(Map<String, dynamic> json) => ProductAddonModel(
        key: (json['key'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        price: ((json['price'] as num?) ?? 0).toDouble(),
        isActive: (json['isActive'] as bool?) ?? true,
      );
}

class ProductModel {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String imageUrl;
  final String badgeText;
  final bool isPedas;
  final List<ProductSizeModel> sizes;
  final List<ProductAddonModel> addons;

  const ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.badgeText = 'Celup',
    this.isPedas = false,
    this.sizes = const [],
    this.addons = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: (json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        category: (json['category'] ?? '').toString(),
        description: (json['description'] ?? '').toString(),
        price: ((json['price'] as num?) ?? 0).toDouble(),
        imageUrl: (json['imageUrl'] ?? '').toString(),
        badgeText: (json['badgeText'] ?? 'Celup').toString(),
        isPedas: (json['isPedas'] as bool?) ?? false,
        sizes: ((json['sizes'] as List?) ?? const [])
            .map((e) => ProductSizeModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        addons: ((json['addons'] as List?) ?? const [])
            .map((e) => ProductAddonModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
