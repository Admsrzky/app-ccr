import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../../core/utils/page_transitions.dart';
import '../providers/cashier_provider.dart';
import '../widgets/brand_header.dart';
import '../widgets/cashier_shift_card.dart';
import '../widgets/pin_display.dart';
import '../widgets/neomorphic_keypad.dart';
import '../widgets/shift_launch_button.dart';
import '../widgets/operational_footer.dart';
import '../../pos_dashboard/screens/pos_dashboard_screen.dart';

class PosLoginScreen extends ConsumerStatefulWidget {
  const PosLoginScreen({super.key});

  @override
  ConsumerState<PosLoginScreen> createState() => _PosLoginScreenState();
}

class _PosLoginScreenState extends ConsumerState<PosLoginScreen> {
  bool _isGoogleLoginTab = false;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(cashierProvider);
    final notifier = ref.read(cashierProvider.notifier);

    // If session is active, navigate to dashboard
    if (session.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          AppRoute.fadeSlide(const PosDashboardScreen()),
        );
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 420),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Brand & Mascot Emblem (Splash Header)
                  const BrandHeader(),
                  const SizedBox(height: 20),

                  // Login Method Switcher (PIN vs Google SSO)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(color: Color(0x10000000), offset: Offset(3, 3), blurRadius: 6),
                        BoxShadow(color: Color(0x99FFFFFF), offset: Offset(-3, -3), blurRadius: 6),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isGoogleLoginTab = false),
                            child: NeomorphicContainer(
                              borderRadius: 12,
                              isInset: _isGoogleLoginTab,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'PIN Kasir',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: !_isGoogleLoginTab ? AppColors.primary : AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isGoogleLoginTab = true),
                            child: NeomorphicContainer(
                              borderRadius: 12,
                              isInset: !_isGoogleLoginTab,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: Text(
                                  'Akun Google (SSO)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: _isGoogleLoginTab ? AppColors.primary : AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  if (!_isGoogleLoginTab) ...[
                    // Cashier Active Shift Card
                    CashierShiftCard(
                      onSwitchUser: () {
                        notifier.switchCashier('Budi Santoso', 'Kasir #01');
                      },
                    ),
                    const SizedBox(height: 20),

                    // PIN Entry Display
                    PinDisplay(pinLength: session.pinCode.length),
                    if (session.errorMessage != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        session.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.error,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),

                    // Neomorphic Keypad
                    NeomorphicKeypad(
                      onKeyPressed: (digit) {
                        notifier.enterPin(digit, (success) {});
                      },
                      onDeletePressed: () {
                        notifier.deletePin();
                      },
                      onBiometricPressed: () {
                        notifier.biometricLogin((success) {});
                      },
                    ),
                    const SizedBox(height: 16),

                    // Bottom Shift Launch Action
                    ShiftLaunchButton(
                      isLoading: session.isLoading,
                      isLoggedIn: session.isLoggedIn,
                      onPressed: () {
                        notifier.login((success) {});
                      },
                    ),
                  ] else ...[
                    // Google Workspace / SSO Login Card
                    NeomorphicContainer(
                      borderRadius: 20,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: AppColors.surface,
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(color: Color(0x15000000), offset: Offset(4, 4), blurRadius: 8),
                                BoxShadow(color: Color(0x99FFFFFF), offset: Offset(-4, -4), blurRadius: 8),
                              ],
                            ),
                            child: Center(
                              child: session.isLoading
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                                    )
                                  : const Icon(Icons.g_mobiledata, size: 48, color: AppColors.primary),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Masuk dengan Akun Google',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Gunakan akun Google Outlet / Manager (senopati@chickencrunchyroll.com) untuk akses penuh POS.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, height: 1.4),
                          ),
                          const SizedBox(height: 24),
                          NeomorphicContainer(
                            borderRadius: 14,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            onTap: session.isLoading
                                ? null
                                : () {
                                    notifier.googleLogin((success) {});
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.login, size: 18, color: AppColors.primary),
                                const SizedBox(width: 8),
                                Text(
                                  session.isLoading ? 'Menghubungkan Google...' : 'Masuk via Google SSO',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),

                  // Operational Footer Bar
                  const OperationalFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
