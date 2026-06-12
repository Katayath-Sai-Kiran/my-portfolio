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
import '../../shared/widgets/chapter_header.dart';

class OpenSourceSection extends StatelessWidget {
  const OpenSourceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final vPad = ResponsiveHelper.sectionVerticalPadding(context);

    return Container(
      width: double.infinity,
      // Slightly different from background — subtle surface tint
      color: c.background,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChapterHeader(
                number: '01',
                title: 'Open Source',
                narrative:
                    'Every package I\'ve published started the same way. I was shipping '
                    'something real, hit a wall, searched pub.dev, and found either nothing '
                    'or something half-broken. So I built it myself — then released it so '
                    'the next engineer wouldn\'t have to.',
              ),

              const SizedBox(height: 16),

              // pub.dev link
              _PubDevLink(),

              const SizedBox(height: 56),

              // Column headers — desktop only
              if (ResponsiveHelper.isWide(context)) _ColumnHeaders(c: c),
              if (ResponsiveHelper.isWide(context)) const SizedBox(height: 8),

              // Top rule
              Container(height: 1, color: c.border),

              // Package rows
              ...PortfolioData.packages.asMap().entries.map(
                (e) => _PackageRow(pkg: e.value, index: e.key),
              ),

              const SizedBox(height: 40),

              // Footer: total count + link
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 36,
            child: Text(
              '#',
              style: AppTextStyles.mono.copyWith(fontSize: 9, color: c.textMuted, letterSpacing: 1.5),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              'PACKAGE',
              style: AppTextStyles.mono.copyWith(fontSize: 9, color: c.textMuted, letterSpacing: 1.5),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              'DOWNLOADS',
              textAlign: TextAlign.right,
              style: AppTextStyles.mono.copyWith(fontSize: 9, color: c.textMuted, letterSpacing: 1.5),
            ),
          ),
        ],
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
    _fetchDownloads();
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            color: _hovered ? c.accentBg : Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
                Container(height: 1, color: c.border),
              ],
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ordinal
        SizedBox(
          width: 36,
          child: Text(
            ordinal,
            style: AppTextStyles.mono.copyWith(
              fontSize: 11,
              color: hovered ? c.orange : c.textMuted,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Name + tagline + tags (grows)
        Expanded(
          child: _RowMeta(pkg: pkg, hovered: hovered, c: c),
        ),
        const SizedBox(width: 24),

        // Links
        _InlineLinks(pkg: pkg, c: c),
        const SizedBox(width: 28),

        // Download count — large, faded
        SizedBox(
          width: 100,
          child: _DownloadCount(
            downloads: downloads,
            visible: countVisible,
            c: c,
          ),
        ),

        // Arrow — appears on hover
        const SizedBox(width: 12),
        AnimatedOpacity(
          opacity: hovered ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 150),
          child: Icon(Icons.arrow_forward_rounded, size: 16, color: c.accent),
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
            // Ordinal
            Text(
              ordinal,
              style: AppTextStyles.mono.copyWith(
                fontSize: 10,
                color: hovered ? c.orange : c.textMuted,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 12),
            // Name
            Expanded(
              child: Text(
                pkg.displayName,
                style: AppTextStyles.labelLarge.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: hovered ? c.accent : c.textPrimary,
                ),
              ),
            ),
            // Download count
            _DownloadCount(downloads: downloads, visible: countVisible, c: c, compact: true),
          ],
        ),
        if (pkg.tagline != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              pkg.tagline!,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 12,
                color: c.textSecondary,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 22),
          child: _InlineLinks(pkg: pkg, c: c),
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
          style: AppTextStyles.labelLarge.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: hovered ? c.accent : c.textPrimary,
          ),
        ),
        if (pkg.tagline != null) ...[
          const SizedBox(height: 4),
          Text(
            pkg.tagline!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.bodyMedium.copyWith(
              fontSize: 13,
              color: c.textSecondary,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
        if (pkg.tags.isNotEmpty) ...[
          const SizedBox(height: 8),
          Wrap(
            spacing: 5,
            runSpacing: 4,
            children: pkg.tags.take(4).map((t) => _Tag(label: t, c: c)).toList(),
          ),
        ],
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.c});
  final String label;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: c.accentBg,
        borderRadius: BorderRadius.circular(3),
        border: Border.all(color: c.accent.withValues(alpha: 0.15)),
      ),
      child: Text(
        label,
        style: AppTextStyles.mono.copyWith(fontSize: 9, color: c.accentSubtle),
      ),
    );
  }
}

// ── Inline links (pub.dev + source) ──────────────────────────────────────────

class _InlineLinks extends StatelessWidget {
  const _InlineLinks({required this.pkg, required this.c});
  final OpenSourcePackage pkg;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _LinkChip(
          label: 'pub.dev',
          c: c,
          onTap: () => launchUrl(Uri.parse(pkg.pubUrl)),
          primary: true,
        ),
        if (pkg.githubUrl != null) ...[
          const SizedBox(width: 6),
          _LinkChip(
            label: 'source',
            c: c,
            onTap: () => launchUrl(Uri.parse(pkg.githubUrl!)),
          ),
        ],
      ],
    );
  }
}

class _LinkChip extends StatefulWidget {
  const _LinkChip({required this.label, required this.c, required this.onTap, this.primary = false});
  final String label;
  final PortfolioColors c;
  final VoidCallback onTap;
  final bool primary;

  @override
  State<_LinkChip> createState() => _LinkChipState();
}

class _LinkChipState extends State<_LinkChip> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hov ? c.orange.withValues(alpha: 0.18) : c.orange.withValues(alpha: 0.08))
                : (_hov ? c.surfaceHover : Colors.transparent),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: widget.primary
                  ? c.orange.withValues(alpha: _hov ? 0.6 : 0.3)
                  : c.border,
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.mono.copyWith(
              fontSize: 9,
              color: widget.primary ? c.orange : c.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Download count (large faded number) ──────────────────────────────────────

class _DownloadCount extends StatelessWidget {
  const _DownloadCount({
    required this.downloads,
    required this.visible,
    required this.c,
    this.compact = false,
  });
  final int downloads;
  final bool visible;
  final PortfolioColors c;
  final bool compact;

  String _fmt(int v) {
    if (v >= 1000000) return '${(v / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(v / 1000).toStringAsFixed(2)}k';
    return v.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (downloads <= 0) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: compact ? CrossAxisAlignment.end : CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: visible ? downloads.toDouble() : 0),
          duration: const Duration(milliseconds: 1400),
          curve: Curves.easeOut,
          builder: (_, val, __) => Text(
            _fmt(val.round()),
            style: AppTextStyles.mono.copyWith(
              fontSize: compact ? 18 : 28,
              height: 1,
              fontWeight: FontWeight.w700,
              color: c.textMuted.withValues(alpha: 0.28),
            ),
          ),
        ),
        Text(
          'downloads',
          style: AppTextStyles.mono.copyWith(
            fontSize: 8,
            letterSpacing: 0.8,
            color: c.textMuted.withValues(alpha: 0.35),
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
    return Row(
      children: [
        Text(
          '${PortfolioData.packages.length} packages',
          style: AppTextStyles.mono.copyWith(
            fontSize: 11,
            color: c.textMuted,
          ),
        ),
        Container(
          width: 1,
          height: 12,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          color: c.border,
        ),
        Text(
          '${PortfolioData.totalDownloads}+ total downloads',
          style: AppTextStyles.mono.copyWith(
            fontSize: 11,
            color: c.textMuted,
          ),
        ),
        const Spacer(),
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'View all on pub.dev',
              style: AppTextStyles.mono.copyWith(
                fontSize: 11,
                color: _hovered ? c.textPrimary : c.orange,
                decoration: _hovered ? TextDecoration.underline : null,
                decorationColor: c.textPrimary,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.open_in_new_rounded,
              size: 11,
              color: _hovered ? c.textPrimary : c.orange,
            ),
          ],
        ),
      ),
    );
  }
}
