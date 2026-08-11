import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/widgets/nav_bar.dart';
import '../home/widgets/category_header.dart';
import '../home/widgets/pkg_grid.dart';

class PackagesListPage extends StatelessWidget {
  const PackagesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    return Scaffold(
      backgroundColor: c.background,
      body: Column(
        children: [
          const PortfolioNavBar(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 48),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.go('/'),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_rounded, size: 16, color: c.textMuted),
                          const SizedBox(width: 8),
                          Text(
                            'Back',
                            style: AppTypography.labelLarge.copyWith(color: c.textMuted),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'ALL PACKAGES',
                      style: AppTypography.monoSmall.copyWith(
                        color: c.textMuted,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Fifteen packages,\none ecosystem.',
                      style: (isMobile
                              ? AppTypography.headlineLarge
                              : AppTypography.displayMedium)
                          .copyWith(color: c.textPrimary, height: 1.1),
                    ),
                    const SizedBox(height: 56),
                    _CategoryBlock(category: PkgCategory.onDeviceAI, c: c),
                    const SizedBox(height: 40),
                    _CategoryBlock(category: PkgCategory.textUI, c: c),
                    const SizedBox(height: 40),
                    _CategoryBlock(category: PkgCategory.devUtilities, c: c),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryBlock extends StatelessWidget {
  const _CategoryBlock({required this.category, required this.c});
  final PkgCategory category;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final packages = PortfolioData.packages
        .where((p) => p.isLive && p.category == category)
        .toList();
    if (packages.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryHeader(category: category),
        const SizedBox(height: 16),
        PkgGrid(packages: packages),
      ],
    );
  }
}
