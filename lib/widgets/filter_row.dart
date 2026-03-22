import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class FilterRow extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const FilterRow({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const labels = ['All', 'Unread', 'Pinned'];
    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        scrollDirection: Axis.horizontal,
        itemCount: labels.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final selected = selectedIndex == i;
          return ChoiceChip(
            label: Text(labels[i]),
            selected: selected,
            onSelected: (_) => onChanged(i),
            labelStyle: TextStyle(
              fontSize: 13,
              color: selected ? Colors.white : AppColors.hint,
            ),
          );
        },
      ),
    );
  }
}
