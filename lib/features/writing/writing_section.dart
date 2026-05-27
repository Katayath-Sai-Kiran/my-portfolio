import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/widgets/section_title.dart';

class WritingSection extends StatelessWidget {
  const WritingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);

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
              ...PortfolioData.articles.asMap().entries.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _ArticleCard(
                    article: e.value,
                    index: e.key,
                    isMobile: isMobile,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleCard extends StatefulWidget {
  const _ArticleCard({
    required this.article,
    required this.index,
    required this.isMobile,
  });

  final WritingArticle article;
  final int index;
  final bool isMobile;

  @override
  State<_ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<_ArticleCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.article.url != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.article.url != null
            ? () => launchUrl(Uri.parse(widget.article.url!))
            : null,
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.cardRadius,
                    ),
                    border: Border.all(
                      color: _hovered ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundCardLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${widget.index + 1}'.padLeft(2, '0'),
                            style: AppTextStyles.mono.copyWith(
                              color: AppColors.textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.article.title,
                              style: AppTextStyles.titleLarge.copyWith(
                                fontSize: 16,
                                color: _hovered
                                    ? AppColors.textPrimary
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.article.summary,
                              style: AppTextStyles.bodyMedium.copyWith(
                                fontSize: 14,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        widget.article.url != null
                            ? Icons.open_in_new_rounded
                            : Icons.schedule_rounded,
                        size: 16,
                        color: widget.article.url != null
                            ? (_hovered
                                  ? AppColors.accentSecondary
                                  : AppColors.textMuted)
                            : AppColors.textMuted.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                )
                .animate(delay: (widget.index * 80).ms)
                .fadeIn(duration: 400.ms)
                .slideX(begin: -0.05, end: 0),
      ),
    );
  }
}
