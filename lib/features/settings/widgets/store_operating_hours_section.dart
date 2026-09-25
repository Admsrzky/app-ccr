import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/store_provider.dart';
import '../models/store_model.dart';

class StoreOperatingHoursSection extends ConsumerWidget {
  const StoreOperatingHoursSection({super.key});

  static const _dayShort = {
    'Senin': 'Sen',
    'Selasa': 'Sel',
    'Rabu': 'Rab',
    'Kamis': 'Kam',
    'Jumat': 'Jum',
    'Sabtu': 'Sab',
    'Minggu': 'Min',
  };

  String get _todayName {
    const names = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return names[DateTime.now().weekday - 1];
  }

  Future<void> _pickTime(BuildContext context, WidgetRef ref, StoreHoursModel hour, bool isOpen) async {
    final initial = _parseTime(isOpen ? hour.openTime : hour.closeTime);
    final picked = await showTimePicker(context: context, initialTime: initial);
    if (picked == null) return;
    final value = '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
    await ref.read(storeProvider.notifier).updateHours(
          hour.day,
          openTime: isOpen ? value : null,
          closeTime: isOpen ? null : value,
        );
  }

  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    final h = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 10;
    final m = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
    return TimeOfDay(hour: h, minute: m);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storeState = ref.watch(storeProvider);
    final store = storeState.store;
    final hours = store.hours;
    final notifier = ref.read(storeProvider.notifier);
    final today = hours.firstWhere(
      (h) => h.day == _todayName,
      orElse: () => const StoreHoursModel(day: '', openTime: '', closeTime: ''),
    );

    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.schedule, size: 20, color: AppColors.primary),
                  SizedBox(width: 8),
                  Text(
                    'Jam Operasional Toko',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ],
              ),
              NeomorphicContainer(
                borderRadius: 999,
                isInset: true,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                child: const Text(
                  'Shift Otomatis',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Day pills grid
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Status Hari Buka / Libur Mingguan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const Text(
                    'Ketuk hari untuk ubah',
                    style: TextStyle(
                      fontSize: 10,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              NeomorphicContainer(
                borderRadius: 12,
                isInset: true,
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    for (final hour in hours)
                      GestureDetector(
                        onTap: () => notifier.toggleDay(hour.day),
                        child: _buildDayPill(_dayShort[hour.day] ?? hour.day, !hour.isClosed),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Operating hour cards per day
          Column(
            children: [
              for (final hour in hours) ...[
                _buildDayCard(context, ref, hour),
                const SizedBox(height: 12),
              ],
            ],
          ),
          // Verified status footer
          NeomorphicContainer(
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  today.isClosed ? Icons.event_busy : Icons.verified,
                  size: 18,
                  color: today.isClosed ? AppColors.error : Colors.green,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    today.day.isEmpty
                        ? 'Data jam operasional belum tersedia'
                        : today.isClosed
                            ? 'Tutup hari ini ($_todayName) • Buka kembali besok'
                            : 'Sedang Beroperasi (Hari Ini Buka ${today.openTime}–${today.closeTime})',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (storeState.isOffline && storeState.errorMessage != null) ...[
            const SizedBox(height: 8),
            Text(
              storeState.errorMessage!,
              style: const TextStyle(fontSize: 10, color: AppColors.error, fontWeight: FontWeight.w600),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDayPill(String day, bool isOpen) {
    return NeomorphicContainer(
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: isOpen ? AppColors.onSurface : AppColors.error,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: isOpen ? Colors.green : AppColors.error,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isOpen ? 'Buka' : 'Libur',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              color: isOpen ? Colors.green : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, WidgetRef ref, StoreHoursModel hour) {
    final isOpen = !hour.isClosed;

    return NeomorphicContainer(
      borderRadius: 14,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    isOpen ? Icons.calendar_month : Icons.event_busy,
                    size: 18,
                    color: isOpen ? AppColors.primary : AppColors.error,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hour.day,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        isOpen ? 'Hari Operasional' : 'Libur / Day Off',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => ref.read(storeProvider.notifier).toggleDay(hour.day),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (isOpen ? Colors.green : AppColors.error).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        isOpen ? 'Buka' : 'Tutup',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: isOpen ? Colors.green : AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        isOpen ? Icons.toggle_on : Icons.toggle_off,
                        size: 18,
                        color: isOpen ? Colors.green : AppColors.error,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 10,
                  isInset: isOpen,
                  padding: const EdgeInsets.all(10),
                  onTap: isOpen ? () => _pickTime(context, ref, hour, true) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('JAM BUKA', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isOpen ? '${hour.openTime} WIB' : '— : — (Tutup)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isOpen ? AppColors.onSurface : AppColors.onSurfaceVariant,
                            ),
                          ),
                          Icon(
                            isOpen ? Icons.expand_more : Icons.block,
                            size: 14,
                            color: isOpen ? AppColors.primary : AppColors.outline,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: NeomorphicContainer(
                  borderRadius: 10,
                  isInset: isOpen,
                  padding: const EdgeInsets.all(10),
                  onTap: isOpen ? () => _pickTime(context, ref, hour, false) : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('JAM TUTUP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isOpen ? '${hour.closeTime} WIB' : '— : — (Tutup)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isOpen ? AppColors.onSurface : AppColors.onSurfaceVariant,
                            ),
                          ),
                          Icon(
                            isOpen ? Icons.expand_more : Icons.block,
                            size: 14,
                            color: isOpen ? AppColors.primary : AppColors.outline,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
