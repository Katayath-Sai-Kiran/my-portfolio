import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/services/pub_dev_service.dart';
import '../../shared/widgets/brutal.dart';

class OpenSourceSection extends StatelessWidget {
  const OpenSourceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final vPad = ResponsiveHelper.sectionVerticalPadding(context);

    return Container(
      width: double.infinity,
      color: c.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BrutalSectionHeader(
                index: '01',
                title: 'Open Source',
                narrative:
                    'Every package started the same way: shipping something real, '
                    'hitting a wall, finding nothing on pub.dev — or something half-broken. '
                    'So I built it, then released it so the next engineer wouldn\'t have to.',
              ),
              const SizedBox(height: 48),

              // One titled set per category (AI first, then utilities).
              for (final category in PackageCategory.values)
                if (PortfolioData.packages.any((p) => p.category == category)) ...[
                  _PackageGroup(
                    category: category,
                    packages: PortfolioData.packages
                        .where((p) => p.category == category)
                        .toList(),
                  ),
                  const SizedBox(height: 56),
                ],

              _SectionFooter(c: c),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Column headers (desktop) ──────────────────────────────────────────────────

class _ColumnHeaders extends StatelessWidget {
  const _ColumnHeaders({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    TextStyle s() =>
        AppTextStyles.monoSmall.copyWith(color: c.textMuted, fontSize: 10);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 44, child: Text('NO.', style: s())),
          const SizedBox(width: 20),
          Expanded(child: Text('PACKAGE', style: s())),
          SizedBox(
            width: 110,
            child: Text('INSTALLS', textAlign: TextAlign.right, style: s()),
          ),
        ],
      ),
    );
  }
}

// ── Package group (titled set) ────────────────────────────────────────────────

class _PackageGroup extends StatelessWidget {
  const _PackageGroup({required this.category, required this.packages});
  final PackageCategory category;
  final List<OpenSourcePackage> packages;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isAi = category == PackageCategory.ai;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group title + blurb
        Row(
          children: [
            Text(
              category.title,
              style: AppTextStyles.headlineMedium.copyWith(
                color: c.textPrimary,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(width: 12),
            if (isAi)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: c.accent.withValues(alpha: 0.12),
                  border: Border.all(color: c.accent, width: 1.5),
                ),
                child: Text(
                  'NEW',
                  style: AppTextStyles.monoSmall.copyWith(
                    color: c.accent,
                    fontSize: 9,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            category.blurb,
            style: AppTextStyles.bodyMedium.copyWith(color: c.textSecondary),
          ),
        ),
        const SizedBox(height: 20),

        if (ResponsiveHelper.isWide(context)) _ColumnHeaders(c: c),

        // The list — each row is bordered top; the box closes the bottom.
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: c.border, width: 2),
              bottom: BorderSide(color: c.border, width: 2),
            ),
          ),
          child: Column(
            children: packages
                .asMap()
                .entries
                .map((e) => _PackageRow(pkg: e.value, index: e.key))
                .toList(),
          ),
        ),
      ],
    );
  }
}

// ── "Coming soon" badge ───────────────────────────────────────────────────────

class _SoonBadge extends StatelessWidget {
  const _SoonBadge({required this.c, this.inverted = false});
  final PortfolioColors c;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final fg = inverted ? c.background : c.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(border: Border.all(color: fg, width: 1.5)),
      child: Text(
        'SOON',
        style: AppTextStyles.monoSmall.copyWith(color: fg, fontSize: 9),
      ),
    );
  }
}

// ── Package row ───────────────────────────────────────────────────────────────

class _PackageRow extends StatefulWidget {
  const _PackageRow({required this.pkg, required this.index});
  final OpenSourcePackage pkg;
  final int index;

  @override
  State<_PackageRow> createState() => _PackageRowState();
}

class _PackageRowState extends State<_PackageRow> {
  bool _hovered = false;
  bool _countVisible = false;
  int? _liveDownloads;

  @override
  void initState() {
    super.initState();
    // Coming-soon packages aren't on pub.dev — nothing to fetch.
    if (widget.pkg.isLive) _fetchDownloads();
  }

  Future<void> _fetchDownloads() async {
    try {
      final data = await PubDevService.instance.fetchAll(widget.pkg.name);
      if (!mounted) return;
      final d = data.totalDownloads;
      if (d != null) setState(() => _liveDownloads = d);
    } catch (e) {
      if (kDebugMode) debugPrint('PackageRow fetch error: $e');
    }
  }

  int get _downloads => _liveDownloads ?? widget.pkg.downloads ?? 0;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final ordinal = (widget.index + 1).toString().padLeft(2, '0');

    return VisibilityDetector(
      key: Key('row_${widget.pkg.name}'),
      onVisibilityChanged: (info) {
        if (!_countVisible && info.visibleFraction > 0.2 && mounted) {
          setState(() => _countVisible = true);
        }
      },
      child: GestureDetector(
        onTap: () => context.push('/packages/${widget.pkg.slug}'),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hovered = true),
          onExit: (_) => setState(() => _hovered = false),
          child: Container(
            // Inks the whole row on hover — text/icons flip to background color.
            color: widget.index == 0
                ? _hovered
                      ? c.textPrimary
                      : Colors.transparent
                : null,
            // Rows after the first carry a top divider.
            decoration: widget.index == 0
                ? null
                : BoxDecoration(
                    color: _hovered ? c.textPrimary : Colors.transparent,
                    border: Border(
                      top: BorderSide(color: c.border, width: 1.5),
                    ),
                  ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: isMobile
                ? _MobileRowContent(
                    pkg: widget.pkg,
                    ordinal: ordinal,
                    downloads: _downloads,
                    countVisible: _countVisible,
                    hovered: _hovered,
                    c: c,
                  )
                : _DesktopRowContent(
                    pkg: widget.pkg,
                    ordinal: ordinal,
                    downloads: _downloads,
                    countVisible: _countVisible,
                    hovered: _hovered,
                    c: c,
                  ),
          ),
        ),
      ),
    );
  }
}

// ── Desktop row content ───────────────────────────────────────────────────────

class _DesktopRowContent extends StatelessWidget {
  const _DesktopRowContent({
    required this.pkg,
    required this.ordinal,
    required this.downloads,
    required this.countVisible,
    required this.hovered,
    required this.c,
  });

  final OpenSourcePackage pkg;
  final String ordinal;
  final int downloads;
  final bool countVisible;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    final inv = hovered ? c.background : null; // inverted foreground on hover
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 44,
          child: Text(
            ordinal,
            style: AppTextStyles.mono.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: hovered ? c.accent : c.accentSubtle,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: _RowMeta(pkg: pkg, hovered: hovered, c: c),
        ),
        const SizedBox(width: 24),
        _InlineLinks(pkg: pkg, c: c, inverted: hovered),
        const SizedBox(width: 28),
        SizedBox(
          width: 110,
          child: pkg.isComingSoon
              ? Align(
                  alignment: Alignment.centerRight,
                  child: _SoonBadge(c: c, inverted: hovered),
                )
              : _DownloadCount(
                  downloads: downloads,
                  visible: countVisible,
                  c: c,
                  color: inv,
                ),
        ),
        const SizedBox(width: 12),
        Icon(
          Icons.arrow_outward_rounded,
          size: 18,
          color: hovered ? c.background : c.textMuted,
        ),
      ],
    );
  }
}

// ── Mobile row content ────────────────────────────────────────────────────────

class _MobileRowContent extends StatelessWidget {
  const _MobileRowContent({
    required this.pkg,
    required this.ordinal,
    required this.downloads,
    required this.countVisible,
    required this.hovered,
    required this.c,
  });

  final OpenSourcePackage pkg;
  final String ordinal;
  final int downloads;
  final bool countVisible;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ordinal,
              style: AppTextStyles.mono.copyWith(
                fontSize: 12,
                color: hovered ? c.accent : c.accentSubtle,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                pkg.displayName,
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: hovered ? c.background : c.textPrimary,
                ),
              ),
            ),
            if (pkg.isComingSoon)
              _SoonBadge(c: c, inverted: hovered)
            else
              _DownloadCount(
                downloads: downloads,
                visible: countVisible,
                c: c,
                compact: true,
                color: hovered ? c.background : null,
              ),
          ],
        ),
        if (pkg.tagline != null) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Text(
              pkg.tagline!,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 13,
                color: hovered ? c.background : c.textSecondary,
              ),
            ),
          ),
        ],
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: _InlineLinks(pkg: pkg, c: c, inverted: hovered),
        ),
      ],
    );
  }
}

// ── Row meta: name + tagline + tags ──────────────────────────────────────────

class _RowMeta extends StatelessWidget {
  const _RowMeta({required this.pkg, required this.hovered, required this.c});
  final OpenSourcePackage pkg;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          pkg.displayName,
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.w800,
            color: hovered ? c.background : c.textPrimary,
          ),
        ),
        if (pkg.tagline != null) ...[
          const SizedBox(height: 5),
          Text(
            pkg.tagline!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: hovered
                  ? c.background.withValues(alpha: 0.75)
                  : c.textSecondary,
            ),
          ),
        ],
        if (pkg.tags.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: pkg.tags
                .take(4)
                .map(
                  (t) => BrutalTag(
                    label: t,
                    color: hovered ? c.background : c.textMuted,
                  ),
                )
                .toList(),
          ),
        ],
      ],
    );
  }
}

// ── Inline links (pub.dev + source) ──────────────────────────────────────────

class _InlineLinks extends StatelessWidget {
  const _InlineLinks({
    required this.pkg,
    required this.c,
    this.inverted = false,
  });
  final OpenSourcePackage pkg;
  final PortfolioColors c;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final pubUrl = pkg.pubUrl;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (pubUrl != null)
          _LinkChip(
            label: 'pub',
            c: c,
            inverted: inverted,
            onTap: () => launchUrl(Uri.parse(pubUrl)),
          ),
        if (pkg.githubUrl != null) ...[
          if (pubUrl != null) const SizedBox(width: 8),
          _LinkChip(
            label: 'src',
            c: c,
            inverted: inverted,
            onTap: () => launchUrl(Uri.parse(pkg.githubUrl!)),
          ),
        ],
        // Coming-soon packages have neither link yet — show a hint.
        if (pubUrl == null && pkg.githubUrl == null)
          Text(
            'details',
            style: AppTextStyles.monoSmall.copyWith(
              color: inverted ? c.background : c.textMuted,
              fontSize: 9,
            ),
          ),
      ],
    );
  }
}

class _LinkChip extends StatelessWidget {
  const _LinkChip({
    required this.label,
    required this.c,
    required this.onTap,
    this.inverted = false,
  });
  final String label;
  final PortfolioColors c;
  final VoidCallback onTap;
  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final fg = inverted ? c.background : c.textPrimary;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(border: Border.all(color: fg, width: 1.5)),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.monoSmall.copyWith(color: fg, fontSize: 9),
          ),
        ),
      ),
    );
  }
}

// ── Download count ────────────────────────────────────────────────────────────

class _DownloadCount extends StatelessWidget {
  const _DownloadCount({
    required this.downloads,
    required this.visible,
    required this.c,
    this.compact = false,
    this.color,
  });
  final int downloads;
  final bool visible;
  final PortfolioColors c;
  final bool compact;
  final Color? color;

  String _fmt(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(1)}k';
    return v.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (downloads <= 0) return const SizedBox.shrink();
    final fg = color ?? c.textPrimary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: visible ? downloads.toDouble() : 0),
          duration: const Duration(milliseconds: 1100),
          curve: Curves.easeOut,
          builder: (_, val, __) => Text(
            _fmt(val.round()),
            style: AppTextStyles.mono.copyWith(
              fontSize: compact ? 16 : 26,
              height: 1,
              fontWeight: FontWeight.w700,
              color: fg,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Section footer ────────────────────────────────────────────────────────────

class _SectionFooter extends StatelessWidget {
  const _SectionFooter({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 16,
      runSpacing: 12,
      children: [
        Builder(
          builder: (_) {
            final live = PortfolioData.packages.where((p) => p.isLive).length;
            final soon =
                PortfolioData.packages.where((p) => p.isComingSoon).length;
            final soonPart = soon > 0 ? ' · $soon COMING SOON' : '';
            return Text(
              '$live LIVE$soonPart · ${PortfolioData.totalDownloads}+ INSTALLS',
              style: AppTextStyles.monoSmall.copyWith(
                color: c.textSecondary,
                fontSize: 11,
              ),
            );
          },
        ),
        _PubDevLink(),
      ],
    );
  }
}

class _PubDevLink extends StatefulWidget {
  @override
  State<_PubDevLink> createState() => _PubDevLinkState();
}

class _PubDevLinkState extends State<_PubDevLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(AppStrings.pubDevUrl)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: _hovered ? c.accent : Colors.transparent,
            border: Border.all(color: c.accent, width: 2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ALL ON PUB.DEV',
                style: AppTextStyles.monoSmall.copyWith(
                  fontSize: 11,
                  color: _hovered ? Colors.white : c.accent,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_outward_rounded,
                size: 13,
                color: _hovered ? Colors.white : c.accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
