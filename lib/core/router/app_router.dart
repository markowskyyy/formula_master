import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formula_master/presentation/pages/catalog_screen.dart';
import 'package:formula_master/presentation/pages/collection_screen.dart';
import 'package:formula_master/presentation/pages/profile_screen.dart';
import 'package:formula_master/presentation/pages/statistics_screen.dart';
import 'package:formula_master/presentation/pages/test_screen.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/catalog',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          key: state.pageKey,
          child: ScaffoldWithNavBar(navigationShell: navigationShell),
        );
      },
      branches: [
        // Вкладка 1: Библиотека формул
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/catalog',
              name: 'catalog',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CatalogScreen(),
              ),
              // Здесь можно добавить детальный экран формулы если понадобится
              // routes: [
              //   GoRoute(
              //     path: 'detail/:formulaId',
              //     name: 'formulaDetail',
              //     pageBuilder: (context, state) {
              //       final formulaId = state.pathParameters['formulaId']!;
              //       return MaterialPage(
              //         child: DetailScreen(formulaId: formulaId),
              //       );
              //     },
              //   ),
              // ],
            ),
          ],
        ),

        // Вкладка 2: Тесты
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/collection',
              name: 'collection',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: CollectionScreen(),
              ),
            ),
          ],
        ),

        // Вкладка 3: Достижения
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/statistics',
              name: 'statistics',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: StatisticsScreen(),
              ),
            ),
          ],
        ),

        // Вкладка 4: Профиль
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
            ),
          ],
        ),
      ],
    ),

    // Отдельный маршрут для экрана теста (поверх навигации)
    GoRoute(
      path: '/test/:testId',
      name: 'test',
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) {
        final testId = state.pathParameters['testId']!;
        return MaterialPage(
          child: TestScreen(testId: testId),
        );
      },
    ),
  ],
);


class ScaffoldWithNavBar extends ConsumerWidget {
  const ScaffoldWithNavBar({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[400],
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Библиотека',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_outlined),
            activeIcon: Icon(Icons.quiz),
            label: 'Тесты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events_outlined),
            activeIcon: Icon(Icons.emoji_events),
            label: 'Достижения',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

