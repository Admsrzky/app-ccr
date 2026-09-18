import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';

class PosHeader extends StatelessWidget {
  final String cashierName;
  final String branchName;

  const PosHeader({
    super.key,
    this.cashierName = 'Sarah Amelia',
    this.branchName = 'Shift Pagi • Outlet Senopati 01',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface.withOpacity(0.95),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Shift info
          Expanded(
            child: Row(
              children: [
                NeomorphicContainer(
                  borderRadius: 12,
                  width: 44,
                  height: 44,
                  padding: const EdgeInsets.all(6),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida/AEtjO1UyEr8gZQi0ehK4OpAlri4iIZSayDk1VYnh-4MD7SvubkZr_8VyIMWtrj3Sfc6XewTQrlhX3EHwWlmi8rkoEU35Dq7NfeLE95mrLf6ZBKWp6JZmY5nLnsU-F51ZxkoLF2sUhjWbwEttKgAQ7Zwvjuw57AdPtmv8bgqhrmIndLZoB8E6Uv1Y9ADgyDW2hiodmPRKdbitNzUyno_uRq_5jp76l_iDPtoFW665MXn5eozZsCxXKmg-Z3f1cA',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.fastfood, color: AppColors.primary),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Chicken Crunchy Roll',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: NeomorphicContainer(
                              borderRadius: 999,
                              isInset: true,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              child: Text(
                                branchName,
                                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: AppColors.primary),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Cashier profile
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    cashierName,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.onSurface),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'KASIR ON DUTY',
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: AppColors.onSurfaceVariant, letterSpacing: 0.5),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              NeomorphicContainer(
                borderRadius: 999,
                width: 44,
                height: 44,
                padding: const EdgeInsets.all(2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida/AEtjO1VucKIa1OSbkyiFhkXS9nOk5iHzhQ6o5ZCSIhm7Dy-xVyWPRrw6ZJ-FSUam3Eeg53sPq5DDmejOBMx-xI1hQN5M0jPeMOrAJHVoX9fDMAwzH5Gazbg_EdSUdXbdxJzLYpfBGGMcPKdYk1-BoreR3UChKWFHKmsblgFdWoluExNupstGMDsEqOEnY12LT5ltxpp7HVdKQnYxmfHy5HMzGsbQc5-7lpIhaM6GLL6o0TFAi3aN4e_sU9zMQjA',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.account_circle, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
