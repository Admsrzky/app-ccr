import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../widgets/store_intro_banner.dart';
import '../widgets/store_hero_card.dart';
import '../widgets/store_brand_form.dart';
import '../widgets/store_address_contact_section.dart';
import '../widgets/store_operating_hours_section.dart';

class StoreProfileScreen extends ConsumerStatefulWidget {
  const StoreProfileScreen({super.key});

  @override
  ConsumerState<StoreProfileScreen> createState() => _StoreProfileScreenState();
}

class _StoreProfileScreenState extends ConsumerState<StoreProfileScreen> {
  bool _isSaving = false;
  String _saveButtonText = 'Simpan Perubahan Profil Toko';
  IconData _saveButtonIcon = Icons.check_circle;
  bool _isSavedSuccess = false;

  void _handleSave() async {
    setState(() {
      _isSaving = true;
      _saveButtonText = 'Perubahan Tersimpan!';
      _saveButtonIcon = Icons.done_all;
      _isSavedSuccess = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil toko berhasil diperbarui!')),
    );

    await Future.delayed(const Duration(milliseconds: 2200));

    if (mounted) {
      setState(() {
        _isSaving = false;
        _saveButtonText = 'Simpan Perubahan Profil Toko';
        _saveButtonIcon = Icons.check_circle;
        _isSavedSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Header
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.85),
                boxShadow: const [
                  BoxShadow(color: Color(0x08000000), offset: Offset(0, 4), blurRadius: 16),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      NeomorphicContainer(
                        borderRadius: 999,
                        width: 44,
                        height: 44,
                        onTap: () => Navigator.pop(context),
                        child: const Center(
                          child: Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Image.network(
                        'https://lh3.googleusercontent.com/aida/AEtjO1WNNYWJG_hysU6DyW0zPliMgmAAmXRZxv5guQgwMG3XejB8Opgw66UrHEdAowdLlGOgIWCxPWg4NI6hrXV3ZBXeGMfCs2Skwz7LcLrSvQQUv4hl_QcQvX9YtUhOMtQ9MO4Y0ToRYGJTqHIrodOc2lhafgo-WgYQUDauFY0Q1-J7pZoOkUOSajHGfigqtwISzpEY0VH-ZST5B1f1uwJbL8JR_Zz3szHgp7H-ki2SWJfbIb9r1LFwG6gdYw',
                        height: 32,
                        width: 32,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                      ),
                      const SizedBox(width: 8),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CHICKEN CRUNCHY ROLL',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant, letterSpacing: 0.5),
                          ),
                          Text(
                            'Profil & Alamat Toko',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const StoreIntroBanner(),
                    const SizedBox(height: 16),
                    const StoreHeroCard(),
                    const SizedBox(height: 16),
                    const StoreBrandForm(),
                    const SizedBox(height: 16),
                    const StoreAddressContactSection(),
                    const SizedBox(height: 16),
                    const StoreOperatingHoursSection(),
                    const SizedBox(height: 24),
                    // Save Button & Metadata
                    NeomorphicContainer(
                      borderRadius: 14,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      onTap: _isSaving ? null : _handleSave,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _saveButtonIcon,
                            size: 20,
                            color: _isSavedSuccess ? Colors.green : AppColors.primary,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            _saveButtonText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _isSavedSuccess ? Colors.green : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'Terakhir diperbarui oleh ',
                          style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
                          children: [
                            TextSpan(
                              text: 'Sarah Amelia',
                              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.onSurface),
                            ),
                            TextSpan(text: ' • Kemarin 17:30 WIB'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
