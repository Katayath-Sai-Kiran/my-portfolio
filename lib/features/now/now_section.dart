import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

class NowSection extends StatelessWidget {
  const NowSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: c.background),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: ResponsiveHelper.sectionV(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(c: c, isMobile: isMobile),
          SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
          _FocusGrid(c: c, isMobile: isMobile),
        ],
      ),
    );
  }
}

const _focusAreas = [
  _FocusArea(
    icon: '◈',
    title: 'AI Infrastructure',
    description:
        'Expanding the codespark ecosystem with new model formats, '
        'on-device fine-tuning experiments, and better developer ergonomics '
        'for offline ML in Flutter.',
  ),
  _FocusArea(
    icon: '▣',
    title: 'Package Architecture',
    description:
        'Standardizing API patterns across the 15-package ecosystem — '
        'consistent error handling, unified testing strategies, and '
        'cross-platform compatibility without compromise.',
  ),
  _FocusArea(
    icon: '⚙',
    title: 'Developer Tooling',
    description:
        'Building CLI tools and code generators that make Flutter '
        'package development faster. If it can be automated, it should be.',
  ),
  _FocusArea(
    icon: '▸',
    title: 'Technical Writing',
    description:
        'Documenting patterns that usually live in READMEs or nowhere. '
        'Architecture decisions, design rationale, and the kind of '
        'documentation I wish I\'d found.',
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
        Text(
          'NOW',
          style: AppTypography.monoSmall.copyWith(color: c.accent),
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: isMobile
                ? AppTypography.headlineMedium
                : AppTypography.displayLarge.copyWith(color: c.accent),
            children: [
              TextSpan(text: 'Currently focused '),
              TextSpan(
                text: 'here',
                style: TextStyle(fontStyle: FontStyle.italic, color: c.accent),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'The problems I\'m solving right now — and the ones I\'ve '
            'queued up for next.',
            style: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
      ],
    );
  }
}

class _FocusGrid extends StatelessWidget {
  const _FocusGrid({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_focusAreas.length, (i) {
        final fa = _focusAreas[i];
        final isLast = i == _focusAreas.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
          child: _FocusCard(focus: fa, c: c, isMobile: isMobile, index: i),
        );
      }),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({
    required this.focus,
    required this.c,
    required this.isMobile,
    required this.index,
  });
  final _FocusArea focus;
  final PortfolioColors c;
  final bool isMobile;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppGradients.forCard(c),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? c.border
              : c.borderSubtle,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            focus.icon,
            style: AppTypography.headlineLarge.copyWith(
              color: c.accent.withValues(
                alpha: Theme.of(context).brightness == Brightness.dark
                    ? 0.5
                    : 0.3,
              ),
              fontSize: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  focus.title,
                  style: AppTypography.titleLarge.copyWith(
                    color: c.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  focus.description,
                  style: AppTypography.bodyMedium.copyWith(
                    color: c.textSecondary,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(
      delay: Duration(milliseconds: 200 + index * 100),
      duration: 500.ms,
    );
  }
}

class _FocusArea {
  const _FocusArea({
    required this.icon,
    required this.title,
    required this.description,
  });
  final String icon;
  final String title;
  final String description;
}
