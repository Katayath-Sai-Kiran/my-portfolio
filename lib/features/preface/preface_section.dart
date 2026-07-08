import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/design/app_motion.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/providers/scroll_provider.dart';

class PrefaceSection extends StatelessWidget {
  const PrefaceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(gradient: AppGradients.forPreface(c)),
      padding: EdgeInsets.only(
        left: hPad,
        right: hPad,
        top: AppSpacing.navHeight + AppSpacing.xxl,
        bottom: AppSpacing.xxl,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: AppSpacing.maxContent),
            child: isMobile
                ? _MobileLayout(c: c)
                : _DesktopLayout(c: c),
          ),
          const Spacer(),
          _ScrollIndicator(c: c).animate().fadeIn(delay: 600.ms),
        ],
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 6,
          child: _HeroContent(c: c),
        ),
        const SizedBox(width: AppSpacing.xxxl),
        Expanded(
          flex: 4,
          child: _HeroAside(c: c),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _HeroContent(c: c),
        const SizedBox(height: AppSpacing.xl),
        _HeroAside(c: c),
      ],
    );
  }
}

class _HeroContent extends StatelessWidget {
  const _HeroContent({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final scroll = context.read<ScrollProvider>();
    final nameStyle = isMobile
        ? AppTypography.displayMedium
        : AppTypography.displayHero;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Name - stacked serif
        Text('SAI KIRAN', style: nameStyle.copyWith(color: c.textPrimary))
            .animate().fadeIn(duration: 400.ms).slideX(begin: -0.03, end: 0),
        Text('KATAYATH', style: nameStyle.copyWith(color: c.textPrimary))
            .animate().fadeIn(delay: 100.ms, duration: 400.ms).slideX(begin: -0.03, end: 0),
        Container(
          width: 80,
          height: 3,
          margin: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.lg),
          decoration: BoxDecoration(
            color: c.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate().fadeIn(delay: 200.ms).scaleX(begin: 0, end: 1),

        // Hook
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'I build Flutter tools other engineers reach for.',
            style: AppTypography.headlineMedium.copyWith(
              color: c.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ).animate().fadeIn(delay: 250.ms, duration: 500.ms),

        const SizedBox(height: AppSpacing.xl),

        // CTAs
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.sm,
          children: [
            _Cta(
              label: 'See my work',
              filled: true,
              onTap: () => scroll.scrollToSection(PortfolioSection.featuredProject),
            ),
            _Cta(
              label: 'GitHub',
              onTap: () => launchUrl(
                Uri.parse('https://github.com/Katayath-Sai-Kiran'),
              ),
            ),
            _Cta(
              label: 'Contact',
              onTap: () => scroll.scrollToSection(PortfolioSection.contact),
            ),
          ],
        ).animate().fadeIn(delay: 350.ms, duration: 400.ms),
      ],
    );
  }
}

class _HeroAside extends StatelessWidget {
  const _HeroAside({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _StatLine(label: 'ROLE', value: 'Flutter Engineer'),
        SizedBox(height: AppSpacing.sm * 1.5),
        _StatLine(label: 'EXPERIENCE', value: '5+ Years'),
        SizedBox(height: AppSpacing.sm * 1.5),
        _StatLine(label: 'PACKAGES', value: '15 on pub.dev'),
        SizedBox(height: AppSpacing.sm * 1.5),
        _StatLine(label: 'PHILOSOPHY', value: '"System package > snippet"'),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }
}

class _StatLine extends StatelessWidget {
  const _StatLine({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.monoSmall.copyWith(color: c.textMuted),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTypography.titleMedium.copyWith(color: c.textPrimary),
        ),
      ],
    );
  }
}

class _Cta extends StatefulWidget {
  const _Cta({
    required this.label,
    required this.onTap,
    this.filled = false,
  });
  final String label;
  final VoidCallback onTap;
  final bool filled;

  @override
  State<_Cta> createState() => _CtaState();
}

class _CtaState extends State<_Cta> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final bg = widget.filled
        ? (_hovered ? c.accentSubtle : c.accent)
        : (_hovered ? c.surfaceHover : Colors.transparent);
    final fg = widget.filled ? Colors.white : c.textPrimary;
    final border = widget.filled
        ? c.accent
        : (_hovered ? c.accent : c.border);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: border),
          ),
          child: Text(
            widget.label,
            style: AppTypography.labelLarge.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScrollIndicator extends StatelessWidget {
  const _ScrollIndicator({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.keyboard_arrow_down_rounded,
          size: 20,
          color: c.textMuted,
        ),
        const SizedBox(height: 4),
        Text(
          'EXPLORE',
          style: AppTypography.monoSmall.copyWith(
            color: c.textMuted,
            fontSize: 9,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
