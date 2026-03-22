import 'package:flutter/material.dart';
import '../models/chat_item.dart';
import '../theme/app_theme.dart';

class Avatar extends StatelessWidget {
  final ChatItem item;
  final double size;

  const Avatar({super.key, required this.item, this.size = 60});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.asset(
        item.imagePath ?? '',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.avatarFallback,
          ),
          child: Icon(Icons.person, color: AppColors.hint, size: size * 0.5),
        ),
      ),
    );
  }
}
