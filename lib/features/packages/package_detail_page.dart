import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';
import '../../core/router/app_router.dart';
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
  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      _fadeCtrl.forward().then((_) {
        if (mounted) {
          setState(() => _revealed = true);
        }
      });
    });
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Scaffold(
      backgroundColor: c.background,
      body: _revealed
          ? _StoryContent(pkg: widget.pkg, onBack: () => context.pop())
          : FadeTransition(
              opacity: _fadeAnim,
              child: _IntroOverlay(pkg: widget.pkg, c: c),
            ),
    );
  }
}

// ── Intro: big name + tagline fade-in ────────────────────────────────────────

class _IntroOverlay extends StatelessWidget {
  const _IntroOverlay({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: c.background,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                pkg.displayName,
                style: AppTypography.displayHero.copyWith(color: c.textPrimary),
              ),
              if (pkg.tagline != null) ...[
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Text(
                    pkg.tagline!,
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Full scrollable story ────────────────────────────────────────────────────

class _StoryContent extends StatelessWidget {
  const _StoryContent({required this.pkg, required this.onBack});
  final OpenSourcePackage pkg;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 80.0;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Nav ──
          Container(
            height: 56,
            padding: EdgeInsets.symmetric(horizontal: hPad),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: c.borderSubtle)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onBack,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                          size: 16,
                          color: c.textMuted,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Back',
                          style: AppTypography.labelLarge.copyWith(
                            color: c.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                if (pkg.pubUrl != null)
                  _TextLink(label: 'pub.dev', url: pkg.pubUrl!, c: c),
                if (pkg.githubUrl != null) ...[
                  const SizedBox(width: 16),
                  _TextLink(label: 'GitHub', url: pkg.githubUrl!, c: c),
                ],
              ],
            ),
          ),

          // ── Title block ──
          Padding(
            padding: EdgeInsets.fromLTRB(hPad, 80, hPad, 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pkg.displayName,
                    style:
                        (isMobile
                                ? AppTypography.displayMedium
                                : AppTypography.displayLarge)
                            .copyWith(color: c.textPrimary, height: 1.0),
                  ),
                  if (pkg.tagline != null) ...[
                    const SizedBox(height: 20),
                    Text(
                      pkg.tagline!,
                      style: AppTypography.titleLarge.copyWith(
                        color: c.textSecondary,
                        height: 1.55,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (pkg.downloads != null) ...[
                        Text(
                          '${pkg.downloads} downloads',
                          style: AppTypography.monoSmall.copyWith(
                            color: c.textMuted,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                      if (pkg.version != null && pkg.version!.isNotEmpty)
                        Text(
                          'v${pkg.version}',
                          style: AppTypography.monoSmall.copyWith(
                            color: c.textMuted,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Problem lede ──
          if (pkg.problem != null) ...[
            const SizedBox(height: 48),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(border: Border.all(color: c.border)),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Text(
                    pkg.problem!,
                    style: AppTypography.bodyLarge.copyWith(
                      color: c.textSecondary,
                      height: 1.75,
                    ),
                  ),
                ),
              ),
            ),
          ],

          // ── The story ──
          if (pkg.caseStudy != null) ...[
            const SizedBox(height: 64),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Text(
                  pkg.caseStudy!.summary,
                  style: AppTypography.bodyLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.75,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            // Banner image
            _Placeholder(
              pkg: pkg,
              c: c,
              label: 'Medium Banner Graphic',
              assetPath: 'assets/images/banners/${pkg.name}-opt1-dark.png',
            ),
            const SizedBox(height: 64),
            // Chapters
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: _Chapters(pkg: pkg, c: c),
              ),
            ),
          ],

          // ── Highlights ──
          if (pkg.caseStudy != null &&
              pkg.caseStudy!.highlights.isNotEmpty) ...[
            const SizedBox(height: 64),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: pkg.caseStudy!.highlights
                    .map((h) => _Chip(label: h, c: c))
                    .toList(),
              ),
            ),
          ],

          // ── pub.dev screenshot ──
          const SizedBox(height: 48),
          _Placeholder(pkg: pkg, c: c, label: 'pub.dev Screenshot'),

          // ── Write-up link ──
          if (pkg.caseStudy?.url != null) ...[
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: _TextLink(
                label: 'Read the full write-up →',
                url: pkg.caseStudy!.url!,
                c: c,
              ),
            ),
          ],

          // ── Related packages ──
          if (pkg.relatedPackages.isNotEmpty) ...[
            const SizedBox(height: 80),
            Container(height: 1, color: c.border),
            const SizedBox(height: 48),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: hPad),
              child: Text(
                'Related packages',
                style: AppTypography.headlineMedium.copyWith(
                  color: c.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ...pkg.relatedPackages.map((name) {
              final rel = PortfolioData.packages
                  .where((p) => p.name == name)
                  .firstOrNull;
              if (rel == null) return const SizedBox.shrink();
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: hPad),
                child: _RelatedCard(pkg: rel),
              );
            }),
          ],

          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ── Text link ─────────────────────────────────────────────────────────────────

class _TextLink extends StatefulWidget {
  const _TextLink({required this.label, required this.url, required this.c});
  final String label;
  final String url;
  final PortfolioColors c;

  @override
  State<_TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<_TextLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Text(
          widget.label,
          style: AppTypography.labelLarge.copyWith(
            color: c.textMuted,
            decoration: _hover ? TextDecoration.underline : null,
          ),
        ),
      ),
    );
  }
}

// ── Image placeholder ────────────────────────────────────────────────────────

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.pkg,
    required this.c,
    required this.label,
    this.assetPath,
  });
  final OpenSourcePackage pkg;
  final PortfolioColors c;
  final String label;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 80.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hPad),
      child: Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(border: Border.all(color: c.border)),
        clipBehavior: Clip.hardEdge,
        child: assetPath == null
            ? _placeholderIcon()
            : Image.asset(
                assetPath!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => _placeholderIcon(),
              ),
      ),
    );
  }

  Widget _placeholderIcon() => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_outlined,
              size: 28,
              color: c.textMuted.withAlpha(80),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: AppTypography.labelLarge.copyWith(color: c.textMuted),
            ),
          ],
        ),
      );
}

// ── Chapters ─────────────────────────────────────────────────────────────────

class _Chapters extends StatelessWidget {
  const _Chapters({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < pkg.caseStudy!.sections.length; i++) ...[
          _Chapter(
            index: i + 1,
            section: pkg.caseStudy!.sections[i],
            isLast: i == pkg.caseStudy!.sections.length - 1,
            c: c,
          ),
        ],
      ],
    );
  }
}

class _Chapter extends StatelessWidget {
  const _Chapter({
    required this.index,
    required this.section,
    required this.isLast,
    required this.c,
  });
  final int index;
  final CaseStudySection section;
  final bool isLast;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Numbered spine
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    border: Border.all(color: c.border),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: AppTypography.monoSmall.copyWith(
                        color: c.textMuted,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(child: Container(width: 1, color: c.borderSubtle)),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  section.heading,
                  style: AppTypography.titleLarge.copyWith(
                    color: c.textPrimary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  section.body,
                  style: AppTypography.bodyLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.8,
                  ),
                ),
                if (!isLast) const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Related card ──────────────────────────────────────────────────────────────

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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => context.goNamed(
              AppRouter.packageDetail,
              pathParameters: {'slug': widget.pkg.slug},
            ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: _hovered ? c.textPrimary : c.borderSubtle,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.pkg.displayName,
                        style: AppTypography.titleMedium.copyWith(
                          color: c.textPrimary,
                        ),
                      ),
                      if (widget.pkg.tagline != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.pkg.tagline!,
                          style: AppTypography.bodyMedium.copyWith(
                            color: c.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: _hovered ? c.textPrimary : c.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Chip ─────────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.c});
  final String label;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(border: Border.all(color: c.border)),
      child: Text(
        label,
        style: AppTypography.monoSmall.copyWith(color: c.textMuted),
      ),
    );
  }
}
