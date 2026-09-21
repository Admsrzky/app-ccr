import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class StoreAddressContactSection extends StatelessWidget {
  const StoreAddressContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return NeomorphicContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.map, size: 20, color: AppColors.primary),
              SizedBox(width: 8),
              Text(
                'Alamat & Titik Kontak',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Alamat Fisik
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Alamat Fisik (Tercetak di Struk)',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const Text(
                    'MAKS 150 KARAKTER',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              NeomorphicContainer(
                borderRadius: 12,
                isInset: true,
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: TextEditingController(
                    text: 'Jl. Senopati No. 42, RT.05/RW.02, Selong, Kebayoran Baru, Jakarta Selatan, DKI Jakarta 12110',
                  ),
                  maxLines: 3,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Titik Lokasi / Maps Visual Card
          NeomorphicContainer(
            borderRadius: 12,
            isInset: true,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.pin_drop, size: 16, color: AppColors.primary),
                    SizedBox(width: 6),
                    Text(
                      'Koordinat GPS: -6.2285, 106.8091',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 112,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuBoHD7gQzVPOUCeRuNX2C3TWYOdSWNLRcR82uIXdgt0cAtaTVEzON9LROUfWR0PRsgAOlyVLZTZTWgoeKD52ymDp2hOOr1nKElSe8f3qJ1sIbZAsDm3A7Xv2AN5HLR58c9BrVQ4r_bSJsdLPAnG0ZtF_KrU7OKkveFRY3n2YoFWLvbkB-LTqBKXB5dZDuZCJB3SjmB_rYHb4KfQEezXbD79rhk3GyNkstua1IqVLAEKY8K59pV_bQlD',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: NeomorphicContainer(
                        borderRadius: 999,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Membuka Peta & Kalibrasi GPS...')),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.navigation, size: 14, color: AppColors.primary),
                            SizedBox(width: 6),
                            Text(
                              'Pin Lokasi di Peta',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _buildField('Kontak Telepon / WhatsApp Kasir', '0812-3456-7890', Icons.call),
          const SizedBox(height: 12),
          _buildField('Email Outlet', 'senopati01@chickencrunchyroll.com', Icons.alternate_email, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _buildField('Media Sosial / Instagram Toko', '@chickencrunchyroll', Icons.share),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value, IconData icon, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 6),
        NeomorphicContainer(
          borderRadius: 12,
          isInset: true,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColors.primary),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: value),
                  keyboardType: keyboardType,
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
