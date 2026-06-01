import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'fade_slide_in.dart';

/// Highlighted takeaway or key insight card.
///
/// Used in [WritingLayout.insights] articles to emphasize:
/// - Key learnings
/// - Important conclusions
/// - Best practices
/// - Actionable insights
///
/// Visual style:
/// - Accent-colored left border
/// - Premium card design
/// - Icon indicator
/// - Animated entrance
class KeyTakeawayCard extends StatelessWidget {
  const KeyTakeawayCard({
    required this.content,
    this.delay = Duration.zero,
    this.icon = Icons.lightbulb_outline,
  });

  /// Takeaway text content
  final String content;

  /// Delay before animation
  final Duration delay;

  /// Icon to display (default: lightbulb)
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      delay: delay,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundCardLight,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: AppColors.accentSecondary, width: 4),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundCardLight,
            borderRadius: BorderRadius.circular(12),
            border: Border(
              top: BorderSide(color: AppColors.border, width: 1),
              right: BorderSide(color: AppColors.border, width: 1),
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: AppColors.accentSecondary, size: 24),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KEY TAKEAWAY',
                      style: AppTextStyles.labelLarge.copyWith(
                        fontSize: 11,
                        letterSpacing: 1.2,
                        color: AppColors.accentSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
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
