import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'fade_slide_in.dart';

/// Represents a single node in a diagram flow.
///
/// Used in [WritingLayout.diagramHeavy] articles for visualizing:
/// - Architecture flows
/// - Process steps
/// - Decision trees
/// - System interactions
///
/// Features:
/// - Box with rounded corners
/// - Connection points (top/bottom)
/// - Customizable label
/// - Hover effects on desktop
/// - Animated entrance
class DiagramNode extends StatefulWidget {
  const DiagramNode({
    required this.label,
    this.delay = Duration.zero,
    this.isLast = false,
    this.isFirst = false,
  });

  /// Node label text
  final String label;

  /// Delay before animation
  final Duration delay;

  /// Whether this is the last node
  final bool isLast;

  /// Whether this is the first node
  final bool isFirst;

  @override
  State<DiagramNode> createState() => _DiagramNodeState();
}

class _DiagramNodeState extends State<DiagramNode> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      delay: widget.delay,
      child: Column(
        children: [
          // Connection from previous node
          if (!widget.isFirst)
            SizedBox(
              height: 20,
              child: Center(
                child: Container(width: 2, height: 20, color: AppColors.border),
              ),
            ),

          // Node box
          MouseRegion(
            onEnter: (_) => setState(() => _hovered = true),
            onExit: (_) => setState(() => _hovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.backgroundCardLight
                    : AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _hovered ? AppColors.primary : AppColors.border,
                  width: _hovered ? 2 : 1,
                ),
              ),
              child: Text(
                widget.label,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: _hovered
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Connection to next node
          if (!widget.isLast)
            Column(
              children: [
                SizedBox(
                  height: 20,
                  child: Center(
                    child: Container(
                      width: 2,
                      height: 20,
                      color: AppColors.border,
                    ),
                  ),
                ),
                // Arrow
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentSecondary.withValues(alpha: 0.4),
                  ),
                ),
                Container(width: 2, height: 10, color: AppColors.border),
              ],
            ),
        ],
      ),
    );
  }
}
