import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/core/consts/design.dart';
import 'package:formula_master/presentation/providers/formula_provider.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';


class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formulas = ref.watch(searchedFormulaListProvider);
    final filter = ref.watch(formulaFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Библиотека формул', style: AppTextStyles.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Column(
            children: [
              // SearchBar(
              //   onChanged: (value) {
              //     ref.read(formulaSearchQueryProvider.notifier).state = value;
              //   },
              //   onTap: () {
              //     ref.read(formulaSearchQueryProvider.notifier).state = '';
              //   },
              // ),
              SubjectFilterChips(
                selectedSubject: filter,
                onSubjectSelected: (subject) {
                  ref.read(formulaFilterProvider.notifier).state = subject;
                },
              ),
              const Gap(16),
              Divider(height: 1, color: AppColors.line)
            ],
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: formulas.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final formula = formulas[index];
          return FormulaCard(formula: formula);
        },
      ),
    );
  }
}