import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

class EcosystemSection extends StatelessWidget {
  const EcosystemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forEcosystem(c)),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: ResponsiveHelper.sectionV(context),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(c: c, isMobile: isMobile),
              SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
              ...List.generate(_categories.length, (i) {
                final cat = _categories[i];
                final isLast = i == _categories.length - 1;
                return _CategoryGroup(
                  category: cat,
                  c: c,
                  isMobile: isMobile,
                  isLast: isLast,
                  index: i,
                );
              }),
            ],
          ),
    );
  }
}

const _categories = <_Category>[
  _Category(
    name: 'On-Device AI',
    icon: '◈',
    count: '3 packages',
    description: 'Offline ML inference and semantic understanding — no server required.',
    packages: [
      _Package(
        name: 'ai_core_codespark',
        description: 'Core embedding engine with MiniLM model. Shared dependency for all codespark AI packages.',
        url: 'https://pub.dev/packages/ai_core_codespark',
      ),
      _Package(
        name: 'semantic_search_codespark',
        description: 'Query-driven semantic search with typed results, MMR diversity, and debounced input.',
        url: 'https://pub.dev/packages/semantic_search_codespark',
      ),
      _Package(
        name: 'smart_suggestions_codespark',
        description: 'Anchor-based recommendations, multi-anchor centroid matching, MMR diversity, and display widgets.',
        url: 'https://pub.dev/packages/smart_suggestions_codespark',
      ),
    ],
  ),
  _Category(
    name: 'Text & UI',
    icon: '▣',
    count: '9 packages',
    description: 'Typography, formatting, and rendering utilities for rich text experiences.',
    packages: [
      _Package(
        name: 'text_comparison_score_codespark',
        description: 'String similarity with Levenshtein, Damerau-Levenshtein, and Jaro-Winkler. Fuzzy matching and case-insensitive comparison.',
        url: 'https://pub.dev/packages/text_comparison_score_codespark',
      ),
      _Package(
        name: 'text_highlight_codespark',
        description: 'Rich text highlighting widget — single/multi-query, regex, per-term colors, tappable spans.',
        url: 'https://pub.dev/packages/text_highlight_codespark',
      ),
      _Package(
        name: 'date_formatter_codespark',
        description: 'DateTime formatting, relative time, time-ago, calendar math, and human-readable dates. Zero dependencies.',
        url: 'https://pub.dev/packages/date_formatter_codespark',
      ),
      _Package(
        name: 'advanced_text_input_formatters_codespark',
        description: 'Custom TextInputFormatters — simulate typing, block clipboard, enforce naming conventions, and more.',
        url: 'https://pub.dev/packages/advanced_text_input_formatters_codespark',
      ),
      _Package(
        name: 'icon_to_text_extension_codespark',
        description: 'Convert any IconData to inline Text or TextSpan. Material, Cupertino, and custom icon font support.',
        url: 'https://pub.dev/packages/icon_to_text_extension_codespark',
      ),
      _Package(
        name: 'dual_tone_text_codespark',
        description: 'Dual-tone gradient text rendering — vertical, horizontal, radial, and wave color splits.',
        url: 'https://pub.dev/packages/dual_tone_text_codespark',
      ),
      _Package(
        name: 'curved_text_codespark',
        description: 'Render text along circular, spiral, wave, elliptical, or custom paths with animation and styling.',
        url: 'https://pub.dev/packages/curved_text_codespark',
      ),
      _Package(
        name: 'rich_highlight_text_codespark',
        description: 'Extension methods to highlight substrings in Text or String using Text.rich and custom styles.',
        url: 'https://pub.dev/packages/rich_highlight_text_codespark',
      ),
      _Package(
        name: 'read_more_codespark',
        description: 'Expandable and collapsible text widget with customizable truncation and toggle animations.',
        url: 'https://pub.dev/packages/read_more_codespark',
      ),
    ],
  ),
  _Category(
    name: 'Developer Utilities',
    icon: '⚙',
    count: '3 packages',
    description: 'Tooling and utilities that make Flutter development faster and more reliable.',
    packages: [
      _Package(
        name: 'animated_dropdown_search_codespark',
        description: 'Searchable animated dropdown widget with smooth animations, text highlighting, and multi-select.',
        url: 'https://pub.dev/packages/animated_dropdown_search_codespark',
      ),
      _Package(
        name: 'internet_quality_codespark',
        description: 'Measure real-world internet quality using latency-based analysis. DNS, socket, and HTTP checks.',
        url: 'https://pub.dev/packages/internet_quality_codespark',
      ),
      _Package(
        name: 'context_extensions_codespark',
        description: 'BuildContext extensions — MediaQuery helpers, responsive design, snackbar, dialogs, theme, keyboard.',
        url: 'https://pub.dev/packages/context_extensions_codespark',
      ),
    ],
  ),
];

class _Header extends StatelessWidget {
  const _Header({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ECOSYSTEM', style: AppTypography.monoSmall.copyWith(color: c.accent))
            .animate().fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: isMobile ? AppTypography.headlineMedium : AppTypography.displayLarge,
            children: [
              TextSpan(text: '15 packages on '),
              TextSpan(text: 'pub.dev', style: TextStyle(fontStyle: FontStyle.italic, color: c.accent)),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'Organized into three groups — AI, text/UI, and tooling. '
            'Each package started as a fix for a problem worth solving once.',
            style: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
      ],
    );
  }
}

class _CategoryGroup extends StatelessWidget {
  const _CategoryGroup({
    required this.category,
    required this.c,
    required this.isMobile,
    required this.isLast,
    required this.index,
  });
  final _Category category;
  final PortfolioColors c;
  final bool isMobile;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              category.icon,
              style: AppTypography.headlineLarge.copyWith(
                color: c.accent.withValues(alpha: 0.4),
                fontSize: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: AppTypography.titleLarge.copyWith(color: c.textPrimary),
                ),
                Text(
                  category.count,
                  style: AppTypography.bodySmall.copyWith(color: c.textMuted),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          category.description,
          style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
        ),
        SizedBox(height: isMobile ? AppSpacing.md : AppSpacing.lg),
        ...List.generate(category.packages.length, (i) {
          final pkg = category.packages[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i < category.packages.length - 1 ? AppSpacing.sm : 0),
            child: _PackageRow(pkg: pkg, c: c, index: index * 100 + i),
          );
        }),
        if (!isLast) SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
      ],
    ).animate().fadeIn(
      delay: Duration(milliseconds: 200 + index * 120),
      duration: 500.ms,
    );
  }
}

class _PackageRow extends StatelessWidget {
  const _PackageRow({required this.pkg, required this.c, required this.index});
  final _Package pkg;
  final PortfolioColors c;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(pkg.url)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          gradient: AppGradients.forCard(c),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.borderSubtle),
        ),
        child: Row(
          children: [
            Icon(Icons.inventory_2_outlined, size: 16, color: c.accent),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pkg.name,
                    style: AppTypography.labelLarge.copyWith(
                      color: c.textPrimary,
                      fontFamily: 'JetBrains Mono',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    pkg.description,
                    style: AppTypography.bodySmall.copyWith(
                      color: c.textMuted,
                      height: 1.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(Icons.open_in_new, size: 12, color: c.textMuted),
          ],
        ),
      ),
    ).animate().fadeIn(
      delay: Duration(milliseconds: 200 + index * 30),
      duration: 400.ms,
    );
  }
}

class _Category {
  const _Category({
    required this.name,
    required this.icon,
    required this.count,
    required this.description,
    required this.packages,
  });
  final String name;
  final String icon;
  final String count;
  final String description;
  final List<_Package> packages;
}

class _Package {
  const _Package({
    required this.name,
    required this.description,
    required this.url,
  });
  final String name;
  final String description;
  final String url;
}
