import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../../core/utils/page_transitions.dart';
import '../../checkout/screens/receipt_screen.dart';
import '../../pos_dashboard/widgets/bottom_nav_bar.dart';
import '../widgets/settings_header.dart';
import '../widgets/admin_info_banner.dart';
import 'store_profile_screen.dart';
import 'printer_settings_screen.dart';
import '../widgets/cashier_profile_card.dart';
import '../../pos_dashboard/providers/pos_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SettingsHeader(),
            // Main Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AdminInfoBanner(),
                    const SizedBox(height: 16),
                    const CashierProfileCard(),
                    const SizedBox(height: 20),
                    // Staff Management Section
                    const Text('Manajemen Kasir & Pengguna', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    const SizedBox(height: 8),
                    NeomorphicContainer(
                      borderRadius: 16,
                      padding: const EdgeInsets.all(14),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka Hak Akses & Otoritas Kasir'))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              NeomorphicContainer(
                                borderRadius: 12,
                                width: 40,
                                height: 40,
                                child: const Center(
                                  child: Icon(Icons.admin_panel_settings, size: 20, color: AppColors.primary),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Hak Akses & Otoritas Kasir', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                  SizedBox(height: 2),
                                  Text('3 staf terdaftar (Sarah, Rian, Dita)', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                                ],
                              ),
                            ],
                          ),
                          const Icon(Icons.chevron_right, size: 20, color: AppColors.onSurfaceVariant),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Operational & Store Configuration
                    const Text('Pengaturan Operasional Outlet', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    const SizedBox(height: 8),
                    NeomorphicContainer(
                      borderRadius: 16,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          _settingItem(
                            context,
                            Icons.store,
                            'Profil & Alamat Toko',
                            'Jl. Senopati No. 42, Kebayoran Baru',
                            onTap: () => Navigator.push(
                              context,
                              AppRoute.fadeSlide(const StoreProfileScreen()),
                            ),
                          ),
                          const Divider(height: 1, color: Colors.grey, indent: 16, endIndent: 16),
                          _settingItem(
                            context,
                            Icons.print,
                            'Printer Thermal & Struk',
                            'Epson TM-T82X Bluetooth (80mm) • Connected',
                            onTap: () => Navigator.push(
                              context,
                              AppRoute.fadeSlide(const PrinterSettingsScreen()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Quick Shortcut: Shift Summary & Cash Audit
                    const Text('Rekap Kas & Penjualan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: NeomorphicContainer(
                            borderRadius: 14,
                            padding: const EdgeInsets.all(14),
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mencetak Rekap X...'))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NeomorphicContainer(
                                  borderRadius: 10,
                                  width: 32,
                                  height: 32,
                                  isInset: true,
                                  child: const Center(child: Icon(Icons.receipt_long, size: 16, color: AppColors.primary)),
                                ),
                                const SizedBox(height: 10),
                                const Text('Cetak Rekap X', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                const SizedBox(height: 2),
                                const Text('Pantau omzet shift', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: NeomorphicContainer(
                            borderRadius: 14,
                            padding: const EdgeInsets.all(14),
                            onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Membuka Kas Masuk/Keluar'))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NeomorphicContainer(
                                  borderRadius: 10,
                                  width: 32,
                                  height: 32,
                                  isInset: true,
                                  child: const Center(child: Icon(Icons.account_balance_wallet, size: 16, color: AppColors.tertiary)),
                                ),
                                const SizedBox(height: 10),
                                const Text('Kas Masuk/Keluar', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                const SizedBox(height: 2),
                                const Text('Petty cash & operasional', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Danger / Shift Closing Actions
                    NeomorphicContainer(
                      borderRadius: 14,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Tutup Shift & Hitung Kas Akhir (Z-Report)'))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_clock, size: 18, color: AppColors.secondary),
                          SizedBox(width: 8),
                          Text('Tutup Shift & Hitung Kas Akhir (Z-Report)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    NeomorphicContainer(
                      borderRadius: 14,
                      isInset: true,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Keluar Akun Kasir'))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, size: 18, color: AppColors.error),
                          SizedBox(width: 8),
                          Text('Ganti Petugas Kasir / Keluar Akun', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.error)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // App Version & Device Tag
                    const Center(
                      child: Column(
                        children: [
                          Text('Chicken Crunchy Roll POS v2.4.1 (Build 8820)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant)),
                          SizedBox(height: 2),
                          Text('Terminal ID: CCR-SENOPATI-POS02 • Android 14 Tablet Edition', style: TextStyle(fontSize: 9, color: AppColors.secondary)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            // Bottom Navigation Bar
            BottomNavBar(
              activeIndex: 3,
              onTabSelected: (index) {
                ref.read(posProvider.notifier).setActiveNavIndex(index);
                if (index == 0) {
                  Navigator.pop(context);
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    AppRoute.fadeSlide(const ReceiptScreen()),
                  );
                } else if (index == 3) {
                  // already here
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Navigasi ke tab: ${['Kasir POS', 'Pesanan', 'Laporan', 'Pengaturan'][index]}')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _settingItem(BuildContext context, IconData icon, String title, String subtitle, {bool isToggle = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                NeomorphicContainer(
                  borderRadius: 10,
                  width: 36,
                  height: 36,
                  child: Center(child: Icon(icon, size: 18, color: AppColors.primary)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ],
            ),
            isToggle
                ? NeomorphicContainer(
                    borderRadius: 999,
                    width: 44,
                    height: 24,
                    isInset: true,
                    child: Stack(
                      children: [
                        Positioned(
                          right: 2,
                          top: 2,
                          bottom: 2,
                          child: NeomorphicContainer(
                            borderRadius: 999,
                            width: 20,
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  )
                : const Icon(Icons.chevron_right, size: 18, color: AppColors.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
