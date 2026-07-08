import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

class ManifestoSection extends StatelessWidget {
  const ManifestoSection({super.key});

  static const _principles = [
    _Principle(
      number: '01',
      tag: 'PHILOSOPHY',
      title: 'System package > snippet',
      body:
          'A well-architected package outlives every project it powers. Snippets '
          'solve today; packages solve next year. Every tool on pub.dev began as '
          'a personal frustration — the refusal to write the same boilerplate twice.',
    ),
    _Principle(
      number: '02',
      tag: 'APPROACH',
      title: 'Fix your own problems first',
      body:
          'The best time to build a package is when you catch yourself copying '
          'code between projects. That irritation is a signal — an unmet need '
          'that others share. Ship it properly once, and the ecosystem improves '
          'for everyone.',
    ),
    // _Principle(
    //   number: '03',
    //   tag: 'CRAFT',
    //   title: 'Design matters at every layer',
    //   body:
    //       'API surface is UX. Type signatures are prose. Error messages are '
    //       'documentation. A package should feel good to hold in your hands — '
    //       'predictable, discoverable, and honest about what it does and doesn\'t do.',
    // ),
    _Principle(
      number: '04',
      tag: 'ECOSYSTEM',
      title: 'Build with, not for',
      body:
          'The 15 packages on pub.dev aren\'t a portfolio — they\'re a '
          'conversation. Each one answered a question another developer was '
          'asking. Good open source doesn\'t broadcast; it responds to '
          'the shape of real problems.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forManifesto(c)),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: ResponsiveHelper.sectionV(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(c: c, isMobile: isMobile),
          SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
          ...List.generate(_principles.length, (i) {
            final p = _principles[i];
            final isLast = i == _principles.length - 1;
            return _PrincipleCard(
              principle: p,
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MANIFESTO',
          style: AppTypography.monoSmall.copyWith(color: c.accent),
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: isMobile ? AppTypography.headlineMedium : AppTypography.displayLarge,
            children: [
              TextSpan(text: 'The principles behind the '),
              TextSpan(text: 'packages', style: TextStyle(fontStyle: FontStyle.italic, color: c.accent)),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'Every package on pub.dev started with a question. These are the '
            'convictions that shaped the answers.',
            style: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
      ],
    );
  }
}

class _PrincipleCard extends StatelessWidget {
  const _PrincipleCard({
    required this.principle,
    required this.c,
    required this.isMobile,
    required this.isLast,
    required this.index,
  });
  final _Principle principle;
  final PortfolioColors c;
  final bool isMobile;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? AppSpacing.lg : AppSpacing.xl),
          decoration: BoxDecoration(
            gradient: AppGradients.forQuote(c),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: c.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    principle.tag,
                    style: AppTypography.monoSmall.copyWith(
                      color: c.accent,
                      fontSize: 10,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    principle.number,
                    style: AppTypography.displayLarge.copyWith(
                      color: c.accent.withValues(alpha: 0.12),
                      fontSize: isMobile ? 40 : 52,
                      height: 0.9,
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? AppSpacing.sm : AppSpacing.md),
              Text(
                principle.title,
                style:
                    (isMobile
                            ? AppTypography.headlineMedium
                            : AppTypography.headlineLarge)
                        .copyWith(color: c.textPrimary),
              ),
              SizedBox(height: isMobile ? AppSpacing.sm : AppSpacing.md),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  principle.body,
                  style: AppTypography.bodyLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.75,
                  ),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(
          delay: Duration(milliseconds: 200 + index * 100),
          duration: 500.ms,
        ),
        if (!isLast) const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

class _Principle {
  const _Principle({
    required this.number,
    required this.tag,
    required this.title,
    required this.body,
  });
  final String number;
  final String tag;
  final String title;
  final String body;
}
