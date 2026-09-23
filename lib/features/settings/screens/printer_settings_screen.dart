import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../widgets/printer/printer_overview_banner.dart';
import '../widgets/printer/connected_printers_section.dart';
import '../widgets/printer/paper_cutter_config_section.dart';
import '../widgets/printer/receipt_template_section.dart';
import '../widgets/printer/receipt_preview_section.dart';
import '../widgets/printer/printer_action_buttons.dart';

class PrinterSettingsScreen extends ConsumerWidget {
  const PrinterSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Header
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.85),
                boxShadow: const [
                  BoxShadow(color: Color(0x08000000), offset: Offset(0, 4), blurRadius: 16),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      NeomorphicContainer(
                        borderRadius: 999,
                        width: 44,
                        height: 44,
                        onTap: () => Navigator.pop(context),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.network(
                        'https://lh3.googleusercontent.com/aida/AEtjO1WNNYWJG_hysU6DyW0zPliMgmAAmXRZxv5guQgwMG3XejB8Opgw66UrHEdAowdLlGOgIWCxPWg4NI6hrXV3ZBXeGMfCs2Skwz7LcLrSvQQUv4hl_QcQvX9YtUhOMtQ9MO4Y0ToRYGJTqHIrodOc2lhafgo-WgYQUDauFY0Q1-J7pZoOkUOSajHGfigqtwISzpEY0VH-ZST5B1f1uwJbL8JR_Zz3szHgp7H-ki2SWJfbIb9r1LFwG6gdYw',
                        height: 32,
                        width: 32,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CHICKEN CRUNCHY ROLL',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant, letterSpacing: 0.5),
                          ),
                          Text(
                            'Pengaturan Printer Thermal & Struk',
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                    PrinterOverviewBanner(),
                    SizedBox(height: 16),
                    ConnectedPrintersSection(),
                    SizedBox(height: 16),
                    PaperCutterConfigSection(),
                    SizedBox(height: 16),
                    ReceiptTemplateSection(),
                    SizedBox(height: 16),
                    ReceiptPreviewSection(),
                    SizedBox(height: 24),
                    PrinterActionButtons(),
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
