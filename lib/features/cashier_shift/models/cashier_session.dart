class CashierSession {
  final String cashierId;
  final String cashierName;
  final String cashierRole;
  final String branchName;
  final String initialCash;
  final String pinCode;
  final bool isLoggedIn;
  final bool isLoading;
  final bool isOffline;
  final String? errorMessage;

  const CashierSession({
    this.cashierId = '',
    this.cashierName = 'Sarah Amelia',
    this.cashierRole = 'Kasir #02',
    this.branchName = 'Cabang Senopati',
    this.initialCash = 'Rp 200.000',
    this.pinCode = '',
    this.isLoggedIn = false,
    this.isLoading = false,
    this.isOffline = false,
    this.errorMessage,
  });

  CashierSession copyWith({
    String? cashierId,
    String? cashierName,
    String? cashierRole,
    String? branchName,
    String? initialCash,
    String? pinCode,
    bool? isLoggedIn,
    bool? isLoading,
    bool? isOffline,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CashierSession(
      cashierId: cashierId ?? this.cashierId,
      cashierName: cashierName ?? this.cashierName,
      cashierRole: cashierRole ?? this.cashierRole,
      branchName: branchName ?? this.branchName,
      initialCash: initialCash ?? this.initialCash,
      pinCode: pinCode ?? this.pinCode,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      isOffline: isOffline ?? this.isOffline,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
