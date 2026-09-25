import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/store_provider.dart';

class StoreBrandForm extends ConsumerStatefulWidget {
  const StoreBrandForm({super.key});

  @override
  ConsumerState<StoreBrandForm> createState() => _StoreBrandFormState();
}

class _StoreBrandFormState extends ConsumerState<StoreBrandForm> {
  late final TextEditingController _brandName;
  late final TextEditingController _branchName;
  late final TextEditingController _slogan;
  late final TextEditingController _businessType;

  @override
  void initState() {
    super.initState();
    final state = ref.read(storeProvider);
    _brandName = TextEditingController(text: state.displayValue('brandName'));
    _branchName = TextEditingController(text: state.displayValue('branchName'));
    _slogan = TextEditingController(text: state.displayValue('slogan'));
    _businessType = TextEditingController(text: state.displayValue('businessType'));
  }

  @override
  void dispose() {
    _brandName.dispose();
    _branchName.dispose();
    _slogan.dispose();
    _businessType.dispose();
    super.dispose();
  }

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
              Icon(Icons.badge, size: 20, color: AppColors.primary),
              SizedBox(width: 8),
              Text('Informasi Brand & Usaha', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.onSurface)),
            ],
          ),
          const SizedBox(height: 16),
          _buildTextField('Nama Usaha / Brand', _brandName, Icons.store, (v) => ref.read(storeProvider.notifier).setDraft('brandName', v)),
          const SizedBox(height: 12),
          _buildTextField('Nama Cabang / Outlet', _branchName, Icons.apartment, (v) => ref.read(storeProvider.notifier).setDraft('branchName', v)),
          const SizedBox(height: 12),
          _buildTextField('Slogan / Tagline Cetak Struk', _slogan, Icons.format_quote, (v) => ref.read(storeProvider.notifier).setDraft('slogan', v)),
          const SizedBox(height: 12),
          _buildTextField('Kategori Usaha', _businessType, Icons.fastfood, (v) => ref.read(storeProvider.notifier).setDraft('businessType', v)),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon, ValueChanged<String> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.onSurfaceVariant)),
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
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
