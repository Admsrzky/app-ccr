import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class ConnectedPrintersSection extends StatelessWidget {
  const ConnectedPrintersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.devices, size: 18, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'PRINTER TERKONEKSI',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface, letterSpacing: 0.5),
                  ),
                ],
              ),
              NeomorphicContainer(
                borderRadius: 999,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: const Text('2 Terhubung', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Cashier Printer Card
        NeomorphicContainer(
          borderRadius: 16,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      NeomorphicContainer(
                        borderRadius: 12,
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Icon(Icons.point_of_sale, size: 20, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PRINTER KASIR (STRUK)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 0.5)),
                          SizedBox(height: 2),
                          Text('Epson TM-T82X', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                    ],
                  ),
                  NeomorphicContainer(
                    borderRadius: 999,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        const Text('Bluetooth', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: NeomorphicContainer(
                      borderRadius: 10,
                      isInset: true,
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Icon(Icons.bluetooth, size: 16, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text('00:1B:66:82:11:AA', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NeomorphicContainer(
                      borderRadius: 10,
                      isInset: true,
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Icon(Icons.receipt_long, size: 16, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text('Thermal 80 mm', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: NeomorphicContainer(
                      borderRadius: 12,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mengirim tes cetak ke Printer Kasir...'))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.receipt, size: 16, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text('Uji Cetak Kasir', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  NeomorphicContainer(
                    borderRadius: 12,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ganti Printer Kasir'))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sync, size: 16, color: AppColors.onSurfaceVariant),
                        SizedBox(width: 6),
                        Text('Ganti', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Kitchen Printer Card
        NeomorphicContainer(
          borderRadius: 16,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      NeomorphicContainer(
                        borderRadius: 12,
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: Icon(Icons.restaurant, size: 20, color: AppColors.tertiary),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('PRINTER DAPUR (KOT)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.tertiary, letterSpacing: 0.5)),
                          SizedBox(height: 2),
                          Text('Zijiang POS-5802', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                    ],
                  ),
                  NeomorphicContainer(
                    borderRadius: 999,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        const Text('LAN / USB', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: NeomorphicContainer(
                      borderRadius: 10,
                      isInset: true,
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Icon(Icons.lan, size: 16, color: AppColors.tertiary),
                          SizedBox(width: 6),
                          Text('192.168.1.120:9100', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: NeomorphicContainer(
                      borderRadius: 10,
                      isInset: true,
                      padding: const EdgeInsets.all(10),
                      child: const Row(
                        children: [
                          Icon(Icons.receipt_long, size: 16, color: AppColors.tertiary),
                          SizedBox(width: 6),
                          Text('Thermal 58 mm', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: NeomorphicContainer(
                      borderRadius: 12,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mengirim tiket pesanan tes ke Dapur...'))),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.restaurant, size: 16, color: AppColors.tertiary),
                          SizedBox(width: 6),
                          Text('Uji Cetak Dapur', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.tertiary)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  NeomorphicContainer(
                    borderRadius: 12,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Atur Printer Dapur'))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings, size: 16, color: AppColors.onSurfaceVariant),
                        SizedBox(width: 6),
                        Text('Atur', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Add Printer Button
        NeomorphicContainer(
          borderRadius: 14,
          padding: const EdgeInsets.symmetric(vertical: 14),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Memindai printer Bluetooth / LAN terdekat...'))),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add_circle, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Hubungkan Printer Baru (Scan Bluetooth / LAN)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ),
      ],
    );
  }
}
