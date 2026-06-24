import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/providers/scroll_provider.dart';
import '../../shared/widgets/brutal.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isWide = ResponsiveHelper.isWide(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      color: c.background,
      padding: EdgeInsets.only(
        left: hPad,
        right: hPad,
        top: AppDimensions.navBarHeight + 48,
        bottom: 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: isWide ? _DesktopLayout(c: c) : _MobileLayout(c: c),
        ),
      ),
    );
  }
}

// ── Desktop ───────────────────────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _Available(),
        const SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 6, child: _HeroText(c: c)),
            const SizedBox(width: 56),
            Expanded(flex: 4, child: _SpecSheet(c: c)),
          ],
        ),
      ],
    );
  }
}

// ── Mobile ────────────────────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const _Available(),
        const SizedBox(height: 28),
        _HeroText(c: c),
        const SizedBox(height: 36),
        _SpecSheet(c: c),
      ],
    );
  }
}

// ── "Available" status strip ────────────────────────────────────────────────

class _Available extends StatelessWidget {
  const _Available();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 9, height: 9, color: c.success),
        const SizedBox(width: 8),
        Text(
          'AVAILABLE FOR WORK — FLUTTER',
          style: AppTextStyles.monoSmall.copyWith(color: c.textSecondary, fontSize: 11),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms);
  }
}

// ── Hero text block ───────────────────────────────────────────────────────────

class _HeroText extends StatelessWidget {
  const _HeroText({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final scroll = context.read<ScrollProvider>();
    final nameStyle = (isMobile ? AppTextStyles.displayLarge : AppTextStyles.heroDisplay);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Name — stacked, last line in accent.
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SAI', style: nameStyle.copyWith(color: c.textPrimary)),
            Text('KIRAN', style: nameStyle.copyWith(color: c.textPrimary)),
            Text('KATAYATH.', style: nameStyle.copyWith(color: c.accent)),
          ],
        ).animate().fadeIn(delay: 80.ms, duration: 420.ms).slideX(begin: -0.04, end: 0),

        const SizedBox(height: 28),

        // One spare, confident statement.
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            'I build Flutter tools other engineers reach for.',
            style: AppTextStyles.headlineMedium.copyWith(
              color: c.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

        const SizedBox(height: 36),

        // CTAs.
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            BrutalButton(
              label: 'See the packages',
              filled: true,
              onTap: () => scroll.scrollToSection(PortfolioSection.openSource),
            ),
            BrutalButton(
              label: 'GitHub',
              onTap: () => launchUrl(Uri.parse(AppStrings.githubUrl)),
            ),
            BrutalButton(
              label: 'Contact',
              onTap: () => scroll.scrollToSection(PortfolioSection.contact),
            ),
          ],
        ).animate().fadeIn(delay: 320.ms, duration: 400.ms),
      ],
    );
  }
}

// ── Spec sheet (replaces the old typewriter panel) ──────────────────────────

class _SpecSheet extends StatelessWidget {
  const _SpecSheet({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final rows = <(String, String)>[
      ('ROLE', 'Flutter Engineer'),
      ('PACKAGES', '${PortfolioData.packages.length} on pub.dev'),
      ('INSTALLS', '${PortfolioData.totalDownloads}+'),
      ('EXPERIENCE', '5 years'),
      ('PLATFORMS', 'iOS · Android · Web'),
    ];

    return BrutalBox(
      shadow: true,
      shadowColor: c.accent,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bar
          Container(
            width: double.infinity,
            color: c.textPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'SPEC SHEET',
              style: AppTextStyles.monoSmall.copyWith(color: c.background, fontSize: 11),
            ),
          ),
          ...rows.asMap().entries.map((e) {
            final last = e.key == rows.length - 1;
            return Container(
              decoration: BoxDecoration(
                border: last
                    ? null
                    : Border(bottom: BorderSide(color: c.border, width: 1.5)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 96,
                    child: Text(
                      e.value.$1,
                      style: AppTextStyles.monoSmall.copyWith(color: c.textMuted, fontSize: 10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      e.value.$2,
                      style: AppTextStyles.titleMedium.copyWith(color: c.textPrimary),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ).animate().fadeIn(delay: 260.ms, duration: 500.ms).slideY(begin: 0.06, end: 0);
  }
}
