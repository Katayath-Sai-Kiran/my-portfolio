import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/writing_block.dart';
import '../widgets/fade_slide_in.dart';

/// Shared utility for building standard content blocks.
///
/// Used by [StandardLayout] and other layouts to consistently
/// render headings, paragraphs, lists, etc.
abstract final class StandardContentBuilder {
  /// Build a heading block with proper typography
  static Widget buildHeading(WritingBlock block, Duration delay) {
    final fontSize = _getFontSizeForHeadingLevel(block.headingLevel);
    final fontWeight = _getFontWeightForHeadingLevel(block.headingLevel);

    return FadeSlideIn(
      delay: delay,
      child: Text(
        block.content,
        style: AppTextStyles.headlineLarge.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  /// Build a paragraph block
  static Widget buildParagraph(WritingBlock block, Duration delay) {
    return FadeSlideIn(
      delay: delay,
      child: Text(
        block.content,
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textSecondary,
          height: 1.8,
        ),
      ),
    );
  }

  /// Build a bullet list block
  static Widget buildBulletList(WritingBlock block, Duration delay) {
    final items = block.listItems ?? [];

    return FadeSlideIn(
      delay: delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.content.isNotEmpty) ...[
            Text(
              block.content,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacingMd),
          ],
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.spacingMd,
                left: AppDimensions.spacingMd,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.accentSecondary,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spacingMd),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build an image block
  static Widget buildImage(WritingBlock block, Duration delay) {
    return FadeSlideIn(
      delay: delay,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (block.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              child: Image.network(
                block.imageUrl!,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          if (block.caption != null) ...[
            const SizedBox(height: AppDimensions.spacingMd),
            Text(
              block.caption!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textMuted,
                fontSize: 13,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build a takeaway/key insight card block
  static Widget buildTakeaway(WritingBlock block, Duration delay) {
    return FadeSlideIn(
      delay: delay,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundCardLight,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            left: BorderSide(color: AppColors.accentSecondary, width: 4),
            top: BorderSide(color: AppColors.border, width: 1),
            right: BorderSide(color: AppColors.border, width: 1),
            bottom: BorderSide(color: AppColors.border, width: 1),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: AppColors.accentSecondary,
              size: 24,
            ),
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
                    block.content,
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
    );
  }

  /// Get font size based on heading level
  static double _getFontSizeForHeadingLevel(int level) {
    switch (level) {
      case 1:
        return 36;
      case 2:
        return 28;
      default:
        return 22;
    }
  }

  /// Get font weight based on heading level
  static FontWeight _getFontWeightForHeadingLevel(int level) {
    switch (level) {
      case 1:
        return FontWeight.w700;
      case 2:
        return FontWeight.w600;
      default:
        return FontWeight.w500;
    }
  }
}
