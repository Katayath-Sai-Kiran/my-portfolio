import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Header widget for articles with cover image, metadata, and title.
///
/// Displays professional article metadata:
/// - Cover image (optional)
/// - Title with large typography
/// - Subtitle
/// - Publication date, read time, tags
/// - Author information
///
/// Inspired by premium blog platforms for editorial aesthetic.
class ArticleHeader extends StatelessWidget {
  const ArticleHeader({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.readTime,
    required this.tags,
    this.imageUrl,
    this.author = 'Sai Kiran',
  });

  final String title;
  final String subtitle;
  final String date;
  final String readTime;
  final List<String> tags;
  final String? imageUrl;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Cover image if provided
        if (imageUrl != null)
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        if (imageUrl != null) const SizedBox(height: 32),

        // Title
        Text(
          title,
          style: AppTextStyles.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Subtitle
        Text(
          subtitle,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),

        // Metadata row: Date | Read Time | Author
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              readTime,
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
            Container(
              width: 4,
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              'By $author',
              style: AppTextStyles.bodyMedium.copyWith(
                fontSize: 14,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Tags
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: tags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCardLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
