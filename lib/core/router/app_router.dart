import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/home_page.dart';
import '../../features/packages/package_detail_page.dart';
import '../../shared/data/portfolio_data.dart';

abstract final class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: HomePage(),
        ),
      ),
      GoRoute(
        path: '/packages/:slug',
        pageBuilder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          final pkg = PortfolioData.packages
              .where((p) => p.slug == slug)
              .firstOrNull;

          return CustomTransitionPage(
            key: state.pageKey,
            child: PackageDetailPage(pkg: pkg ?? PortfolioData.packages.first),
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final slideIn = CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              );
              final slideOut = CurvedAnimation(
                parent: secondaryAnimation,
                curve: Curves.easeInCubic,
              );
              return SlideTransition(
                position: Tween(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(slideIn),
                child: SlideTransition(
                  position: Tween(
                    begin: Offset.zero,
                    end: const Offset(-0.3, 0),
                  ).animate(slideOut),
                  child: child,
                ),
              );
            },
          );
        },
      ),
    ],
  );
}
