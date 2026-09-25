class StoreHoursModel {
  final String day;
  final String openTime;
  final String closeTime;
  final bool isClosed;

  const StoreHoursModel({
    required this.day,
    required this.openTime,
    required this.closeTime,
    this.isClosed = false,
  });

  factory StoreHoursModel.fromJson(Map<String, dynamic> json) =>
      StoreHoursModel(
        day: (json['day'] ?? '').toString(),
        openTime: (json['openTime'] ?? '').toString(),
        closeTime: (json['closeTime'] ?? '').toString(),
        isClosed: (json['isClosed'] as bool?) ?? false,
      );

  StoreHoursModel copyWith({
    String? openTime,
    String? closeTime,
    bool? isClosed,
  }) => StoreHoursModel(
    day: day,
    openTime: openTime ?? this.openTime,
    closeTime: closeTime ?? this.closeTime,
    isClosed: isClosed ?? this.isClosed,
  );
}

class PrinterModel {
  final String id;
  final String name;
  final String model;
  final String connectionType;
  final String? ipAddress;
  final String? macAddress;
  final String paperWidth;
  final bool isActive;

  const PrinterModel({
    required this.id,
    required this.name,
    required this.model,
    required this.connectionType,
    this.ipAddress,
    this.macAddress,
    this.paperWidth = '58mm',
    this.isActive = true,
  });

  factory PrinterModel.fromJson(Map<String, dynamic> json) => PrinterModel(
    id: (json['id'] ?? '').toString(),
    name: (json['name'] ?? '').toString(),
    model: (json['model'] ?? '').toString(),
    connectionType: (json['connectionType'] ?? '').toString(),
    ipAddress: json['ipAddress']?.toString(),
    macAddress: json['macAddress']?.toString(),
    paperWidth: (json['paperWidth'] ?? '58mm').toString(),
    isActive: (json['isActive'] as bool?) ?? true,
  );

  PrinterModel copyWith({bool? isActive, String? ipAddress}) => PrinterModel(
    id: id,
    name: name,
    model: model,
    connectionType: connectionType,
    ipAddress: ipAddress ?? this.ipAddress,
    macAddress: macAddress,
    paperWidth: paperWidth,
    isActive: isActive ?? this.isActive,
  );
}

class StoreModel {
  final String id;
  final String brandName;
  final String branchName;
  final String? slogan;
  final String? businessType;
  final String storeCode;
  final String? address;
  final String? latitude;
  final String? longitude;
  final String? phone;
  final String? email;
  final String? instagram;
  final String? tagline;
  final bool isOpen;
  final List<StoreHoursModel> hours;
  final List<PrinterModel> printers;

  const StoreModel({
    required this.id,
    required this.brandName,
    required this.branchName,
    this.slogan,
    this.businessType,
    required this.storeCode,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.email,
    this.instagram,
    this.tagline,
    this.isOpen = true,
    this.hours = const [],
    this.printers = const [],
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    id: (json['id'] ?? '').toString(),
    brandName: (json['brandName'] ?? '').toString(),
    branchName: (json['branchName'] ?? '').toString(),
    slogan: json['slogan']?.toString(),
    businessType: json['businessType']?.toString(),
    storeCode: (json['storeCode'] ?? '').toString(),
    address: json['address']?.toString(),
    latitude: json['latitude']?.toString(),
    longitude: json['longitude']?.toString(),
    phone: json['phone']?.toString(),
    email: json['email']?.toString(),
    instagram: json['instagram']?.toString(),
    tagline: json['tagline']?.toString(),
    isOpen: (json['isOpen'] as bool?) ?? true,
    hours: ((json['hours'] as List?) ?? const [])
        .map((e) => StoreHoursModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    printers: ((json['printers'] as List?) ?? const [])
        .map((e) => PrinterModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  StoreModel copyWith({
    String? brandName,
    String? branchName,
    String? slogan,
    String? businessType,
    String? address,
    String? phone,
    String? email,
    String? instagram,
    String? tagline,
    bool? isOpen,
    List<StoreHoursModel>? hours,
    List<PrinterModel>? printers,
  }) => StoreModel(
    id: id,
    brandName: brandName ?? this.brandName,
    branchName: branchName ?? this.branchName,
    slogan: slogan ?? this.slogan,
    businessType: businessType ?? this.businessType,
    storeCode: storeCode,
    address: address ?? this.address,
    latitude: latitude,
    longitude: longitude,
    phone: phone ?? this.phone,
    email: email ?? this.email,
    instagram: instagram ?? this.instagram,
    tagline: tagline ?? this.tagline,
    isOpen: isOpen ?? this.isOpen,
    hours: hours ?? this.hours,
    printers: printers ?? this.printers,
  );
}
