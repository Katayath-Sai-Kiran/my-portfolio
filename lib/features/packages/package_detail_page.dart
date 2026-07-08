import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';

class PackageDetailPage extends StatefulWidget {
  const PackageDetailPage({super.key, required this.pkg});
  final OpenSourcePackage pkg;

  @override
  State<PackageDetailPage> createState() => _PackageDetailPageState();
}

class _PackageDetailPageState extends State<PackageDetailPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _curtainCtrl;
  late final Animation<double> _curtainAnim;
  bool _curtainDone = false;

  @override
  void initState() {
    super.initState();
    _curtainCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _curtainAnim = CurvedAnimation(
      parent: _curtainCtrl,
      curve: Curves.easeInOutCubic,
    );
    _curtainCtrl.addStatusListener((s) {
      if (s == AnimationStatus.completed && mounted) {
        setState(() => _curtainDone = true);
      }
    });
    // Auto-reveal after 1.6 s
    Timer(const Duration(milliseconds: 1600), () {
      if (mounted) _curtainCtrl.forward();
    });
  }

  @override
  void dispose() {
    _curtainCtrl.dispose();
    super.dispose();
  }

  void _triggerReveal() {
    if (!_curtainCtrl.isAnimating && _curtainCtrl.value == 0) {
      _curtainCtrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return Scaffold(
      backgroundColor: c.background,
      body: Stack(
        children: [
          // ── Full scrollable content (always underneath) ──────────────────
          _DetailContent(pkg: widget.pkg, onBack: () => context.pop()),

          // ── Reveal curtain (slides up and disappears) ────────────────────
          if (!_curtainDone)
            AnimatedBuilder(
              animation: _curtainAnim,
              builder: (ctx, _) {
                final screenH = MediaQuery.sizeOf(ctx).height;
                return Transform.translate(
                  offset: Offset(0, -screenH * _curtainAnim.value),
                  child: _RevealCurtain(
                    pkg: widget.pkg,
                    onTap: _triggerReveal,
                    revealProgress: _curtainAnim.value,
                  ),
                );
              },
            ),
          // _RevealCurtain(
          //   pkg: widget.pkg,
          //   onTap: _triggerReveal,
          //   revealProgress: _curtainAnim.value,
          // ),
        ],
      ),
    );
  }
}

// ── Reveal curtain ────────────────────────────────────────────────────────────

class _RevealCurtain extends StatefulWidget {
  const _RevealCurtain({
    required this.pkg,
    required this.onTap,
    required this.revealProgress,
  });
  final OpenSourcePackage pkg;
  final VoidCallback onTap;
  final double revealProgress;

  @override
  State<_RevealCurtain> createState() => _RevealCurtainState();
}

class _RevealCurtainState extends State<_RevealCurtain>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceCtrl;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _bounce = Tween(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(parent: _bounceCtrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final size = MediaQuery.sizeOf(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return GestureDetector(
      onTap: widget.onTap,
      onVerticalDragUpdate: (d) {
        if (d.delta.dy < -4) widget.onTap();
      },
      child: Container(
        width: size.width,
        height: size.height,
        color: c.background,
        child: Stack(
          children: [
            // Glow
            Positioned.fill(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        c.accent.withValues(alpha: 0.1),
                        Colors.transparent,
                      ],
                      radius: 1.0,
                    ),
                  ),
                ),
              ),
            ),

            // Content
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveHelper.sectionH(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Pkg / status label
                  _StatusLabel(pkg: widget.pkg, c: c),

                  const SizedBox(height: 28),

                  // Big display name
                  Text(
                    widget.pkg.displayName,
                    style:
                        (isMobile
                                ? AppTextStyles.headlineLarge
                                : AppTextStyles.displayMedium)
                            .copyWith(color: c.textPrimary, height: 1.05),
                  ),

                  if (widget.pkg.tagline != null) ...[
                    const SizedBox(height: 20),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 560),
                      child: Text(
                        widget.pkg.tagline!,
                        style: AppTextStyles.titleLarge.copyWith(
                          color: c.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 40),

                  // Download count
                  if (widget.pkg.downloads != null) ...[
                    Row(
                      children: [
                        Icon(Icons.download_rounded, size: 16, color: c.orange),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.pkg.downloads} downloads',
                          style: AppTextStyles.mono.copyWith(
                            color: c.orange,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],

                  // Tags row
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: widget.pkg.tags.map((t) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: c.surface,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: c.border),
                        ),
                        child: Text(
                          t,
                          style: AppTextStyles.monoSmall.copyWith(
                            color: c.textMuted,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            // Bottom scroll hint
            Positioned(
              bottom: 48,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: (1.0 - widget.revealProgress).clamp(0.0, 1.0),
                child: AnimatedBuilder(
                  animation: _bounce,
                  builder: (_, __) => Transform.translate(
                    offset: Offset(0, _bounce.value),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: c.textMuted,
                          size: 22,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'tap or scroll to explore',
                          style: AppTextStyles.mono.copyWith(
                            fontSize: 11,
                            color: c.textMuted,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Full detail content ───────────────────────────────────────────────────────

class _DetailContent extends StatelessWidget {
  const _DetailContent({required this.pkg, required this.onBack});
  final OpenSourcePackage pkg;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionH(context);
    final vPad = ResponsiveHelper.sectionV(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nav bar
          _DetailNavBar(onBack: onBack, pkg: pkg),

          // Hero
          _DetailHero(pkg: pkg, hPad: hPad, vPad: vPad),

          // Divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Container(height: 1, color: c.border),
          ),

          // Story chapters
          _StorySection(pkg: pkg, hPad: hPad, vPad: vPad),

          // Case study
          if (pkg.caseStudy != null)
            _CaseStudySection(pkg: pkg, hPad: hPad, vPad: vPad),

          // Related packages
          if (pkg.relatedPackages.isNotEmpty)
            _RelatedSection(pkg: pkg, hPad: hPad, vPad: vPad),

          // Footer CTA
          _DetailFooter(pkg: pkg, hPad: hPad),

          SizedBox(height: vPad),
        ],
      ),
    );
  }
}

// ── Detail nav bar ────────────────────────────────────────────────────────────

class _DetailNavBar extends StatelessWidget {
  const _DetailNavBar({required this.onBack, required this.pkg});
  final VoidCallback onBack;
  final OpenSourcePackage pkg;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      height: AppDimensions.navBarHeight,
      padding: EdgeInsets.symmetric(horizontal: hPad),
      decoration: BoxDecoration(
        color: c.navBg,
        border: Border(bottom: BorderSide(color: c.border)),
      ),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: onBack,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_rounded, size: 16, color: c.textMuted),
                  const SizedBox(width: 8),
                  Text(
                    'Back',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: c.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),

          // Breadcrumb
          Row(
            children: [
              Text(
                'Packages',
                style: AppTextStyles.labelLarge.copyWith(color: c.textMuted),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '/',
                  style: AppTextStyles.labelLarge.copyWith(color: c.border),
                ),
              ),
              Text(
                pkg.displayName,
                style: AppTextStyles.labelLarge.copyWith(
                  color: c.accent,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Hero section ──────────────────────────────────────────────────────────────

class _DetailHero extends StatelessWidget {
  const _DetailHero({
    required this.pkg,
    required this.hPad,
    required this.vPad,
  });
  final OpenSourcePackage pkg;
  final double hPad;
  final double vPad;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final isWide = ResponsiveHelper.isWide(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, vPad, hPad, vPad * 0.8),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package / status label
            _StatusLabel(pkg: pkg, c: c),

            const SizedBox(height: 24),

            // Display name
            Text(
              pkg.displayName,
              style:
                  (isMobile
                          ? AppTextStyles.headlineLarge
                          : isWide
                          ? AppTextStyles.displayLarge
                          : AppTextStyles.displayMedium)
                      .copyWith(color: c.textPrimary, height: 1.05),
            ),

            if (pkg.tagline != null) ...[
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  pkg.tagline!,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.55,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],

            const SizedBox(height: 32),

            // Metadata row
            Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (pkg.version != null)
                  _MetaBadge(
                    icon: Icons.tag_rounded,
                    label: 'v${pkg.version}',
                    c: c,
                  ),
                if (pkg.downloads != null)
                  _MetaBadge(
                    icon: Icons.download_rounded,
                    label: '${pkg.downloads} downloads',
                    c: c,
                    highlighted: true,
                  ),
                if (pkg.publishedOn != null)
                  _MetaBadge(
                    icon: Icons.calendar_today_rounded,
                    label: _formatDate(pkg.publishedOn!),
                    c: c,
                  ),
              ],
            ),

            const SizedBox(height: 28),

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: pkg.tags.map((t) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: c.accentBg,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: c.accent.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    t,
                    style: AppTextStyles.monoSmall.copyWith(
                      color: c.accentSubtle,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 36),

            // CTA buttons
            _HeroCtas(pkg: pkg, c: c),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) =>
      '${d.year} ${_months[d.month - 1]} ${d.day}';
  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}

class _MetaBadge extends StatelessWidget {
  const _MetaBadge({
    required this.icon,
    required this.label,
    required this.c,
    this.highlighted = false,
  });
  final IconData icon;
  final String label;
  final PortfolioColors c;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: highlighted ? c.orange.withValues(alpha: 0.1) : c.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: highlighted ? c.orange.withValues(alpha: 0.35) : c.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: highlighted ? c.orange : c.textMuted),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.mono.copyWith(
              fontSize: 13,
              color: highlighted ? c.orange : c.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Story sections ────────────────────────────────────────────────────────────

class _StorySection extends StatelessWidget {
  const _StorySection({
    required this.pkg,
    required this.hPad,
    required this.vPad,
  });
  final OpenSourcePackage pkg;
  final double hPad;
  final double vPad;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, vPad * 0.9, hPad, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: isMobile
            ? _MobileStory(pkg: pkg, c: c)
            : _DesktopStory(pkg: pkg, c: c),
      ),
    );
  }
}

class _DesktopStory extends StatelessWidget {
  const _DesktopStory({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _WhyBuilt(pkg: pkg, c: c),
        ),
        const SizedBox(width: 64),
        Expanded(
          flex: 2,
          child: _ProblemCard(pkg: pkg, c: c),
        ),
      ],
    );
  }
}

class _MobileStory extends StatelessWidget {
  const _MobileStory({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _WhyBuilt(pkg: pkg, c: c),
        const SizedBox(height: 40),
        _ProblemCard(pkg: pkg, c: c),
      ],
    );
  }
}

class _WhyBuilt extends StatelessWidget {
  const _WhyBuilt({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WHY I BUILT THIS',
          style: AppTextStyles.monoSmall.copyWith(
            color: c.accent,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 20),
        // Gradient left bar
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [c.accent, c.accent.withValues(alpha: 0.0)],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  pkg.description,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.85,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProblemCard extends StatelessWidget {
  const _ProblemCard({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    if (pkg.problem == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'THE PROBLEM',
          style: AppTextStyles.monoSmall.copyWith(
            color: c.orange,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: c.orange.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            border: Border.all(color: c.orange.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lightbulb_outline_rounded, color: c.orange, size: 22),
              const SizedBox(height: 16),
              Text(
                pkg.problem!,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: c.textPrimary,
                  height: 1.75,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Related packages ──────────────────────────────────────────────────────────

class _RelatedSection extends StatelessWidget {
  const _RelatedSection({
    required this.pkg,
    required this.hPad,
    required this.vPad,
  });
  final OpenSourcePackage pkg;
  final double hPad;
  final double vPad;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    final related = pkg.relatedPackages
        .map(
          (name) =>
              PortfolioData.packages.where((p) => p.name == name).firstOrNull,
        )
        .whereType<OpenSourcePackage>()
        .toList();

    if (related.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, vPad * 0.8, hPad, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 1, color: c.border),
            const SizedBox(height: 48),
            Text(
              'RELATED WORK',
              style: AppTextStyles.monoSmall.copyWith(
                color: c.textMuted,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'From the same package ecosystem',
              style: AppTextStyles.headlineMedium.copyWith(
                color: c.textPrimary,
              ),
            ),
            const SizedBox(height: 32),
            LayoutBuilder(
              builder: (ctx, constraints) {
                final cols = isMobile ? 1 : (related.length == 1 ? 1 : 2);
                const gap = 16.0;
                final cardWidth =
                    (constraints.maxWidth - gap * (cols - 1)) / cols;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: related.map((rel) {
                    return SizedBox(
                      width: cardWidth,
                      child: _RelatedCard(pkg: rel),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _RelatedCard extends StatefulWidget {
  const _RelatedCard({required this.pkg});
  final OpenSourcePackage pkg;

  @override
  State<_RelatedCard> createState() => _RelatedCardState();
}

class _RelatedCardState extends State<_RelatedCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => context.push('/packages/${widget.pkg.slug}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: _hovered ? c.surfaceHover : c.surface,
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            border: Border.all(
              color: _hovered ? c.accent.withValues(alpha: 0.4) : c.border,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.widgets_rounded, size: 16, color: c.orange),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.pkg.displayName,
                      style: AppTextStyles.mono.copyWith(
                        fontSize: 13,
                        color: c.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (widget.pkg.tagline != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        widget.pkg.tagline!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: c.textMuted,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),
              AnimatedOpacity(
                opacity: _hovered ? 1.0 : 0.3,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: c.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Footer CTA ────────────────────────────────────────────────────────────────

class _DetailFooter extends StatelessWidget {
  const _DetailFooter({required this.pkg, required this.hPad});
  final OpenSourcePackage pkg;
  final double hPad;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 28 : 48),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [c.accentBg, c.orange.withValues(alpha: 0.04)],
            ),
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            border: Border.all(color: c.accent.withValues(alpha: 0.2)),
          ),
          child: pkg.isComingSoon
              ? _ComingSoonFooter(pkg: pkg, c: c)
              : _UseItFooter(pkg: pkg, c: c),
        ),
      ),
    );
  }
}

// ── Status label (PACKAGE / COMING SOON) ──────────────────────────────────────

class _StatusLabel extends StatelessWidget {
  const _StatusLabel({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final soon = pkg.isComingSoon;
    final color = soon ? c.orange : c.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        soon ? 'COMING SOON' : 'PACKAGE',
        style: AppTextStyles.monoSmall.copyWith(color: color),
      ),
    );
  }
}

// ── Hero CTAs (status-aware) ──────────────────────────────────────────────────

class _HeroCtas extends StatelessWidget {
  const _HeroCtas({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final pubUrl = pkg.pubUrl;
    return Wrap(
      spacing: 12,
      runSpacing: 10,
      children: [
        if (pubUrl != null)
          _CtaButton(
            label: 'View on pub.dev',
            icon: Icons.open_in_new_rounded,
            primary: true,
            url: pubUrl,
            c: c,
          ),
        if (pkg.githubUrl != null)
          _CtaButton(
            label: 'Source code',
            icon: Icons.code_rounded,
            primary: pubUrl == null,
            url: pkg.githubUrl!,
            c: c,
          ),
        if (pubUrl == null && pkg.githubUrl == null)
          _CtaButton(
            label: 'Follow on pub.dev',
            icon: Icons.notifications_none_rounded,
            primary: true,
            url: AppStrings.pubDevUrl,
            c: c,
          ),
      ],
    );
  }
}

// ── Case study ────────────────────────────────────────────────────────────────

class _CaseStudySection extends StatelessWidget {
  const _CaseStudySection({
    required this.pkg,
    required this.hPad,
    required this.vPad,
  });
  final OpenSourcePackage pkg;
  final double hPad;
  final double vPad;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final cs = pkg.caseStudy!;

    return Padding(
      padding: EdgeInsets.fromLTRB(hPad, vPad * 0.8, hPad, 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppDimensions.maxContentWidth,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 1, color: c.border),
            const SizedBox(height: 48),
            Text(
              'CASE STUDY',
              style: AppTextStyles.monoSmall.copyWith(
                color: c.accent,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'The build log',
              style: AppTextStyles.headlineMedium.copyWith(
                color: c.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Text(
                cs.summary,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: c.textSecondary,
                  height: 1.75,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            // Highlights / key results
            if (cs.highlights.isNotEmpty) ...[
              const SizedBox(height: 28),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: cs.highlights
                    .map((h) => _HighlightChip(label: h, c: c))
                    .toList(),
              ),
            ],

            const SizedBox(height: 40),

            // Chapters
            for (var i = 0; i < cs.sections.length; i++) ...[
              _CaseStudyChapter(index: i + 1, section: cs.sections[i], c: c),
              if (i != cs.sections.length - 1) const SizedBox(height: 32),
            ],

            // Optional external write-up
            if (cs.url != null) ...[
              const SizedBox(height: 32),
              _CtaButton(
                label: 'Read the full write-up',
                icon: Icons.article_outlined,
                url: cs.url!,
                c: c,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _HighlightChip extends StatelessWidget {
  const _HighlightChip({required this.label, required this.c});
  final String label;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: c.accentBg,
        border: Border.all(color: c.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_rounded, size: 13, color: c.accent),
          const SizedBox(width: 7),
          Text(
            label,
            style: AppTextStyles.monoSmall.copyWith(
              color: c.accentSubtle,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _CaseStudyChapter extends StatelessWidget {
  const _CaseStudyChapter({
    required this.index,
    required this.section,
    required this.c,
  });
  final int index;
  final CaseStudySection section;
  final PortfolioColors c;

  /// Maps a beat kind to its label, accent colour, and icon.
  ({String label, Color color, IconData icon}) get _meta {
    switch (section.kind) {
      case CaseStudyKind.decision:
        return (
          label: 'DECISION',
          color: c.accent,
          icon: Icons.alt_route_rounded,
        );
      case CaseStudyKind.setback:
        return (
          label: 'STEPPED BACK',
          color: c.orange,
          icon: Icons.replay_rounded,
        );
      case CaseStudyKind.problem:
        return (
          label: 'PROBLEM',
          color: c.orange,
          icon: Icons.warning_amber_rounded,
        );
      case CaseStudyKind.breakthrough:
        return (
          label: 'BREAKTHROUGH',
          color: c.success,
          icon: Icons.bolt_rounded,
        );
      case CaseStudyKind.chapter:
        return (
          label: 'STEP ${index.toString().padLeft(2, '0')}',
          color: c.accentSubtle,
          icon: Icons.circle,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final m = _meta;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Colour-coded spine for the beat.
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: m.color.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kind tag
                Row(
                  children: [
                    Icon(m.icon, size: 12, color: m.color),
                    const SizedBox(width: 7),
                    Text(
                      m.label,
                      style: AppTextStyles.monoSmall.copyWith(
                        color: m.color,
                        fontSize: 10,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  section.heading,
                  style: AppTextStyles.titleLarge.copyWith(
                    color: c.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  section.body,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Footers (live vs coming soon) ─────────────────────────────────────────────

class _UseItFooter extends StatelessWidget {
  const _UseItFooter({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final pubUrl = pkg.pubUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Use it in your project',
          style: AppTextStyles.headlineMedium.copyWith(
            color: c.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Add to your pubspec.yaml and start building.',
          style: AppTextStyles.bodyLarge.copyWith(
            color: c.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: c.border),
          ),
          child: Text(
            'flutter pub add ${pkg.name}',
            style: AppTextStyles.mono.copyWith(fontSize: 13, color: c.accent),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            if (pubUrl != null)
              _CtaButton(
                label: 'View on pub.dev',
                icon: Icons.open_in_new_rounded,
                primary: true,
                url: pubUrl,
                c: c,
              ),
            if (pkg.githubUrl != null)
              _CtaButton(
                label: 'GitHub',
                icon: Icons.code_rounded,
                url: pkg.githubUrl!,
                c: c,
              ),
          ],
        ),
      ],
    );
  }
}

class _ComingSoonFooter extends StatelessWidget {
  const _ComingSoonFooter({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final enginePub = PortfolioData.packages
        .where((p) => p.name == 'ai_core_codespark')
        .firstOrNull
        ?.pubUrl;
    final showEngine = enginePub != null && pkg.name != 'ai_core_codespark';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'On the roadmap',
          style: AppTextStyles.headlineMedium.copyWith(
            color: c.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          '${pkg.displayName} is in active development and not on pub.dev yet. '
          'Follow the publisher to get it the day it ships.',
          style: AppTextStyles.bodyLarge.copyWith(
            color: c.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: [
            _CtaButton(
              label: 'Follow on pub.dev',
              icon: Icons.notifications_none_rounded,
              primary: true,
              url: AppStrings.pubDevUrl,
              c: c,
            ),
            if (showEngine)
              _CtaButton(
                label: 'Explore the engine',
                icon: Icons.bolt_rounded,
                url: enginePub,
                c: c,
              ),
          ],
        ),
      ],
    );
  }
}

// ── CTA Button ────────────────────────────────────────────────────────────────

class _CtaButton extends StatefulWidget {
  const _CtaButton({
    required this.label,
    required this.icon,
    required this.url,
    required this.c,
    this.primary = false,
  });
  final String label;
  final IconData icon;
  final String url;
  final PortfolioColors c;
  final bool primary;

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hovered ? c.accent : c.accent.withValues(alpha: 0.9))
                : (_hovered ? c.surfaceHover : c.surface),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: widget.primary
                  ? c.accent
                  : (_hovered ? c.accent : c.border),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 15,
                color: widget.primary
                    ? Colors.white
                    : (_hovered ? c.accent : c.textSecondary),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: widget.primary
                      ? Colors.white
                      : (_hovered ? c.accent : c.textSecondary),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
