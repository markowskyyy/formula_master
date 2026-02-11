import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        title: const Text('Тесты'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              SearchBar(
                onChanged: (value) {
                  ref.read(testSearchQueryProvider.notifier).state = value;
                },
                // onClear: () {
                //   ref.read(testSearchQueryProvider.notifier).state = '';
                // },
                hintText: 'Поиск тестов...',
              ),
              SubjectFilterChips(
                selectedSubject: filter,
                onSubjectSelected: (subject) {
                  ref.read(testFilterProvider.notifier).state = subject;
                },
              ),
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