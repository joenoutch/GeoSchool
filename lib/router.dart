import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/shell/scaffold_nav.dart';
import 'features/home/home_page.dart';
import 'features/articles/articles_page.dart';
import 'features/directory/directory_page.dart';
import 'features/map/map_page.dart';
import 'features/premium/premium_page.dart';
import 'features/establishment/detail_page.dart';
import 'features/auth/login_page.dart';
import 'features/auth/register_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    // Shell + bottom nav
    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) => ScaffoldWithNavBar(navShell: navShell),
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/', builder: (_, __) => const HomePage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: '/articles', builder: (_, __) => const ArticlesPage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: '/directory', builder: (_, __) => const DirectoryPage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: '/map', builder: (_, __) => const MapPage())],
        ),
        StatefulShellBranch(
          routes: [GoRoute(path: '/premium', builder: (_, __) => const PremiumPage())],
        ),
      ],
    ),

    // Détail établissement
    GoRoute(
      path: '/e/:slug',
      name: 'establishment.show',
      builder: (context, state) => EstablishmentDetailPage(slug: state.pathParameters['slug']!),
    ),

    // Auth
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
  ],
);
