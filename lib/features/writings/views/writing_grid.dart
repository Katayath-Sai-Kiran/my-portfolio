import 'package:flutter/material.dart';
import '../../../core/utils/responsive_helper.dart';
import '../models/writing_model.dart';
import 'writing_card.dart';

/// Responsive grid container for writing cards.
///
/// Automatically adjusts column count based on screen size:
/// - Desktop (>= 1024px): 3 columns
/// - Tablet (600-1023px): 2 columns
/// - Mobile (< 600px): 1 column
///
/// Uses [GridView.builder] for efficient rendering of large lists.
class WritingGrid extends StatelessWidget {
  const WritingGrid({required this.articles, required this.onArticleSelected});

  /// List of articles to display
  final List<WritingModel> articles;

  /// Callback when an article is selected
  final Function(WritingModel) onArticleSelected;

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = _getColumnCount(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: _getChildAspectRatio(),
      ),
      itemCount: articles.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => WritingCard(
        article: articles[index],
        index: index,
        onTap: () => onArticleSelected(articles[index]),
      ),
    );
  }

  int _getColumnCount(BuildContext context) {
    if (ResponsiveHelper.isDesktop(context)) {
      return 3;
    } else if (ResponsiveHelper.isTablet(context)) {
      return 2;
    } else {
      return 1;
    }
  }

  double _getChildAspectRatio() {
    // Adjust aspect ratio for card layout (width / height)
    // Cards with images have a specific proportional relationship
    return 1.5 / 1;
  }
}
