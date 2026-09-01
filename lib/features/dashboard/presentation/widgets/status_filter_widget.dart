import 'package:flutter/material.dart';

class StatusFilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;

  const StatusFilterChips({
    super.key,
    this.filters = const ['All', 'Pending', 'In Progress', 'Completed'],
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = index == selectedIndex;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF007AFF) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF007AFF)
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              filters[index],
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          );
        },
      ),
    );
  }
}
