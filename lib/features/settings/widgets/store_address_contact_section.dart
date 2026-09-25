import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/store_provider.dart';

class StoreAddressContactSection extends ConsumerStatefulWidget {
  const StoreAddressContactSection({super.key});

  @override
  ConsumerState<StoreAddressContactSection> createState() => _StoreAddressContactSectionState();
}

class _StoreAddressContactSectionState extends ConsumerState<StoreAddressContactSection> {
  late final TextEditingController _address;
  late final TextEditingController _phone;
  late final TextEditingController _email;
  late final TextEditingController _instagram;

  @override
  void initState() {
    super.initState();
    final state = ref.read(storeProvider);
    _address = TextEditingController(text: state.displayValue('address'));
    _phone = TextEditingController(text: state.displayValue('phone'));
    _email = TextEditingController(text: state.displayValue('email'));
    _instagram = TextEditingController(text: state.displayValue('instagram'));
  }

  @override
  void dispose() {
    _address.dispose();
    _phone.dispose();
    _email.dispose();
    _instagram.dispose();
    super.dispose();
  }

  void _setDraft(String key, String value) {
    ref.read(storeProvider.notifier).setDraft(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(storeProvider).store;

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
                  controller: _address,
                  onChanged: (v) => _setDraft('address', v),
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
                Row(
                  children: [
                    const Icon(Icons.pin_drop, size: 16, color: AppColors.primary),
                    const SizedBox(width: 6),
                    Text(
                      'Koordinat GPS: ${store.latitude ?? '-'}, ${store.longitude ?? '-'}',
                      style: const TextStyle(
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
          _buildField('Kontak Telepon / WhatsApp Kasir', _phone, Icons.call, (v) => _setDraft('phone', v), keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          _buildField('Email Outlet', _email, Icons.alternate_email, (v) => _setDraft('email', v), keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 12),
          _buildField('Media Sosial / Instagram Toko', _instagram, Icons.share, (v) => _setDraft('instagram', v)),
        ],
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    IconData icon,
    ValueChanged<String> onChanged, {
    TextInputType? keyboardType,
  }) {
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
                  controller: controller,
                  onChanged: onChanged,
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
