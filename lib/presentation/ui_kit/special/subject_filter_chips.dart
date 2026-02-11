import 'package:flutter/material.dart';
import 'package:formula_master/domain/entities/formula.dart';


class SubjectFilterChips extends StatelessWidget {
  final Subject? selectedSubject;
  final ValueChanged<Subject?> onSubjectSelected;

  const SubjectFilterChips({
    super.key,
    required this.selectedSubject,
    required this.onSubjectSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _FilterChip(
            label: 'Все',
            isSelected: selectedSubject == null,
            onTap: () => onSubjectSelected(null),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Математика',
            isSelected: selectedSubject == Subject.mathematics,
            onTap: () => onSubjectSelected(Subject.mathematics),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Физика',
            isSelected: selectedSubject == Subject.physics,
            onTap: () => onSubjectSelected(Subject.physics),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Химия',
            isSelected: selectedSubject == Subject.chemistry,
            onTap: () => onSubjectSelected(Subject.chemistry),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}