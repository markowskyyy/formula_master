import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/data/local/local_formulas_data.dart';
import 'package:formula_master/domain/entities/formula.dart';


// Провайдер для списка всех формул
final formulaListProvider = Provider<List<Formula>>((ref) {
  return mockFormulas;
});

// Провайдер для фильтрации по предмету
final formulaFilterProvider = StateProvider<Subject?>((ref) => null);

// Отфильтрованный список формул
final filteredFormulaListProvider = Provider<List<Formula>>((ref) {
  final formulas = ref.watch(formulaListProvider);
  final filter = ref.watch(formulaFilterProvider);

  if (filter == null) return formulas;
  return formulas.where((f) => f.subject == filter).toList();
});

// Провайдер для поиска
final formulaSearchQueryProvider = StateProvider<String>((ref) => '');

// Поиск по формулам
final searchedFormulaListProvider = Provider<List<Formula>>((ref) {
  final formulas = ref.watch(filteredFormulaListProvider);
  final query = ref.watch(formulaSearchQueryProvider);

  if (query.isEmpty) return formulas;

  return formulas.where((f) {
    final title = f.title.toLowerCase();
    final description = f.description.toLowerCase();
    final search = query.toLowerCase();
    return title.contains(search) || description.contains(search);
  }).toList();
});

// Провайдер для конкретной формулы по ID
final formulaByIdProvider = Provider.family<Formula?, String>((ref, id) {
  final formulas = ref.watch(formulaListProvider);
  try {
    return formulas.firstWhere((f) => f.id == id);
  } catch (e) {
    return null;
  }
});

// Провайдер для формул по предмету
final formulasBySubjectProvider = Provider.family<List<Formula>, Subject>((ref, subject) {
  final formulas = ref.watch(formulaListProvider);
  return formulas.where((f) => f.subject == subject).toList();
});