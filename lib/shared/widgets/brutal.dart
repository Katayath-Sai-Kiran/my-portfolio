import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

/// Brutalist primitives: hard borders, zero radius, hard-offset shadows,
/// invert-on-hover interactions. No gradients, no glow, no soft shadows.

const double kBrutalBorder = 2.0;

/// A hard-offset drop shadow (the brutalist signature). [color] defaults to ink.
BoxShadow brutalShadow(Color color, {double dx = 6, double dy = 6}) => BoxShadow(
  color: color,
  offset: Offset(dx, dy),
  blurRadius: 0,
  spreadRadius: 0,
);

/// A bordered box. Optionally casts a hard offset shadow.
class BrutalBox extends StatelessWidget {
  const BrutalBox({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.shadow = false,
    this.shadowColor,
    this.padding,
    this.borderWidth = kBrutalBorder,
  });

  final Widget child;
  final Color? color;
  final Color? borderColor;
  final bool shadow;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final border = borderColor ?? c.border;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? c.surface,
        border: Border.all(color: border, width: borderWidth),
        boxShadow: shadow ? [brutalShadow(shadowColor ?? border)] : null,
      ),
      child: child,
    );
  }
}

/// A solid bordered button that inverts on hover and "presses into" its shadow.
class BrutalButton extends StatefulWidget {
  const BrutalButton({
    super.key,
    required this.label,
    required this.onTap,
    this.filled = false,
    this.fillColor,
    this.icon,
    this.dense = false,
  });

  final String label;
  final VoidCallback onTap;

  /// When true the button is filled with [fillColor] (defaults to accent).
  final bool filled;
  final Color? fillColor;
  final IconData? icon;
  final bool dense;

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

class _BrutalButtonState extends State<BrutalButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final ink = c.borderStrong;
    final fill = widget.fillColor ?? c.accent;

    // Color logic: filled inverts to ink-on-paper; outline inverts to fill.
    final Color bg;
    final Color fg;
    if (widget.filled) {
      bg = _hover ? c.surface : fill;
      fg = _hover ? c.textPrimary : Colors.white;
    } else {
      bg = _hover ? fill : c.surface;
      fg = _hover ? Colors.white : c.textPrimary;
    }

    final hPad = widget.dense ? 14.0 : 22.0;
    final vPad = widget.dense ? 9.0 : 14.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          // On hover the box slides into its shadow → tactile "press".
          transform: Matrix4.translationValues(_hover ? 3 : 0, _hover ? 3 : 0, 0),
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
          decoration: BoxDecoration(
            color: bg,
            border: Border.all(color: ink, width: kBrutalBorder),
            boxShadow: _hover ? null : [brutalShadow(ink, dx: 3, dy: 3)],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 15, color: fg),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label.toUpperCase(),
                style: AppTextStyles.labelLarge.copyWith(color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A square mono tag/chip.
class BrutalTag extends StatelessWidget {
  const BrutalTag({super.key, required this.label, this.color});
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        border: Border.all(color: color ?? c.border, width: 1.5),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.monoSmall.copyWith(
          color: color ?? c.textSecondary,
          fontSize: 9,
        ),
      ),
    );
  }
}

/// A section header: huge index number + label, with a full-width rule.
class BrutalSectionHeader extends StatelessWidget {
  const BrutalSectionHeader({
    super.key,
    required this.index,
    required this.title,
    this.narrative,
  });

  final String index;
  final String title;
  final String? narrative;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top rule with index marker
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '($index)',
              style: AppTextStyles.monoSmall.copyWith(color: c.accent, fontSize: 13),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Container(height: 2, color: c.border),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          title.toUpperCase(),
          style: AppTextStyles.displayMedium.copyWith(color: c.textPrimary),
        ),
        if (narrative != null) ...[
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              narrative!,
              style: AppTextStyles.bodyLarge.copyWith(color: c.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}
