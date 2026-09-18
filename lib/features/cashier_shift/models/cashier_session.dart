class CashierSession {
  final String cashierName;
  final String cashierRole;
  final String branchName;
  final String initialCash;
  final String pinCode;
  final bool isShiftActive;
  final bool isLoading;

  const CashierSession({
    this.cashierName = 'Sarah Amelia',
    this.cashierRole = 'Kasir #02',
    this.branchName = 'Cabang Senopati',
    this.initialCash = 'Rp 200.000',
    this.pinCode = '',
    this.isShiftActive = false,
    this.isLoading = false,
  });

  CashierSession copyWith({
    String? cashierName,
    String? cashierRole,
    String? branchName,
    String? initialCash,
    String? pinCode,
    bool? isShiftActive,
    bool? isLoading,
  }) {
    return CashierSession(
      cashierName: cashierName ?? this.cashierName,
      cashierRole: cashierRole ?? this.cashierRole,
      branchName: branchName ?? this.branchName,
      initialCash: initialCash ?? this.initialCash,
      pinCode: pinCode ?? this.pinCode,
      isShiftActive: isShiftActive ?? this.isShiftActive,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
