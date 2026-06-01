import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/writing_model.dart';
import '../models/writing_layout.dart';
import '../widgets/fade_slide_in.dart';

/// Premium writing card for displaying article previews.
///
/// Features:
/// - Hero image thumbnail
/// - Article title and subtitle
/// - Metadata (date, read time, tags)
/// - Hover effects on desktop
/// - Responsive design
/// - Layout badge indicator
/// - Smooth animations
///
/// Used in [WritingSection] as part of responsive grid.
class WritingCard extends StatefulWidget {
  const WritingCard({required this.article, required this.index, this.onTap});

  /// Article data
  final WritingModel article;

  /// Index for staggered animation
  final int index;

  /// Callback when card is tapped
  final VoidCallback? onTap;

  @override
  State<WritingCard> createState() => _WritingCardState();
}

class _WritingCardState extends State<WritingCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return FadeSlideIn(
      delay: Duration(milliseconds: widget.index * 100),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.backgroundCardLight
                  : AppColors.backgroundCard,
              borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              border: Border.all(
                color: _hovered ? AppColors.primary : AppColors.border,
                width: _hovered ? 1.5 : 1,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        blurRadius: 12,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero image
                if (widget.article.imageUrl != null)
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(AppDimensions.cardRadius),
                        topRight: Radius.circular(AppDimensions.cardRadius),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.article.imageUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                // Content
                Padding(
                  padding: const EdgeInsets.all(AppDimensions.spacingLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.article.title,
                        style: AppTextStyles.titleLarge.copyWith(
                          fontSize: 18,
                          color: _hovered
                              ? AppColors.textPrimary
                              : AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimensions.spacingSm),

                      // Subtitle
                      Text(
                        widget.article.subtitle,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppDimensions.spacingMd),

                      // Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: widget.article.tags
                            .take(3)
                            .map(
                              (tag) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundCardLight,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  tag,
                                  style: AppTextStyles.labelLarge.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: AppDimensions.spacingMd),

                      // Metadata footer
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.article.formattedDate,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.accentSecondary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  widget.article.readTime,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 12,
                                    color: AppColors.accentSecondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  _layoutBadge(),
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontSize: 12,
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
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
      ),
    );
  }

  String _layoutBadge() {
    switch (widget.article.layoutType) {
      case WritingLayout.standard:
        return 'Article';
      case WritingLayout.timeline:
        return 'Timeline';
      case WritingLayout.diagramHeavy:
        return 'Diagram';
      case WritingLayout.insights:
        return 'Insights';
    }
  }
}
