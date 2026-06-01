import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'fade_slide_in.dart';

/// Visual representation of a timeline event node.
///
/// Used in [WritingLayout.timeline] articles to display sequential events
/// with connecting lines. Includes animated entrance.
///
/// Features:
/// - Circular node indicator
/// - Connected line to next event
/// - Content area for event details
/// - Customizable styling
class TimelineItem extends StatelessWidget {
  const TimelineItem({
    required this.title,
    required this.description,
    required this.isLast,
    this.delay = Duration.zero,
    this.number,
  });

  /// Title of the timeline event
  final String title;

  /// Description or details of the event
  final String description;

  /// Whether this is the last item (no line below)
  final bool isLast;

  /// Delay before animation
  final Duration delay;

  /// Optional number or label for the node
  final int? number;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      delay: delay,
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline line and node
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  // Node circle
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentSecondary,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentSecondary.withValues(
                            alpha: 0.4,
                          ),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  // Connecting line (if not last)
                  if (!isLast)
                    Expanded(
                      child: Container(width: 2, color: AppColors.border),
                    )
                  else
                    const SizedBox(height: 0),
                ],
              ),
            ),
            const SizedBox(width: 24),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
