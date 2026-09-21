import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../../checkout/screens/receipt_screen.dart';
import '../../pos_dashboard/widgets/bottom_nav_bar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Header
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
                      const Text('ANDROID POS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.secondary, letterSpacing: 1)),
                      const Text('Pengaturan Outlet', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                    ],
                  ),
                  NeomorphicContainer(
                    borderRadius: 999,
                    width: 44,
                    height: 44,
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Terminal ID: CCR-SENOPATI-POS02 • Online'))),
                    child: const Center(
                      child: Icon(Icons.settings, size: 20, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            // Main Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sub-Header Info Banner
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Pengaturan Admin & Owner', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 4)]),
                              child: const Text('Akses Penuh / Owner & Supervisor', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ),
                          ],
                        ),
                        NeomorphicContainer(
                          borderRadius: 16,
                          width: 40,
                          height: 40,
                          child: const Center(
                            child: Icon(Icons.admin_panel_settings, size: 20, color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Active Cashier Profile Card
                    NeomorphicContainer(
                      borderRadius: 16,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NeomorphicContainer(
                                borderRadius: 14,
                                width: 64,
                                height: 64,
                                padding: const EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDz77hkX202Nw0LnyUIIDF80qu2euN7KwaclONf_A1LFeu3aFEzo1UF66Wyvi6BLC64oiG14DNH11cIGc_aRdc3YUijRzd-unSzy02I09udnAqAJDV2JvbfS1klPZLuLYxMKh_IgKb3jYocbbLNMdUbVm-HkLpDVl8vfg4Rk6BAIXSiqPMCwKxz5wrNg4VT6IhfwkoAWjCZfpEoWqQkwdVDZUwv6QACpI3dwiR7pNxH7kLw_6yqstuj',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, color: AppColors.primary),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999)),
                                      child: const Text('Shift Pagi Aktif • Kasir #02', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text('Sarah Amelia', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                    const Text('Supervisor & Kasir Utama', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          // Quick Info Badges
                          Row(
                            children: [
                              Expanded(
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: true,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.badge, size: 18, color: AppColors.primary),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('ID Staf', style: TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant)),
                                          const Text('CCR-8821', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: true,
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.schedule, size: 18, color: AppColors.tertiary),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Jam Masuk', style: TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant)),
                                          const Text('08:30 WIB', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Edit Profil Kasir'))),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit, size: 16, color: AppColors.primary),
                                      SizedBox(width: 6),
                                      Text('Edit Profil', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ganti PIN Akses'))),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.key, size: 16, color: AppColors.onSurface),
                                      SizedBox(width: 6),
                                      Text('Ganti PIN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Staff Management Section (Collapsible / Single Row with Chevron as requested)
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Hak Akses & Otoritas Kasir', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                  const SizedBox(height: 2),
                                  const Text('3 staf terdaftar (Sarah, Rian, Dita)', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
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
                          _settingItem(Icons.store, 'Profil & Alamat Toko', 'Jl. Senopati No. 42, Kebayoran Baru'),
                          const Divider(height: 1, color: Colors.grey, indent: 16, endIndent: 16),
                          _settingItem(Icons.print, 'Printer Thermal & Struk', 'Epson TM-T82X Bluetooth (80mm) • Connected'),
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
                if (index == 0) {
                  Navigator.pop(context);
                } else if (index == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ReceiptScreen()),
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

  Widget _settingItem(IconData icon, String title, String subtitle, {bool isToggle = false}) {
    return Padding(
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
    );
  }
}
