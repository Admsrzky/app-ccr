class CashierModel {
  final String id;
  final String name;
  final String role;
  final String branchName;
  final bool isActive;

  const CashierModel({
    required this.id,
    required this.name,
    required this.role,
    required this.branchName,
    this.isActive = true,
  });

  factory CashierModel.fromJson(Map<String, dynamic> json) => CashierModel(
        id: (json['id'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        role: (json['role'] ?? '').toString(),
        branchName: (json['branchName'] ?? '').toString(),
        isActive: (json['isActive'] as bool?) ?? true,
      );
}
