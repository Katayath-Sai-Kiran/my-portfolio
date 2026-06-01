import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import 'fade_slide_in.dart';

/// Standalone quote or callout block widget.
///
/// Used in articles to emphasize:
/// - Important quotes
/// - Philosophical statements
/// - Key principles
/// - Wisdom from experience
///
/// Visual style:
/// - Left accent border
/// - Italic, larger typography
/// - Premium styling
/// - Animated entrance
class QuoteBlock extends StatelessWidget {
  const QuoteBlock({
    required this.content,
    this.delay = Duration.zero,
    this.author,
  });

  /// Quote text
  final String content;

  /// Delay before animation
  final Duration delay;

  /// Optional attribution
  final String? author;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      delay: delay,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: AppColors.accentSecondary, width: 4),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.format_quote,
              color: AppColors.accentSecondary.withValues(alpha: 0.5),
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: AppTextStyles.headlineMedium.copyWith(
                fontSize: 22,
                fontStyle: FontStyle.italic,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (author != null) ...[
              const SizedBox(height: 12),
              Text(
                '— $author',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
