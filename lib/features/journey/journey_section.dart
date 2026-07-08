import 'package:flutter/material.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

const _chapters = <_Chapter>[
  _Chapter(
    year: '2026',
    role: 'Flutter Engineer',
    org: 'Enspirit',
    location: 'Hyderabad',
    highlights: [
      '15 packages on pub.dev across AI, text/UI, and dev tooling',
      'On-device ML with ai_core_codespark ecosystem',
      'Semantic search and smart suggestions engines',
    ],
  ),
  _Chapter(
    year: '2021 – 2025',
    role: 'Flutter Developer',
    org: 'Wielabs',
    location: 'Hyderabad',
    highlights: [
      'ExoPlayer pipelines and custom media players',
      'Chunked upload engines and native Kotlin bridges',
      'Realtime Firebase backends and cloud infrastructure',
      'Custom rendering and animated UI systems',
    ],
  ),
];

class JourneySection extends StatelessWidget {
  const JourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forJourney(c)),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: ResponsiveHelper.sectionV(context),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JourneyHeader(c: c, isMobile: isMobile),
          SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.xxl),
          _JourneyMetrics(c: c, isMobile: isMobile),
          SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
          if (isMobile) _MobileDiptych(c: c) else _DesktopDiptych(c: c),
        ],
      ),
    );
  }
}

class _JourneyHeader extends StatelessWidget {
  const _JourneyHeader({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'JOURNEY',
          style: AppTypography.monoSmall.copyWith(color: c.accent),
        ),
        const SizedBox(height: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: isMobile ? AppTypography.headlineMedium : AppTypography.displayLarge,
            children: [
              TextSpan(text: 'The path to '),
              TextSpan(text: 'here', style: TextStyle(fontStyle: FontStyle.italic, color: c.accent)),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'Two chapters, 5+ years of Flutter. Each one a distinct world.',
            style: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _JourneyMetrics extends StatelessWidget {
  const _JourneyMetrics({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('15', 'packages'),
      ('5+', 'years of Flutter'),
      ('2', 'chapters'),
    ];
    if (isMobile) {
      return Wrap(
        spacing: AppSpacing.xl,
        runSpacing: AppSpacing.md,
        children: stats.map((s) => _StatItem(value: s.$1, label: s.$2, c: c)).toList(),
      );
    }
    return Row(
      children: List.generate(stats.length, (i) {
        final s = stats[i];
        return Expanded(
          child: Row(
            children: [
              if (i > 0) Container(width: 1, height: 40, color: c.borderSubtle),
              const SizedBox(width: AppSpacing.xl),
              _StatItem(value: s.$1, label: s.$2, c: c),
            ],
          ),
        );
      }),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label, required this.c});
  final String value;
  final String label;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppTypography.displayMedium.copyWith(color: c.accent, fontSize: 32, fontWeight: FontWeight.w700)),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: AppTypography.labelLarge.copyWith(color: c.textMuted)),
      ],
    );
  }
}

class _DesktopDiptych extends StatelessWidget {
  const _DesktopDiptych({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _Panel(chapter: _chapters[1], c: c, isLeading: true),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: _Panel(chapter: _chapters[0], c: c, isLeading: false),
          ),
        ],
      ),
    );
  }
}

class _MobileDiptych extends StatelessWidget {
  const _MobileDiptych({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Panel(chapter: _chapters[0], c: c, isLeading: false),
        const SizedBox(height: AppSpacing.md),
        _Panel(chapter: _chapters[1], c: c, isLeading: true),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.chapter,
    required this.c,
    required this.isLeading,
  });
  final _Chapter chapter;
  final PortfolioColors c;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    return ClipPath(
      clipper: _PanelClipper(isLeading: !isMobile ? isLeading : false),
      child: Container(
        padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
        decoration: BoxDecoration(
          gradient: isLeading ? AppGradients.forQuote(c) : AppGradients.forCard(c),
          border: Border.all(
            color: isLeading ? c.borderSubtle : c.accent.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isLeading
                        ? c.border.withValues(alpha: 0.3)
                        : c.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    chapter.year,
                    style: AppTypography.monoSmall.copyWith(
                      color: isLeading ? c.textMuted : c.accent,
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  isLeading ? 'PAST' : 'NOW',
                  style: AppTypography.monoSmall.copyWith(
                    color: isLeading
                        ? c.textMuted.withValues(alpha: 0.4)
                        : c.accent,
                    fontSize: 9,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              chapter.role,
              style:
                  (isMobile
                          ? AppTypography.headlineMedium
                          : AppTypography.headlineLarge)
                      .copyWith(
                        color: isLeading ? c.textSecondary : c.textPrimary,
                      ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              '${chapter.org} · ${chapter.location}',
              style: AppTypography.titleMedium.copyWith(
                color: isLeading ? c.textMuted : c.accent,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ...chapter.highlights.map(
              (h) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isLeading ? '·' : '—',
                      style: AppTypography.monoSmall.copyWith(
                        color: isLeading ? c.textMuted : c.accent,
                        fontSize: isLeading ? 10 : 12,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        h,
                        style: AppTypography.bodyMedium.copyWith(
                          color: isLeading ? c.textMuted : c.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            if (!isMobile)
              Align(
                alignment: isLeading
                    ? Alignment.bottomLeft
                    : Alignment.bottomRight,
                child: Icon(
                  isLeading
                      ? Icons.arrow_back_rounded
                      : Icons.arrow_forward_rounded,
                  size: 16,
                  color: isLeading
                      ? c.textMuted.withValues(alpha: 0.3)
                      : c.accent,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PanelClipper extends CustomClipper<Path> {
  const _PanelClipper({required this.isLeading});
  final bool isLeading;

  @override
  Path getClip(Size size) {
    final path = Path();
    final gap = 28.0;

    if (isLeading) {
      path.moveTo(0, 0);
      path.lineTo(size.width - gap, 0);
      path.lineTo(size.width, size.height * 0.5);
      path.lineTo(size.width - gap, size.height);
      path.lineTo(0, size.height);
      path.close();
    } else {
      path.moveTo(gap, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
      path.lineTo(gap, size.height);
      path.lineTo(0, size.height * 0.5);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(covariant _PanelClipper old) => old.isLeading != isLeading;
}

class _Chapter {
  const _Chapter({
    required this.year,
    required this.role,
    required this.org,
    required this.location,
    required this.highlights,
  });
  final String year;
  final String role;
  final String org;
  final String location;
  final List<String> highlights;
}
