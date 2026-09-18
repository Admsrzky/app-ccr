import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/cashier_provider.dart';
import '../widgets/brand_header.dart';
import '../widgets/cashier_shift_card.dart';
import '../widgets/pin_display.dart';
import '../widgets/neomorphic_keypad.dart';
import '../widgets/shift_launch_button.dart';
import '../widgets/operational_footer.dart';
import '../../pos_dashboard/screens/pos_dashboard_screen.dart';

class PosLoginScreen extends ConsumerWidget {
  const PosLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(cashierProvider);
    final notifier = ref.read(cashierProvider.notifier);

    // If shift is active, navigate to dashboard
    if (session.isShiftActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const PosDashboardScreen()),
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
                  const SizedBox(height: 24),

                  // Cashier Active Shift Card
                  CashierShiftCard(
                    onSwitchUser: () {
                      notifier.switchCashier('Budi Santoso', 'Kasir #01');
                    },
                  ),
                  const SizedBox(height: 24),

                  // PIN Entry Display
                  PinDisplay(pinLength: session.pinCode.length),
                  const SizedBox(height: 20),

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
                  const SizedBox(height: 20),

                  // Bottom Shift Launch Action
                  ShiftLaunchButton(
                    isLoading: session.isLoading,
                    isShiftActive: session.isShiftActive,
                    onPressed: () {
                      notifier.startShift((success) {});
                    },
                  ),
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
