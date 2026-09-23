import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class StoreOperatingHoursSection extends StatelessWidget {
  const StoreOperatingHoursSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                    _buildDayPill('Sen', true),
                    _buildDayPill('Sel', true),
                    _buildDayPill('Rab', true),
                    _buildDayPill('Kam', true),
                    _buildDayPill('Jum', false), // Off day
                    _buildDayPill('Sab', true),
                    _buildDayPill('Min', true),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Operating hour cards
          Column(
            children: [
              _buildShiftCard(
                context,
                'Senin – Kamis',
                'Hari Kerja / Regular Days',
                Icons.calendar_month,
                '10:00 WIB',
                '21:00 WIB',
                isOpen: true,
              ),
              const SizedBox(height: 12),
              _buildFridayCard(context),
              const SizedBox(height: 12),
              _buildShiftCard(
                context,
                'Sabtu – Minggu',
                'Akhir Pekan / Weekend Special',
                Icons.weekend,
                '10:00 WIB',
                '22:00 WIB',
                isOpen: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Verified status footer
          NeomorphicContainer(
            borderRadius: 12,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: const Row(
              children: [
                Icon(Icons.verified, size: 18, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Sedang Beroperasi (Hari Ini Buka • Tutup Jumat)',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
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

  Widget _buildShiftCard(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    String openTime,
    String closeTime, {
    required bool isOpen,
  }) {
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
                  Icon(icon, size: 18, color: AppColors.primary),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                    const Text(
                      'Buka',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                  ],
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
                  isInset: true,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('JAM BUKA', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(openTime, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                          const Icon(Icons.expand_more, size: 14, color: AppColors.primary),
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
                  isInset: true,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('JAM TUTUP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(closeTime, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                          const Icon(Icons.expand_more, size: 14, color: AppColors.primary),
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

  Widget _buildFridayCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: NeomorphicContainer(
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
                    const Icon(Icons.event_busy, size: 18, color: AppColors.error),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Jumat', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.error.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Libur Mingguan', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.error)),
                            ),
                          ],
                        ),
                        const Text('Hari Khusus Libur / Day Off', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mengubah status operasional Jumat...')),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tutup', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.error)),
                        SizedBox(width: 4),
                        Icon(Icons.toggle_off, size: 18, color: AppColors.error),
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
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('JAM BUKA', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('— : — (Tutup)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                            Icon(Icons.block, size: 14, color: AppColors.outline),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('JAM TUTUP', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('— : — (Tutup)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant)),
                            Icon(Icons.block, size: 14, color: AppColors.outline),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Toko tutup otomatis di POS & Delivery Online', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Jumat diubah menjadi Buka')),
                  ),
                  child: const Text('Ubah Jadi Buka', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
