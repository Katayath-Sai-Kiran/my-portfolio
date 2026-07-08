import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

const _disciplines = <_Discipline>[
    _Discipline(
      icon: '◆',
      name: 'Rendering',
      description:
          'CustomPainter, shader-based UI, and compositing pipelines. '
          'Building visual systems that don\'t exist in the framework — '
          'from particle fields to ink-like reveal animations.',
    ),
    _Discipline(
      icon: '◇',
      name: 'SDK Architecture',
      description:
          'Package design that anticipates how others will use it. '
          'Generic constraints, typed exceptions, conditional imports, '
          'and API surfaces that read like prose.',
    ),
    _Discipline(
      icon: '▣',
      name: 'Native Integration',
      description:
          'Kotlin, Swift, and platform channels. ExoPlayer pipelines, '
          'chunked upload engines, and native file systems — '
          'bridging Dart to the platform layer without friction.',
    ),
    _Discipline(
      icon: '⚙',
      name: 'Developer Tooling',
      description:
          'Scripts, generators, and CI systems that make the right '
          'thing easy. If a process hurts, automate it away before '
          'the muscle memory sets in.',
    ),
    _Discipline(
      icon: '◈',
      name: 'Infrastructure',
      description:
          'Firebase at scale — realtime backends, auth flows, '
          'cloud functions, and storage strategies. Systems that '
          'stay up when the prototype becomes production.',
    ),
    _Discipline(
      icon: '▸',
      name: 'Media Systems',
      description:
          'Video rendering, audio processing, and streaming pipelines. '
          'Custom player UIs, playlist management, and codec-level '
          'decisions for mobile-first playback.',
    ),
  ];

class CraftSection extends StatelessWidget {
  const CraftSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forCraft(c)),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: ResponsiveHelper.sectionV(context),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CraftHeader(c: c, isMobile: isMobile),
              SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
              if (isMobile)
                _MobileGrid(c: c)
              else
                _DesktopGrid(c: c),
            ],
          ),
    );
  }
}

class _CraftHeader extends StatelessWidget {
  const _CraftHeader({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CRAFT', style: AppTypography.monoSmall.copyWith(color: c.accent))
            .animate().fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: isMobile ? AppTypography.headlineMedium : AppTypography.displayLarge,
            children: [
              TextSpan(text: 'Disciplines I work '),
              TextSpan(text: 'in', style: TextStyle(fontStyle: FontStyle.italic, color: c.accent)),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'Six areas where I\'ve shipped production code — '
            'each with its own tooling, constraints, and craft.',
            style: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
      ],
    );
  }
}

class _DesktopGrid extends StatelessWidget {
  const _DesktopGrid({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _DesktopRow(startIndex: 0, c: c),
        const SizedBox(height: AppSpacing.lg),
        _DesktopRow(startIndex: 3, c: c),
      ],
    );
  }
}

class _DesktopRow extends StatelessWidget {
  const _DesktopRow({required this.startIndex, required this.c});
  final int startIndex;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(5, (i) {
        if (i.isOdd) return const SizedBox(width: AppSpacing.lg);
        final idx = startIndex + i ~/ 2;
        return Expanded(
          child: _CraftCard(discipline: _disciplines[idx], c: c, index: idx),
        );
      }),
    );
  }
}

class _MobileGrid extends StatelessWidget {
  const _MobileGrid({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_disciplines.length, (i) {
        return Padding(
          padding: EdgeInsets.only(bottom: i < _disciplines.length - 1 ? AppSpacing.md : 0),
          child: _CraftCard(discipline: _disciplines[i], c: c, index: i),
        );
      }),
    );
  }
}

class _CraftCard extends StatelessWidget {
  const _CraftCard({required this.discipline, required this.c, required this.index});
  final _Discipline discipline;
  final PortfolioColors c;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: AppGradients.forCard(c),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: c.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            discipline.icon,
            style: AppTypography.displayMedium.copyWith(
              color: c.accent.withValues(alpha: 0.3),
              fontSize: 28,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            discipline.name,
            style: AppTypography.titleLarge.copyWith(color: c.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            discipline.description,
            style: AppTypography.bodyMedium.copyWith(color: c.textSecondary, height: 1.6),
          ),
        ],
      ),
    ).animate().fadeIn(
      delay: Duration(milliseconds: 200 + index * 80),
      duration: 500.ms,
    );
  }
}

class _Discipline {
  const _Discipline({
    required this.icon,
    required this.name,
    required this.description,
  });
  final String icon;
  final String name;
  final String description;
}
