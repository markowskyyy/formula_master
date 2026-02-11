import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/core/consts/design.dart';
import 'package:formula_master/presentation/providers/test_provider.dart';
import 'package:formula_master/presentation/ui_kit/ui_kit.dart';

class CollectionScreen extends ConsumerWidget {
  const CollectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tests = ref.watch(searchedTestListProvider);
    final filter = ref.watch(testFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Тесты', style: AppTextStyles.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(44),
          child: Column(
            children: [
              SubjectFilterChips(
                selectedSubject: filter,
                onSubjectSelected: (subject) {
                  ref.read(testFilterProvider.notifier).state = subject;
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
        itemCount: tests.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final test = tests[index];
          return TestCard(test: test);
        },
      ),
    );
  }
}