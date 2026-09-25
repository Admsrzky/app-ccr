class CategoryModel {
  final String id;
  final String slug;
  final String name;
  final String? description;
  final int productCount;

  const CategoryModel({
    required this.id,
    required this.slug,
    required this.name,
    this.description,
    this.productCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: (json['id'] ?? '').toString(),
        slug: (json['slug'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        description: json['description']?.toString(),
        productCount: (json['productCount'] as num?)?.toInt() ?? 0,
      );
}
