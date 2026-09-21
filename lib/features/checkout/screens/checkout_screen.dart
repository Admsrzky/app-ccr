import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';
import 'receipt_screen.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(checkoutProvider);
    final notifier = ref.read(checkoutProvider.notifier);

    final double subtotal = 110000;
    final double tax = 11000;
    final double totalBill = subtotal + tax;
    final double change = state.cashReceived > totalBill ? state.cashReceived - totalBill : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Custom Header
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.surface.withOpacity(0.9),
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
                          child: Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.onSurface),
                        ),
                      ),
                      const Text(
                        'Pembayaran',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                      ),
                      NeomorphicContainer(
                        borderRadius: 999,
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuBLJfD0xvn83QOioJOP2Ghue4jetWDRe_irJEkj-nrgHA-erjQCCYeeXy15d_rcn34MVnYBUjePzkGhFyoiJNlS5TDkgoWnHeI_A4SV2_3USMyAKFj1oCx_-lPeFR0PFfN7V9ZjWGse-UyC1IfFDroo0mleQRrv_QIIev_Inuxgtht9edsKaeXwPNlayQmdq7b20Av7ulxWUGV6yRsANw4MOFRrOJNSvUkMFPFiRLS5seN6Qa_OSeDj',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status & Table Info Pill
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                NeomorphicContainer(
                                  borderRadius: 12,
                                  width: 36,
                                  height: 36,
                                  child: const Center(
                                    child: Icon(Icons.receipt_long, color: AppColors.primary, size: 20),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Nomor Order', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                    const Text('#CR-1049', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                  ],
                                ),
                              ],
                            ),
                            NeomorphicContainer(
                              borderRadius: 12,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text('Meja 04 • Sarah A.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Order Type Selector (Dine In / Takeaway)
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => notifier.setOrderType('Dine In'),
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: state.orderType != 'Dine In',
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.restaurant, size: 16, color: state.orderType == 'Dine In' ? AppColors.primary : AppColors.secondary),
                                      const SizedBox(width: 6),
                                      Text('Dine In', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: state.orderType == 'Dine In' ? AppColors.primary : AppColors.secondary)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: GestureDetector(
                                onTap: () => notifier.setOrderType('Takeaway'),
                                child: NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: state.orderType != 'Takeaway',
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.takeout_dining, size: 16, color: state.orderType == 'Takeaway' ? AppColors.primary : AppColors.secondary),
                                      const SizedBox(width: 6),
                                      Text('Takeaway', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: state.orderType == 'Takeaway' ? AppColors.primary : AppColors.secondary)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Customer Name Input (Optional)
                        NeomorphicContainer(
                          borderRadius: 12,
                          isInset: true,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              const Icon(Icons.person_outline, size: 18, color: AppColors.outline),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(text: state.customerName),
                                  onChanged: (val) => notifier.setCustomerName(val),
                                  decoration: const InputDecoration(
                                    hintText: 'Nama Pelanggan (Opsional)',
                                    hintStyle: TextStyle(fontSize: 11, color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.onSurface),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Order Items Recap Card (Collapsible)
                        NeomorphicContainer(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () => notifier.toggleSummaryExpanded(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        NeomorphicContainer(
                                          borderRadius: 12,
                                          width: 36,
                                          height: 36,
                                          isInset: true,
                                          child: const Center(
                                            child: Icon(Icons.fastfood, color: AppColors.primary, size: 20),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Ringkasan Pesanan (3 Item)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                            Text('Tap untuk rincian belanja', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    NeomorphicContainer(
                                      borderRadius: 8,
                                      width: 32,
                                      height: 32,
                                      child: Center(
                                        child: Icon(
                                          state.isSummaryExpanded ? Icons.expand_less : Icons.expand_more,
                                          size: 18,
                                          color: AppColors.onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (state.isSummaryExpanded) ...[
                                const Divider(height: 24),
                                const Column(
                                  children: [
                                    _OrderItemRow(
                                      name: 'Fire Nashville Roll',
                                      detail: '2x @ Rp 39.000 (Level 3 Pedas)',
                                      price: 'Rp 78.000',
                                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCQk-9ng6SY-K-jfaZER-LxzLXG-6PGKrW3rnyGijRL3RD7_IphrXq_aGZuMojWZbPPfAxzJELXejTU8_vOWerXc0wIf_gxBPVz0QlBLZwxfRjqvDwnAZxs407Bx3nNVyRfQ94QUsvVmFJHvULS18-UskPW1IHYKfS30OMukHcXhaxLkaseFytI480lMafb3jkZs20spey3d10qApOysm5freWECGpZR7jpUf7GghivChKsxGMY_cKq',
                                    ),
                                    SizedBox(height: 12),
                                    _OrderItemRow(
                                      name: 'Crunchy Cheesy Roll',
                                      detail: '1x @ Rp 32.000 (Extra Cheese)',
                                      price: 'Rp 32.000',
                                      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAdECqLcgOK21SDj-e3bvZ2bysRH1o1JKfx6qyL36_I8eqwC9aHcFxv_P2Y9RZsZHZgW1A5mx3mphSpWSGR-GhhwEBiFhCWK4hXuDhCE0IRkX1iWJBONlCL0NIUiYwTQGuTLVnLSsK3B50KJzaH1ijTGEtn0-3fTKnIl26E6OJFCx1DWtVFBnGyZAdhy9qJ-JCfOKvJEmRQktSxY_0uxsJfcM04Ao6XPMB5Emtm5TyFb4-9RhNG3ZNj',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: true,
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    children: [
                                      _calcRow('Subtotal Makanan', 'Rp ${_formatPrice(subtotal)}'),
                                      const SizedBox(height: 6),
                                      _calcRow('PB1 Resto (10%)', 'Rp ${_formatPrice(tax)}'),
                                      const Divider(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Total Tagihan', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                          Text('Rp ${_formatPrice(totalBill)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Payment Method Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('METODE PEMBAYARAN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurfaceVariant, letterSpacing: 0.5)),
                            Row(
                              children: const [
                                Icon(Icons.bolt, size: 14, color: AppColors.tertiary),
                                SizedBox(width: 4),
                                Text('Instan Settlement', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.tertiary)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 44,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildMethodTab(notifier, state.selectedMethod, 'qris', Icons.qr_code_scanner, 'QRIS Digital'),
                              const SizedBox(width: 8),
                              _buildMethodTab(notifier, state.selectedMethod, 'cash', Icons.payments, 'Tunai (Cash)'),
                              const SizedBox(width: 8),
                              _buildMethodTab(notifier, state.selectedMethod, 'edc', Icons.credit_card, 'EDC Kartu'),
                              const SizedBox(width: 8),
                              _buildMethodTab(notifier, state.selectedMethod, 'transfer', Icons.account_balance, 'Transfer Bank'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Dynamic Method Views (QRIS view simplified since QRIS is on outlet sticker)
                        if (state.selectedMethod == 'qris') ...[
                          NeomorphicContainer(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                NeomorphicContainer(
                                  borderRadius: 14,
                                  width: 48,
                                  height: 48,
                                  child: const Center(
                                    child: Icon(Icons.qr_code_scanner, color: AppColors.primary, size: 24),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'QRIS Outlet Aktif',
                                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        'Silakan arahkan pelanggan untuk memindai stiker QRIS yang tertempel di kasir / meja untuk membayar Rp ${_formatPrice(totalBill)}.',
                                        style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (state.selectedMethod == 'cash') ...[
                          NeomorphicContainer(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Rekomendasi Uang Diterima:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 2.2,
                                  children: [
                                    _cashButton(notifier, state.cashReceived, totalBill, totalBill, 'Uang Pas'),
                                    _cashButton(notifier, state.cashReceived, totalBill, 150000, 'Pecahan 150K'),
                                    _cashButton(notifier, state.cashReceived, totalBill, 200000, 'Pecahan 2x 100K'),
                                    GestureDetector(
                                      onTap: () async {
                                        String? res = await _showCustomCashDialog(context);
                                        if (res != null && double.tryParse(res) != null) {
                                          notifier.setCashReceived(double.parse(res));
                                        }
                                      },
                                      child: NeomorphicContainer(
                                        borderRadius: 12,
                                        padding: const EdgeInsets.all(10),
                                        child: const Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Input Manual', style: TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                                            Text('Nominal Lain...', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: true,
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Uang Kembali:', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                          Text('Rp ${_formatPrice(change)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                                        ],
                                      ),
                                      const Icon(Icons.toll, color: AppColors.primary, size: 24),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (state.selectedMethod == 'edc') ...[
                          NeomorphicContainer(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    NeomorphicContainer(
                                      borderRadius: 12,
                                      width: 40,
                                      height: 40,
                                      child: const Center(child: Icon(Icons.point_of_sale, color: AppColors.primary)),
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Swipe / Dip Kartu pada Mesin EDC', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                          Text('Support BCA, Mandiri, BRI, Visa, Mastercard', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                NeomorphicContainer(
                                  borderRadius: 12,
                                  isInset: true,
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Nominal Tertera:', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                      Text('Rp ${_formatPrice(totalBill)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (state.selectedMethod == 'transfer') ...[
                          NeomorphicContainer(
                            borderRadius: 16,
                            padding: const EdgeInsets.all(16),
                            child: NeomorphicContainer(
                              borderRadius: 12,
                              isInset: true,
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('BCA Bisnis (Chicken Crunchy Roll)', style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                                      Text('882-901-4431', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                                    ],
                                  ),
                                  NeomorphicContainer(
                                    borderRadius: 8,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    onTap: () {
                                      Clipboard.setData(const ClipboardData(text: '8829014431'));
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Nomor Rekening disalin!')));
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.content_copy, size: 14, color: AppColors.primary),
                                        SizedBox(width: 4),
                                        Text('Salin', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 24),
                        // Confirm Pay Button
                        NeomorphicContainer(
                          borderRadius: 16,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          onTap: () => notifier.setSuccessModalVisible(true),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
                              const SizedBox(width: 8),
                              Text('Konfirmasi Bayar Rp ${_formatPrice(totalBill)}', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Success Modal Overlay
            if (state.isSuccessModalVisible)
              Container(
                color: Colors.black54,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(color: Color(0x20000000), blurRadius: 24, offset: Offset(0, 10)),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NeomorphicContainer(
                          borderRadius: 20,
                          width: 64,
                          height: 64,
                          child: const Center(
                            child: Icon(Icons.verified, size: 32, color: AppColors.primary),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(999), boxShadow: const [BoxShadow(color: Color(0x10000000), blurRadius: 4, offset: Offset(2, 2))]),
                          child: const Text('Lunas • ID: TR-20241012', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primary)),
                        ),
                        const SizedBox(height: 8),
                        const Text('Transaksi Berhasil!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                        const SizedBox(height: 4),
                        const Text('Pesanan #CR-1049 telah diteruskan ke dapur roll dan tercatat pada cloud POS.', textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
                        const SizedBox(height: 16),
                        NeomorphicContainer(
                          borderRadius: 12,
                          isInset: true,
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              _receiptRow('Metode Bayar:', state.selectedMethod.toUpperCase()),
                              const SizedBox(height: 4),
                              _receiptRow('Waktu:', 'Hari ini, 13:42 WIB'),
                              const SizedBox(height: 4),
                              _receiptRow('Total Dibayar:', 'Rp ${_formatPrice(totalBill)}', isBold: true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Quick Action Buttons
                        NeomorphicContainer(
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: () {
                            notifier.setSuccessModalVisible(false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ReceiptScreen()),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.receipt, size: 16, color: AppColors.primary),
                              SizedBox(width: 8),
                              Text('Lihat Struk Pelanggan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        NeomorphicContainer(
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: () {
                            notifier.setPrinting(true);
                            Future.delayed(const Duration(seconds: 1), () {
                              if (!context.mounted) return;
                              notifier.setPrinting(false);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Struk thermal sukses dicetak!')));
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.print, size: 16, color: AppColors.primary),
                              const SizedBox(width: 8),
                              Text(state.isPrinting ? 'Mencetak...' : 'Cetak Struk Thermal (Bluetooth)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        NeomorphicContainer(
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Link struk terkirim via WhatsApp')));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.chat, size: 16, color: AppColors.tertiary),
                              SizedBox(width: 8),
                              Text('Kirim Struk via WhatsApp', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        NeomorphicContainer(
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          onTap: () {
                            notifier.setSuccessModalVisible(false);
                            Navigator.pop(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle, size: 16, color: AppColors.primary),
                              SizedBox(width: 8),
                              Text('Pesanan Baru (+)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodTab(CheckoutNotifier notifier, String current, String id, IconData icon, String label) {
    final isSelected = current == id;
    return GestureDetector(
      onTap: () => notifier.setPaymentMethod(id),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                  BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                ],
                gradient: const LinearGradient(colors: [Color(0xFFDCDFE6), Color(0xFFF0F2F8)]),
              )
            : BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(3, 3), blurRadius: 6),
                  BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-3, -3), blurRadius: 6),
                ],
              ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? AppColors.primary : AppColors.secondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cashButton(CheckoutNotifier notifier, double currentReceived, double totalBill, double amount, String label) {
    final isSelected = currentReceived == amount;
    return GestureDetector(
      onTap: () => notifier.setCashReceived(amount),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? const [
                  BoxShadow(color: Color(0x10000000), offset: Offset(2, 2), blurRadius: 4),
                  BoxShadow(color: Color(0x80FFFFFF), offset: Offset(-2, -2), blurRadius: 4),
                ]
              : const [
                  BoxShadow(color: AppColors.neoDarkShadow, offset: Offset(3, 3), blurRadius: 6),
                  BoxShadow(color: AppColors.neoLightShadow, offset: Offset(-3, -3), blurRadius: 6),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
            const SizedBox(height: 2),
            Text('Rp ${_formatPrice(amount)}', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isSelected ? AppColors.primary : AppColors.onSurface)),
          ],
        ),
      ),
    );
  }

  Future<String?> _showCustomCashDialog(BuildContext context) async {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Input Nominal Tunai'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: 'Contoh: 150000'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          ElevatedButton(onPressed: () => Navigator.pop(context, controller.text), child: const Text('OK')),
        ],
      ),
    );
  }

  Widget _calcRow(String title, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
        Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
      ],
    );
  }

  Widget _receiptRow(String title, String val, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant)),
        Text(val, style: TextStyle(fontSize: 11, fontWeight: isBold ? FontWeight.bold : FontWeight.w600, color: isBold ? AppColors.primary : AppColors.onSurface)),
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

class _OrderItemRow extends StatelessWidget {
  final String name;
  final String detail;
  final String price;
  final String imageUrl;

  const _OrderItemRow({
    required this.name,
    required this.detail,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 44,
                  height: 44,
                  color: AppColors.surfaceContainer,
                  child: Image.network(imageUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Text(detail, style: const TextStyle(fontSize: 10, color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          Text(price, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
