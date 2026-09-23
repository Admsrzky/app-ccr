import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/neomorphic_container.dart';

class ReceiptTemplateSection extends StatefulWidget {
  const ReceiptTemplateSection({super.key});

  @override
  State<ReceiptTemplateSection> createState() => _ReceiptTemplateSectionState();
}

class _ReceiptTemplateSectionState extends State<ReceiptTemplateSection> {
  bool _printLogo = true;
  bool _printQr = true;
  bool _printTax = true;
  int _copies = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Icon(Icons.tune, size: 18, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'FORMAT STRUK PELANGGAN',
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
              _buildToggleRow('Cetak Logo Resto di Header', Icons.image, _printLogo, (val) => setState(() => _printLogo = val)),
              const Divider(height: 20),
              _buildToggleRow('Cetak QR Loyalty / Survei', Icons.qr_code_2, _printQr, (val) => setState(() => _printQr = val)),
              const Divider(height: 20),
              _buildToggleRow('Cetak Pajak Resto PB1 (10%)', Icons.percent, _printTax, (val) => setState(() => _printTax = val)),
              const Divider(height: 24),
              // Copies Stepper
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah Salinan Cetak', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                      SizedBox(height: 2),
                      Text('Rangkap cetakan setiap transaksi', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                  Row(
                    children: [
                      NeomorphicContainer(
                        borderRadius: 8,
                        width: 34,
                        height: 34,
                        onTap: () => setState(() => _copies = (_copies > 1) ? _copies - 1 : 1),
                        child: const Center(child: Text('-', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))),
                      ),
                      Container(
                        width: 44,
                        alignment: Alignment.center,
                        child: Text('$_copies', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                      ),
                      NeomorphicContainer(
                        borderRadius: 8,
                        width: 34,
                        height: 34,
                        onTap: () => setState(() => _copies = (_copies < 5) ? _copies + 1 : 5),
                        child: const Center(child: Text('+', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary))),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Footer text input
              const Text('Pesan Kaki Struk (Footer Text)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
              const SizedBox(height: 8),
              NeomorphicContainer(
                borderRadius: 12,
                isInset: true,
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: TextEditingController(
                    text: 'Terima kasih atas kunjungannya! Nikmati gurih & renyahnya roll kami setiap hari. Follow IG @chickencrunchyroll',
                  ),
                  maxLines: 3,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                  style: const TextStyle(fontSize: 11, color: AppColors.onSurface, height: 1.4),
                ),
              ),
              const SizedBox(height: 6),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('Maksimal 120 karakter', style: TextStyle(fontSize: 9, color: AppColors.onSurfaceVariant)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleRow(String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: AppColors.primary),
            const SizedBox(width: 8),
            Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          ],
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: NeomorphicContainer(
            borderRadius: 999,
            width: 44,
            height: 24,
            isInset: true,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  left: value ? 22 : 2,
                  right: value ? 2 : 22,
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
