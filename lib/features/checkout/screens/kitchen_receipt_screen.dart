import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';

class KitchenReceiptScreen extends ConsumerStatefulWidget {
  const KitchenReceiptScreen({super.key});

  @override
  ConsumerState<KitchenReceiptScreen> createState() => _KitchenReceiptScreenState();
}

class _KitchenReceiptScreenState extends ConsumerState<KitchenReceiptScreen> {
  bool isPrinting = false;

  @override
  void initState() {
    super.initState();
    // Auto print / KOT trigger after 5 seconds as requested
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      setState(() => isPrinting = true);
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (!mounted) return;
        setState(() => isPrinting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Auto-Print (5s): Tiket Dapur (KOT) berhasil dicetak ke Printer 01!')),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkoutProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Printer Print Button Header
            Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.9),
                boxShadow: const [
                  BoxShadow(color: Color(0x08000000), offset: Offset(0, 4), blurRadius: 16),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeomorphicContainer(
                    borderRadius: 999,
                    width: 44,
                    height: 44,
                    onTap: () => Navigator.pop(context),
                    child: const Center(
                      child: Icon(Icons.chevron_left, size: 22, color: AppColors.onSurface),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Struk Dapur (KOT)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                      const Text('Kitchen Order Ticket', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  NeomorphicContainer(
                    borderRadius: 999,
                    width: 44,
                    height: 44,
                    onTap: () {
                      setState(() => isPrinting = true);
                      Future.delayed(const Duration(milliseconds: 1500), () {
                        if (!mounted) return;
                        setState(() => isPrinting = false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Tiket Dapur (KOT) berhasil dicetak ke Printer 01!')),
                        );
                      });
                    },
                    child: Center(
                      child: Icon(
                        isPrinting ? Icons.autorenew : Icons.print,
                        size: 20,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Priority Station Header Alert Banner
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: NeomorphicContainer(
                borderRadius: 16,
                padding: const EdgeInsets.all(14),
                child: NeomorphicContainer(
                  borderRadius: 12,
                  isInset: true,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('TIPE PESANAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary, letterSpacing: 1)),
                          const SizedBox(height: 2),
                          Text(state.orderType.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
                          const SizedBox(height: 2),
                          Text(state.customerName.isNotEmpty ? 'Pelanggan: ${state.customerName}' : 'Pelanggan: Bpk. Kevin', style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('NO. PESANAN', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.secondary, letterSpacing: 1)),
                          const SizedBox(height: 2),
                          const Text('#CR-1049', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                          const SizedBox(height: 2),
                          const Text('Kasir: Sarah A.', style: TextStyle(fontSize: 11, color: AppColors.secondary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Kitchen Thermal Slip Card Container with Perforated / Cut Edge
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Top Jagged / Perforated Receipt Graphic
                    ClipPath(
                      clipper: _JaggedClipper(isTop: true),
                      child: Container(
                        height: 12,
                        color: AppColors.surfaceContainerLow,
                      ),
                    ),
                    // Ticket Body Content
                    Container(
                      width: double.infinity,
                      color: AppColors.surfaceContainerLow,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Ticket Header Info
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restaurant, size: 16, color: AppColors.secondary),
                              SizedBox(width: 6),
                              Text('TIKET PRODUKSI DAPUR', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1, color: AppColors.secondary)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Text('CHICKEN CRUNCHY ROLL', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: AppColors.onSurface)),
                          const SizedBox(height: 2),
                          const Text('Outlet Senopati 01 • Pos 1', style: TextStyle(fontSize: 10, color: AppColors.secondary)),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
                          const SizedBox(height: 12),
                          // Food Order Items List (High Legibility for Cook Staff)
                          _kitchenItemCard(
                            qty: '1x',
                            title: 'CELUP BBQ + FILL KEJU',
                            badge: 'PORSI REGULER',
                            badgeColor: AppColors.surfaceContainer,
                            badgeTextColor: AppColors.onSurface,
                            modifier: 'Mod: Ekstra Saus Keju (Pisah di cup)',
                            warningNote: '*** GORENG GARING, SAUS CELUP DIPISAH ***',
                          ),
                          const SizedBox(height: 10),
                          _kitchenItemCard(
                            qty: '2x',
                            title: 'CELUP SAUS KEJU',
                            badge: 'PORSI REGULER',
                            badgeColor: AppColors.surfaceContainer,
                            badgeTextColor: AppColors.onSurface,
                            modifier: 'Instruksi: Standar roll matang disiram keju leleh',
                          ),
                          const SizedBox(height: 10),
                          _kitchenItemCard(
                            qty: '1x',
                            title: 'TABUR BALADO MANIS',
                            badge: 'PORSI JUMBO (8 PCS)',
                            badgeColor: AppColors.tertiary.withValues(alpha: 0.15),
                            badgeTextColor: AppColors.tertiary,
                            modifier: 'Mod: Ekstra Sambal Pedas (Cup terpisah)',
                            note: 'Catatan: Taburan bumbu balado diratakan',
                          ),
                          const SizedBox(height: 10),
                          // Item 4: Bar / Front Counter Item
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.03),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(6),
                                    boxShadow: const [
                                      BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
                                    ],
                                  ),
                                  child: const Text('2x', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.secondary)),
                                ),
                                const SizedBox(width: 12),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('AIR MINERAL DINGIN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                                      SizedBox(height: 2),
                                      Text('Disiapkan Front Bar (Bukan Cook Station)', style: TextStyle(fontSize: 10, color: AppColors.secondary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
                          const SizedBox(height: 10),
                          // Ticket Metadata
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('KOT Ref: #KOT-0994', style: TextStyle(fontSize: 10, color: AppColors.secondary)),
                              Text('Dicetak: 24/10/2024 12:45:12', style: TextStyle(fontSize: 10, color: AppColors.secondary)),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                    // Bottom Jagged / Perforated Receipt Graphic
                    ClipPath(
                      clipper: _JaggedClipper(isTop: false),
                      child: Container(
                        height: 12,
                        color: AppColors.surfaceContainerLow,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kitchenItemCard({
    required String qty,
    required String title,
    required String badge,
    required Color badgeColor,
    required Color badgeTextColor,
    String? modifier,
    String? warningNote,
    String? note,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 3),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(color: Color(0x10000000), offset: Offset(1, 1), blurRadius: 2),
                  ],
                ),
                child: Text(qty, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
                      child: Text(badge, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: badgeTextColor)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (modifier != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.add_circle_outline, size: 12, color: AppColors.tertiary),
                const SizedBox(width: 4),
                Expanded(child: Text(modifier, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant))),
              ],
            ),
          ],
          if (warningNote != null) ...[
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning_amber, size: 14, color: AppColors.error),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      warningNote,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (note != null) ...[
            const SizedBox(height: 6),
            Text(note, style: const TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: AppColors.secondary)),
          ],
        ],
      ),
    );
  }
}

class _JaggedClipper extends CustomClipper<Path> {
  final bool isTop;
  _JaggedClipper({required this.isTop});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double width = size.width;
    final double height = size.height;
    const double step = 10.0;

    if (isTop) {
      path.moveTo(0, height);
      for (double x = 0; x < width; x += step) {
        path.lineTo(x + step / 2, 0);
        path.lineTo(x + step, height);
      }
      path.lineTo(width, height);
    } else {
      path.moveTo(0, 0);
      for (double x = 0; x < width; x += step) {
        path.lineTo(x + step / 2, height);
        path.lineTo(x + step, 0);
      }
      path.lineTo(width, 0);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
