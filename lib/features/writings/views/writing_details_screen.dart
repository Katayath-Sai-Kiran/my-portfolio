import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/utils/responsive_helper.dart';
import '../models/writing_model.dart';
import '../models/writing_layout.dart';
import '../layouts/standard_layout.dart';
import '../layouts/timeline_layout.dart';
import '../layouts/diagram_layout.dart';
import '../layouts/insights_layout.dart';
import '../widgets/article_header.dart';

/// Full-screen details view for a single article.
///
/// Receives a [WritingModel] and automatically selects the appropriate
/// layout based on [WritingModel.layoutType]. This is the core of the
/// dynamic rendering system—no layout logic exists outside this screen.
///
/// The layout selection happens here via switch statement, and the
/// corresponding layout widget handles rendering.
///
/// Features:
/// - Automatic layout selection
/// - Responsive content width
/// - Scroll-based navigation
/// - Professional typography
/// - Proper spacing and margins
/// - Back navigation
class WritingDetailsScreen extends StatelessWidget {
  const WritingDetailsScreen({required this.article});

  /// Article to display
  final WritingModel article;

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: hPad,
            vertical: AppDimensions.sectionPaddingVertical,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.spacingXl,
                    ),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColors.textMuted,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Back to Writings',
                              style: TextStyle(
                                color: AppColors.textMuted,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Article header
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.spacingHuge,
                    ),
                    child: ArticleHeader(
                      title: article.title,
                      subtitle: article.subtitle,
                      date: article.formattedDate,
                      readTime: article.readTime,
                      tags: article.tags,
                      imageUrl: article.imageUrl,
                      author: article.author,
                    ),
                  ),

                  // Divider
                  Container(
                    height: 1,
                    color: AppColors.border,
                    margin: const EdgeInsets.only(
                      bottom: AppDimensions.spacingHuge,
                    ),
                  ),

                  // Content rendered by appropriate layout
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: AppDimensions.sectionPaddingVertical,
                    ),
                    child: _buildLayout(article),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Build the appropriate layout widget based on article layout type.
  ///
  /// This is the core of the dynamic rendering system. The layout
  /// selection happens here, and each layout handles its own rendering logic.
  Widget _buildLayout(WritingModel article) {
    switch (article.layoutType) {
      case WritingLayout.standard:
        return StandardLayout(blocks: article.blocks);

      case WritingLayout.timeline:
        return TimelineLayout(blocks: article.blocks);

      case WritingLayout.diagramHeavy:
        return DiagramLayout(blocks: article.blocks);

      case WritingLayout.insights:
        return InsightsLayout(blocks: article.blocks);
    }
  }
}
