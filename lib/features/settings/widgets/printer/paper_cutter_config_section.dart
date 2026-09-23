import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class PaperCutterConfigSection extends StatefulWidget {
  const PaperCutterConfigSection({super.key});

  @override
  State<PaperCutterConfigSection> createState() => _PaperCutterConfigSectionState();
}

class _PaperCutterConfigSectionState extends State<PaperCutterConfigSection> {
  String _paperSize = '80';
  bool _autoCut = true;
  bool _cashDrawer = true;
  bool _buzzer = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Icon(Icons.content_cut, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'KERTAS & PEMOTONG OTOMATIS',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface, letterSpacing: 0.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        NeomorphicContainer(
          borderRadius: 16,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ukuran Kertas Default Kasir', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              const SizedBox(height: 10),
              // Paper size segmented selector
              NeomorphicContainer(
                borderRadius: 12,
                isInset: true,
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _paperSize = '58'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: _paperSize == '58'
                              ? BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                                    BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                                  ],
                                )
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.crop_portrait, size: 16, color: _paperSize == '58' ? AppColors.primary : AppColors.secondary),
                              const SizedBox(width: 6),
                              Text('58 mm', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _paperSize == '58' ? AppColors.primary : AppColors.onSurfaceVariant)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _paperSize = '80'),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: _paperSize == '80'
                              ? BoxDecoration(
                                  color: AppColors.surface,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: const [
                                    BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                                    BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                                  ],
                                )
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt_long, size: 16, color: _paperSize == '80' ? AppColors.primary : AppColors.secondary),
                              const SizedBox(width: 6),
                              Text('80 mm (Rekomendasi)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _paperSize == '80' ? AppColors.primary : AppColors.onSurfaceVariant)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Toggles
              _buildToggleRow(
                'Potong Kertas Otomatis (Auto-Cut)',
                'Potong kertas secara otomatis begitu pencetakan struk selesai.',
                _autoCut,
                (val) => setState(() => _autoCut = val),
              ),
              const Divider(height: 24),
              _buildToggleRow(
                'Buka Laci Kasir (Cash Drawer Kick)',
                'Kirim sinyal trigger pembuka laci kasir saat pembayaran tunai.',
                _cashDrawer,
                (val) => setState(() => _cashDrawer = val),
              ),
              const Divider(height: 24),
              _buildToggleRow(
                'Bunyikan Alarm Buzzer Dapur',
                'Bunyi nada pengingat 2 kali saat pesanan baru keluar di dapur.',
                _buzzer,
                (val) => setState(() => _buzzer = val),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant, height: 1.3)),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: NeomorphicContainer(
            borderRadius: 999,
            width: 48,
            height: 26,
            isInset: true,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: value ? 24 : 2,
                  right: value ? 2 : 24,
                  child: NeomorphicContainer(
                    borderRadius: 999,
                    width: 20,
                    height: 20,
                    child: Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: value ? AppColors.primary : AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
