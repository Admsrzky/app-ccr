import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
