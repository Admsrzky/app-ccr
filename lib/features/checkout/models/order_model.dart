class OrderAddonModel {
  final String key;
  final String name;
  final double price;
  final int quantity;

  const OrderAddonModel({
    required this.key,
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  factory OrderAddonModel.fromJson(Map<String, dynamic> json) => OrderAddonModel(
        key: (json['key'] ?? '').toString(),
        name: (json['name'] ?? '').toString(),
        price: ((json['price'] as num?) ?? 0).toDouble(),
        quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      );
}

class OrderItemModel {
  final String productName;
  final String? sizeName;
  final double unitPrice;
  final int quantity;
  final double subtotal;
  final String? notes;
  final List<OrderAddonModel> addons;

  const OrderItemModel({
    required this.productName,
    this.sizeName,
    required this.unitPrice,
    required this.quantity,
    required this.subtotal,
    this.notes,
    this.addons = const [],
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) => OrderItemModel(
        productName: (json['productName'] ?? '').toString(),
        sizeName: json['sizeName']?.toString(),
        unitPrice: ((json['unitPrice'] as num?) ?? 0).toDouble(),
        quantity: (json['quantity'] as num?)?.toInt() ?? 0,
        subtotal: ((json['subtotal'] as num?) ?? 0).toDouble(),
        notes: json['notes']?.toString(),
        addons: ((json['addons'] as List?) ?? const [])
            .map((e) => OrderAddonModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  double get addonTotal => addons.fold(0, (sum, a) => sum + a.price * a.quantity);
}

class OrderModel {
  final String id;
  final String orderNumber;
  final String? customerName;
  final String? tableNumber;
  final String orderType;
  final String? paymentMethod;
  final String status;
  final double subtotal;
  final double taxRate;
  final double tax;
  final double total;
  final double? cashReceived;
  final double? change;
  final String? cashierId;
  final String? cashierName;
  final List<OrderItemModel> items;
  final DateTime? createdAt;

  const OrderModel({
    required this.id,
    required this.orderNumber,
    this.customerName,
    this.tableNumber,
    required this.orderType,
    this.paymentMethod,
    required this.status,
    required this.subtotal,
    required this.taxRate,
    required this.tax,
    required this.total,
    this.cashReceived,
    this.change,
    this.cashierId,
    this.cashierName,
    this.items = const [],
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: (json['id'] ?? '').toString(),
        orderNumber: (json['orderNumber'] ?? '').toString(),
        customerName: json['customerName']?.toString(),
        tableNumber: json['tableNumber']?.toString(),
        orderType: (json['orderType'] ?? 'Dine In').toString(),
        paymentMethod: json['paymentMethod']?.toString(),
        status: (json['status'] ?? 'paid').toString(),
        subtotal: ((json['subtotal'] as num?) ?? 0).toDouble(),
        taxRate: ((json['taxRate'] as num?) ?? 0.1).toDouble(),
        tax: ((json['tax'] as num?) ?? 0).toDouble(),
        total: ((json['total'] as num?) ?? 0).toDouble(),
        cashReceived: (json['cashReceived'] as num?)?.toDouble(),
        change: (json['change'] as num?)?.toDouble(),
        cashierId: json['cashierId']?.toString(),
        cashierName: (json['cashier'] is Map) ? (json['cashier']['name']?.toString()) : null,
        items: ((json['items'] as List?) ?? const [])
            .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt'].toString()) : null,
      );

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);
}
