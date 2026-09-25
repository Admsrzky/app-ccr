import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';
import '../../models/store_model.dart';
import '../../providers/store_provider.dart';

class ConnectedPrintersSection extends ConsumerWidget {
  const ConnectedPrintersSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeState = ref.watch(storeProvider);
    final printers = storeState.store.printers;
    final activeCount = printers.where((p) => p.isActive).length;

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
                child: Text('$activeCount Terhubung', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (printers.isEmpty)
          NeomorphicContainer(
            borderRadius: 16,
            padding: const EdgeInsets.all(20),
            child: const Center(
              child: Text(
                'Belum ada printer terdaftar.',
                style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
              ),
            ),
          )
        else
          for (final entry in printers.asMap().entries) ...[
            _PrinterCard(
              printer: entry.value,
              accent: entry.key.isEven ? AppColors.primary : AppColors.tertiary,
              onToggle: (active) =>
                  ref.read(storeProvider.notifier).setPrinterActive(entry.value.id, active),
            ),
            const SizedBox(height: 12),
          ],
        if (storeState.isOffline && storeState.errorMessage != null) ...[
          Text(
            storeState.errorMessage!,
            style: const TextStyle(fontSize: 10, color: AppColors.error, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
        ],
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

class _PrinterCard extends StatelessWidget {
  final PrinterModel printer;
  final Color accent;
  final ValueChanged<bool> onToggle;

  const _PrinterCard({
    required this.printer,
    required this.accent,
    required this.onToggle,
  });

  String get _connectionDetail {
    if (printer.ipAddress != null && printer.ipAddress!.isNotEmpty) return printer.ipAddress!;
    if (printer.macAddress != null && printer.macAddress!.isNotEmpty) return printer.macAddress!;
    return '-';
  }

  IconData get _connectionIcon => printer.connectionType.toLowerCase().contains('network')
      ? Icons.lan
      : printer.connectionType.toLowerCase().contains('usb')
          ? Icons.usb
          : Icons.bluetooth;

  @override
  Widget build(BuildContext context) {
    final isActive = printer.isActive;

    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    NeomorphicContainer(
                      borderRadius: 12,
                      width: 40,
                      height: 40,
                      child: Center(
                        child: Icon(Icons.point_of_sale, size: 20, color: accent),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            printer.name.toUpperCase(),
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: accent, letterSpacing: 0.5),
                          ),
                          const SizedBox(height: 2),
                          Text(printer.model, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              NeomorphicContainer(
                borderRadius: 999,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                onTap: () => onToggle(!isActive),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.green : AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      isActive ? printer.connectionType : 'Nonaktif',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isActive ? AppColors.onSurface : AppColors.error,
                      ),
                    ),
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
                  child: Row(
                    children: [
                      Icon(_connectionIcon, size: 16, color: accent),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _connectionDetail,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
                  child: Row(
                    children: [
                      Icon(Icons.receipt_long, size: 16, color: accent),
                      const SizedBox(width: 6),
                      Text('Thermal ${printer.paperWidth.replaceAll('mm', ' mm')}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant)),
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
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Mengirim tes cetak ke ${printer.name}...')),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt, size: 16, color: accent),
                      const SizedBox(width: 6),
                      Text('Uji Cetak', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: accent)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              NeomorphicContainer(
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                onTap: () => onToggle(!isActive),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(isActive ? Icons.power_settings_new : Icons.sync, size: 16, color: isActive ? AppColors.error : AppColors.onSurfaceVariant),
                    const SizedBox(width: 6),
                    Text(
                      isActive ? 'Nonaktifkan' : 'Aktifkan',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isActive ? AppColors.error : AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
