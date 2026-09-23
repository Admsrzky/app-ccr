import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';
import '../widgets/receipt_header.dart';
import '../widgets/receipt_action_bar.dart';

class ReceiptScreen extends ConsumerStatefulWidget {
  const ReceiptScreen({super.key});

  @override
  ConsumerState<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends ConsumerState<ReceiptScreen> {
  bool isPrinting = false;
  bool isWhatsAppSent = false;
  bool isPdfDownloaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Auto-Print (5s): Struk Dapur (KOT) otomatis keluar ke Printer 01!')),
      );
    });
  }

  void _triggerPrint() {
    setState(() => isPrinting = true);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() => isPrinting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Struk Pelanggan berhasil dicetak (Epson TM-T82X)!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(checkoutProvider);

    const double subtotal = 110000;
    const double tax = 11000;
    const double totalBill = subtotal + tax;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            ReceiptHeader(isPrinting: isPrinting, onPrintTap: _triggerPrint),
            // Status Chip & Quick Metadata
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: NeomorphicContainer(
                borderRadius: 16,
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            const Text('LUNAS (PAID) • QRIS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                          ],
                        ),
                        const Text('24 Okt 2024, 12:45 WIB', style: TextStyle(fontSize: 11, color: AppColors.secondary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(fontSize: 11, color: AppColors.secondary),
                            children: [
                              const TextSpan(text: 'Order ID: '),
                              TextSpan(text: '#CR-1049', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: AppColors.surfaceContainer, borderRadius: BorderRadius.circular(6)),
                          child: Text(state.orderType, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Thermal Paper Slip Container
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    ClipPath(
                      clipper: _JaggedClipper(isTop: true),
                      child: Container(
                        height: 12,
                        color: AppColors.surfaceContainerLow,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: AppColors.surfaceContainerLow,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceContainerLow,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4, spreadRadius: 1),
                              ],
                            ),
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida/AEtjO1UyEr8gZQi0ehK4OpAlri4iIZSayDk1VYnh-4MD7SvubkZr_8VyIMWtrj3Sfc6XewTQrlhX3EHwWlmi8rkoEU35Dq7NfeLE95mrLf6ZBKWp6JZmY5nLnsU-F51ZxkoLF2sUhjWbwEttKgAQ7Zwvjuw57AdPtmv8bgqhrmIndLZoB8E6Uv1Y9ADgyDW2hiodmPRKdbitNzUyno_uRq_5jp76l_iDPtoFW665MXn5eozZsCxXKmg-Z3f1cA',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: AppColors.primary),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text('CHICKEN CRUNCHY ROLL', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1, color: AppColors.onSurface)),
                          const SizedBox(height: 2),
                          const Text('Cabang Senopati 01 - Jakarta Selatan', style: TextStyle(fontSize: 10, color: AppColors.secondary)),
                          const Text('Telp: 0812-3456-7890', style: TextStyle(fontSize: 10, color: AppColors.secondary)),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
                          const SizedBox(height: 8),
                          _receiptInfoRow('No. Struk:', 'INV/20241024/049'),
                          const SizedBox(height: 4),
                          _receiptInfoRow('Waktu:', '24/10/2024 12:45:18'),
                          const SizedBox(height: 4),
                          _receiptInfoRow('Pelanggan:', state.customerName.isNotEmpty ? '${state.customerName} (${state.orderType})' : 'Bpk. Kevin (${state.orderType})'),
                          const SizedBox(height: 8),
                          const Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
                          const SizedBox(height: 10),
                          _itemDetailRow('Celup BBQ + Fill Keju (R)', 'Rp 21.000', '1x @ Rp 21.000', extraName: '+ Ekstra Saus Keju', extraPrice: '+Rp 4.000', note: '* Note: Goreng garing, saus celup dipisah'),
                          const SizedBox(height: 10),
                          _itemDetailRow('Celup Saus Keju (R)', 'Rp 36.000', '2x @ Rp 18.000'),
                          const SizedBox(height: 10),
                          _itemDetailRow('Tabur Balado Manis (Jumbo)', 'Rp 28.000', '1x @ Rp 28.000', extraName: '+ Ekstra Sambal Pedas', extraPrice: '+Rp 2.000'),
                          const SizedBox(height: 10),
                          _itemDetailRow('Air Mineral Dingin', 'Rp 12.000', '2x @ Rp 6.000'),
                          const SizedBox(height: 12),
                          const Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
                          const SizedBox(height: 8),
                          _sumRow('Subtotal (4 Item / 6 Qty)', 'Rp 101.000'),
                          const SizedBox(height: 4),
                          _sumRow('PB1 / Pajak Resto (10%)', 'Rp 10.100'),
                          const SizedBox(height: 4),
                          _sumRow('Pembulatan', 'Rp 0'),
                          const SizedBox(height: 8),
                          const Divider(color: Colors.black, thickness: 1),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('TOTAL BAYAR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                              Text('Rp ${_formatPrice(totalBill)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Divider(color: Colors.grey, thickness: 1, indent: 10, endIndent: 10),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.03), borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                _sumRow('Metode Bayar', 'QRIS (GoPay/BCA)'),
                                const SizedBox(height: 4),
                                _sumRow('Reff ID', 'QR-20241024-882190'),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Status', style: TextStyle(fontSize: 11, color: AppColors.secondary)),
                                    Row(
                                      children: const [
                                        Icon(Icons.check_circle, size: 12, color: AppColors.primary),
                                        SizedBox(width: 4),
                                        Text('Sukses Lunas', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text('Terima kasih atas kunjungannya!\nNikmati gurih & renyahnya roll kami setiap hari.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: AppColors.secondary, height: 1.3)),
                          const SizedBox(height: 6),
                          const Text('Follow IG @chickencrunchyroll', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ],
                      ),
                    ),
                    ClipPath(
                      clipper: _JaggedClipper(isTop: false),
                      child: Container(
                        height: 12,
                        color: AppColors.surfaceContainerLow,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ReceiptActionBar(
              isWhatsAppSent: isWhatsAppSent,
              isPdfDownloaded: isPdfDownloaded,
              isPrinting: isPrinting,
              onWhatsAppTap: () {
                setState(() => isWhatsAppSent = true);
                Future.delayed(const Duration(seconds: 1), () {
                  if (!mounted) return;
                  setState(() => isWhatsAppSent = false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Struk terkirim ke WhatsApp!')));
                });
              },
              onDownloadPdfTap: () {
                setState(() => isPdfDownloaded = true);
                Future.delayed(const Duration(seconds: 1), () {
                  if (!mounted) return;
                  setState(() => isPdfDownloaded = false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF Struk berhasil diunduh!')));
                });
              },
              onPrintTap: _triggerPrint,
            ),
          ],
        ),
      ),
    );
  }

  Widget _receiptInfoRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.secondary)),
        Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
      ],
    );
  }

  Widget _itemDetailRow(String name, String price, String qtyDetail, {String? extraName, String? extraPrice, String? note}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface), overflow: TextOverflow.ellipsis)),
            Text(price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
          ],
        ),
        Text(qtyDetail, style: const TextStyle(fontSize: 10, color: AppColors.secondary)),
        if (extraName != null && extraPrice != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(extraName, style: const TextStyle(fontSize: 10, color: AppColors.primary)),
              Text(extraPrice, style: const TextStyle(fontSize: 10, color: AppColors.primary)),
            ],
          ),
        ],
        if (note != null) ...[
          Text(note, style: const TextStyle(fontSize: 9, fontStyle: FontStyle.italic, color: AppColors.secondary)),
        ],
      ],
    );
  }

  Widget _sumRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: AppColors.secondary)),
        Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.onSurface)),
      ],
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
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
