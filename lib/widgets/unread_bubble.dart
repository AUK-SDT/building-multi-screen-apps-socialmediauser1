import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class UnreadBubble extends StatelessWidget {
  final int count;
  const UnreadBubble({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final label = count > 999 ? '999+' : count.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.unreadBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
