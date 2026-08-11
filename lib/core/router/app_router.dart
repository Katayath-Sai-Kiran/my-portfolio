import 'package:go_router/go_router.dart';
import '../../features/home/home_page.dart';
import '../../features/packages/package_detail_page.dart';
import '../../features/packages/packages_list_page.dart';
import '../../features/contact/conversation_starter_page.dart';
import '../../shared/data/portfolio_data.dart';

abstract final class AppRouter {
  static const home = 'home';
  static const packagesList = 'packages-list';
  static const packageDetail = 'package-detail';
  static const conversationStarter = 'conversation-starter';

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/packages',
        name: packagesList,
        builder: (context, state) => const PackagesListPage(),
      ),
      GoRoute(
        path: '/packages/:slug',
        name: packageDetail,
        builder: (context, state) {
          final slug = state.pathParameters['slug'] ?? '';
          final pkg = PortfolioData.packages
              .where((p) => p.slug == slug)
              .firstOrNull;
          return PackageDetailPage(pkg: pkg ?? PortfolioData.packages.first);
        },
      ),
      GoRoute(
        path: '/conversation-start',
        name: conversationStarter,
        builder: (context, state) => const ConversationStarterPage(),
      ),
    ],
  );
}
