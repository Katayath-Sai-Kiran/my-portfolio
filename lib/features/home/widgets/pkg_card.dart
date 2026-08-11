import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../shared/models/portfolio_models.dart';

/// Picks which real fact to lead with, cycling by [leadFactMode] so
/// same-size cards in a grid don't all read identically.
String _leadFact(OpenSourcePackage pkg, int leadFactMode) {
  switch (leadFactMode % 3) {
    case 1:
      final highlights = pkg.caseStudy?.highlights;
      if (highlights != null && highlights.isNotEmpty) return highlights.first;
      return pkg.problem ?? '';
    case 2:
      if (pkg.downloads != null) return '${pkg.downloads} downloads on pub.dev';
      return pkg.problem ?? '';
    default:
      return pkg.problem ?? '';
  }
}

class PkgCard extends StatefulWidget {
  const PkgCard({required this.pkg, this.leadFactMode = 0, super.key});
  final OpenSourcePackage pkg;

  /// Cycles which fact the card leads with — see [_leadFact].
  final int leadFactMode;

  @override
  State<PkgCard> createState() => _PkgCardState();
}

class _PkgCardState extends State<PkgCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final pkg = widget.pkg;
    final isFeatured = pkg.isFeatured;

    final slug = pkg.slug;

    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/packages/$slug'),
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _hovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity(),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(
            color: _hovered ? c.textPrimary : c.border,
          ),
          borderRadius: BorderRadius.circular(6),
          color: _hovered ? c.surfaceHover : Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pkg.displayName,
                        style: AppTypography.labelLarge.copyWith(
                          color: c.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pkg.name,
                        style: AppTypography.monoSmall.copyWith(
                          color: c.textMuted,
                          fontSize: 8,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                if (isFeatured)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: c.textMuted.withValues(alpha: 0.3)),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      'FEATURED',
                      style: AppTypography.monoSmall.copyWith(
                        color: c.textMuted,
                        fontSize: 7,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              pkg.description,
              style: AppTypography.bodySmall.copyWith(
                color: c.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '← ${_leadFact(pkg, widget.leadFactMode)}',
              style: AppTypography.bodySmall.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? c.textSecondary
                    : c.textMuted,
                fontStyle: FontStyle.italic,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: pkg.tags.map((t) => _TagChip(label: t, c: c)).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _CardButton(
                  label: 'View Package',
                  icon: Icons.arrow_outward_rounded,
                  onTap: () => launchUrl(Uri.parse(pkg.pubUrl!)),
                  c: c,
                ),
                const SizedBox(width: 8),
                _IconButton(
                  icon: Icons.code_rounded,
                  onTap: () => launchUrl(Uri.parse(pkg.githubUrl!)),
                  c: c,
                ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _CardButton extends StatefulWidget {
  const _CardButton({
    required this.label,
    required this.icon,
    required this.onTap,
    required this.c,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final PortfolioColors c;

  @override
  State<_CardButton> createState() => _CardButtonState();
}

class _CardButtonState extends State<_CardButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: _hovered ? c.textPrimary : c.border),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTypography.monoSmall.copyWith(
                  color: _hovered ? c.textPrimary : c.textSecondary,
                  fontSize: 9,
                ),
              ),
              const SizedBox(width: 4),
              AnimatedSlide(
                duration: const Duration(milliseconds: 200),
                offset: _hovered ? const Offset(0.2, 0) : Offset.zero,
                child: Icon(widget.icon, size: 10, color: _hovered ? c.textPrimary : c.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({required this.icon, required this.onTap, required this.c});
  final IconData icon;
  final VoidCallback onTap;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 12, color: c.textMuted),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, required this.c});
  final String label;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: c.borderSubtle),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: AppTypography.monoSmall.copyWith(color: c.textMuted, fontSize: 8),
      ),
    );
  }
}

/// Full-width editorial treatment for featured packages — bigger type, the
/// problem framed as a pull-quote, room for the description to breathe.
class PkgSpotlightCard extends StatefulWidget {
  const PkgSpotlightCard({required this.pkg, super.key});
  final OpenSourcePackage pkg;

  @override
  State<PkgSpotlightCard> createState() => _PkgSpotlightCardState();
}

class _PkgSpotlightCardState extends State<PkgSpotlightCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final pkg = widget.pkg;
    final isMobile = MediaQuery.sizeOf(context).width < 768;

    return GestureDetector(
      onTap: () => GoRouter.of(context).go('/packages/${pkg.slug}'),
      behavior: HitTestBehavior.opaque,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border.all(color: _hovered ? c.textPrimary : c.border),
            color: _hovered ? c.surfaceHover : Colors.transparent,
          ),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        border: Border.all(color: c.textMuted.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        'FEATURED',
                        style: AppTypography.monoSmall.copyWith(
                          color: c.textMuted,
                          fontSize: 8,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      pkg.displayName,
                      style: AppTypography.headlineMedium.copyWith(
                        color: c.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pkg.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textSecondary,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: pkg.tags.map((t) => _TagChip(label: t, c: c)).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(width: isMobile ? 0 : 24, height: isMobile ? 20 : 0),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pkg.problem != null)
                      Text(
                        '"${pkg.problem}"',
                        style: AppTypography.bodyLarge.copyWith(
                          color: c.textPrimary,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _CardButton(
                          label: 'View Package',
                          icon: Icons.arrow_outward_rounded,
                          onTap: () => launchUrl(Uri.parse(pkg.pubUrl!)),
                          c: c,
                        ),
                        const SizedBox(width: 8),
                        _IconButton(
                          icon: Icons.code_rounded,
                          onTap: () => launchUrl(Uri.parse(pkg.githubUrl!)),
                          c: c,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
