import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../data/models/package_model.dart';

class PkgCard extends StatefulWidget {
  const PkgCard({required this.pkg, super.key});
  final PackageModel pkg;

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

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        transform: _hovered ? Matrix4.translationValues(0, -2, 0) : Matrix4.identity(),
        padding: EdgeInsets.all(isFeatured ? 20 : 14),
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
                        style: (isFeatured
                                ? AppTypography.titleMedium
                                : AppTypography.labelLarge)
                            .copyWith(
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
            const SizedBox(height: 10),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: pkg.tags.map(
                (t) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: c.borderSubtle),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    t,
                    style: AppTypography.monoSmall.copyWith(
                      color: c.textMuted,
                      fontSize: 8,
                    ),
                  ),
                ),
              ).toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _CardButton(
                  label: 'View Package',
                  icon: Icons.arrow_outward_rounded,
                  onTap: () => launchUrl(Uri.parse(pkg.pubUrl)),
                  c: c,
                ),
                const SizedBox(width: 8),
                _IconButton(
                  icon: Icons.code_rounded,
                  onTap: () => launchUrl(Uri.parse(pkg.githubUrl)),
                  c: c,
                ),
              ],
            ),
          ],
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
