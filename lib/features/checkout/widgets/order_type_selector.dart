import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/neomorphic_container.dart';
import '../providers/checkout_provider.dart';

class OrderTypeSelector extends StatelessWidget {
  final CheckoutState state;
  final CheckoutNotifier notifier;

  const OrderTypeSelector({
    super.key,
    required this.state,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
