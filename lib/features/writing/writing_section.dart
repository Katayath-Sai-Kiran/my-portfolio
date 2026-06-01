import 'package:flutter/material.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/widgets/section_title.dart';
import '../writings/data/writings_data.dart';
import '../writings/views/writing_details_screen.dart';
import '../writings/views/writing_grid.dart';

/// Main writings section for the portfolio homepage.
///
/// Features:
/// - Responsive grid layout
/// - Automatic column adjustment based on screen size
/// - Premium article cards with hover effects
/// - Navigation to detail views
/// - Smooth animations
/// - Professional spacing
///
/// Layout:
/// - Desktop: Multiple columns
/// - Tablet: Reduced columns
/// - Mobile: Single column
class WritingSection extends StatelessWidget {
  const WritingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(
                title: AppStrings.writingTitle,
                subtitle: AppStrings.writingSubtitle,
              ),
              const SizedBox(height: 60),
              WritingGrid(
                articles: WritingsData.writings,
                onArticleSelected: (article) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          WritingDetailsScreen(article: article),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
