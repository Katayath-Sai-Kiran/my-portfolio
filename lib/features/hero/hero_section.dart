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
import 'widgets/typewriter_block.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isWide = ResponsiveHelper.isWide(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final vPad = ResponsiveHelper.sectionVerticalPadding(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      color: c.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: isWide
              ? _DesktopLayout(c: c)
              : _MobileLayout(c: c),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 5, child: _HeroText(c: c)),
        const SizedBox(width: 72),
        Expanded(flex: 4, child: _TypewriterPanel(c: c)),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 48),
        _TypewriterPanel(c: c),
        const SizedBox(height: 52),
        _HeroText(c: c, centerAlign: true),
      ],
    );
  }
}

// ── Typewriter panel ──────────────────────────────────────────────────────────

class _TypewriterPanel extends StatelessWidget {
  const _TypewriterPanel({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        // Glow behind block
        Positioned(
          child: Container(
            width: 320,
            height: 220,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  c.accent.withValues(alpha: 0.12),
                  Colors.transparent,
                ],
                radius: 1.2,
              ),
            ),
          ),
        ),
        const TypewriterBlock()
            .animate()
            .fadeIn(delay: 300.ms, duration: 700.ms)
            .slideX(begin: 0.08, end: 0),
      ],
    );
  }
}

// ── Hero text block ───────────────────────────────────────────────────────────

class _HeroText extends StatelessWidget {
  const _HeroText({required this.c, this.centerAlign = false});
  final PortfolioColors c;
  final bool centerAlign;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final scrollProvider = context.read<ScrollProvider>();
    final align = centerAlign ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Init marker
        Text(
          '// init',
          style: AppTextStyles.mono.copyWith(color: c.orange, fontSize: 13),
          textAlign: textAlign,
        ).animate().fadeIn(duration: 350.ms),

        const SizedBox(height: 20),

        // Name — split into two lines for visual weight
        Column(
          crossAxisAlignment: align,
          children: [
            Text(
              'Sai Kiran',
              style: (isMobile ? AppTextStyles.displayMedium : AppTextStyles.displayLarge)
                  .copyWith(color: c.textPrimary, height: 1.05),
              textAlign: textAlign,
            ),
            Text(
              'Katayath.',
              style: (isMobile ? AppTextStyles.displayMedium : AppTextStyles.displayLarge)
                  .copyWith(color: c.accent, height: 1.05),
              textAlign: textAlign,
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 100.ms, duration: 500.ms)
            .slideY(begin: 0.18, end: 0),

        const SizedBox(height: 24),

        // Opening statement
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'I build Flutter tools other engineers actually reach for.',
            style: AppTextStyles.headlineMedium.copyWith(
              color: c.textSecondary,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
            textAlign: textAlign,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 450.ms),

        const SizedBox(height: 20),

        // Body paragraph
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            '5 years. Production apps shipped across 3 platforms. '
            '12 open-source packages on pub.dev. Every line written because '
            'something didn\'t exist — or existed badly.',
            style: AppTextStyles.bodyLarge.copyWith(
              color: c.textMuted,
              height: 1.75,
              fontSize: isMobile ? 15 : 17,
            ),
            textAlign: textAlign,
          ),
        ).animate().fadeIn(delay: 280.ms, duration: 450.ms),

        const SizedBox(height: 32),

        // Stats row
        _StatsRow(c: c, align: align)
            .animate()
            .fadeIn(delay: 360.ms, duration: 400.ms),

        const SizedBox(height: 36),

        // CTA row
        Wrap(
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroButton(
              label: 'View Packages',
              primary: true,
              c: c,
              onTap: () => scrollProvider.scrollToSection(PortfolioSection.openSource),
            ),
            _HeroButton(
              label: 'GitHub',
              c: c,
              onTap: () => launchUrl(Uri.parse(AppStrings.githubUrl)),
            ),
            _HeroButton(
              label: 'Contact',
              c: c,
              onTap: () => scrollProvider.scrollToSection(PortfolioSection.contact),
            ),
            if (AppStrings.resumeUrl.isNotEmpty)
              _HeroButton(
                label: 'Resume',
                c: c,
                onTap: () => launchUrl(Uri.parse(AppStrings.resumeUrl)),
              ),
          ],
        ).animate().fadeIn(delay: 420.ms, duration: 400.ms),

        const SizedBox(height: 52),

        _ScrollHint(
          c: c,
          onTap: () => scrollProvider.scrollToSection(PortfolioSection.openSource),
        ).animate().fadeIn(delay: 800.ms, duration: 600.ms),
      ],
    );
  }
}

// ── Stats row ─────────────────────────────────────────────────────────────────

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.c, required this.align});
  final PortfolioColors c;
  final CrossAxisAlignment align;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final stats = [
      (value: '12', label: 'packages'),
      (value: '${PortfolioData.totalDownloads}+', label: 'downloads'),
      (value: '5 yrs', label: 'experience'),
    ];

    return Row(
      mainAxisAlignment: align == CrossAxisAlignment.center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: stats.asMap().entries.expand((e) {
        final items = <Widget>[
          _StatItem(value: e.value.value, label: e.value.label, c: c, isMobile: isMobile),
        ];
        if (e.key < stats.length - 1) {
          items.add(Container(
            width: 1,
            height: 28,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            color: c.border,
          ));
        }
        return items;
      }).toList(),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.c,
    required this.isMobile,
  });
  final String value, label;
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: AppTextStyles.headlineMedium.copyWith(
            color: c.accent,
            fontWeight: FontWeight.w700,
            fontSize: isMobile ? 20 : 22,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.mono.copyWith(
            fontSize: 10,
            color: c.textMuted,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

// ── Scroll hint ───────────────────────────────────────────────────────────────

class _ScrollHint extends StatefulWidget {
  const _ScrollHint({required this.onTap, required this.c});
  final VoidCallback onTap;
  final PortfolioColors c;

  @override
  State<_ScrollHint> createState() => _ScrollHintState();
}

class _ScrollHintState extends State<_ScrollHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
    _bounce = Tween(begin: 0.0, end: 6.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _bounce,
              builder: (_, __) => Transform.translate(
                offset: Offset(0, _bounce.value),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: widget.c.textMuted,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'scroll to explore',
              style: AppTextStyles.mono.copyWith(
                fontSize: 11,
                color: widget.c.textMuted,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Hero button ───────────────────────────────────────────────────────────────

class _HeroButton extends StatefulWidget {
  const _HeroButton({
    required this.label,
    required this.onTap,
    required this.c,
    this.primary = false,
  });

  final String label;
  final VoidCallback onTap;
  final PortfolioColors c;
  final bool primary;

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hovered ? c.orange : c.orange.withValues(alpha: 0.88))
                : (_hovered ? c.surfaceHover : c.surface),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.primary
                  ? c.orange
                  : (_hovered ? c.accent : c.border),
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: widget.primary
                  ? Colors.white
                  : (_hovered ? c.textPrimary : c.textSecondary),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
