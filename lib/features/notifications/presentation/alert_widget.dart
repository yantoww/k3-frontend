import 'package:flutter/material.dart';
import '../../../core/constants/styles.dart';
import '../../../core/constants/colors.dart';
import '../data/notification_model.dart';

class AlertWidget extends StatelessWidget {
  final NotificationItem item;

  const AlertWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.isRead ? AppColors.card : AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: AppStyles.title),
          const SizedBox(height: 6),
          Text(item.message, style: AppStyles.body),
          const SizedBox(height: 8),
          Text(
            item.date,
            style: AppStyles.caption.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
