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

class EngineeringSection extends StatelessWidget {
  const EngineeringSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 2);

    return Container(
      width: double.infinity,
      color: AppColors.backgroundCard.withValues(alpha: 0.25),
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
                title: AppStrings.engineeringTitle,
                subtitle: AppStrings.engineeringSubtitle,
                alignment: CrossAxisAlignment.center,
              ),
              const SizedBox(height: 60),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isMobile ? 1.3 : 2,
                children: PortfolioData.engineeringProjects
                    .asMap()
                    .entries
                    .map(
                      (e) => _EngineeringCard(project: e.value, index: e.key),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EngineeringCard extends StatefulWidget {
  const _EngineeringCard({required this.project, required this.index});
  final EngineeringProject project;
  final int index;

  @override
  State<_EngineeringCard> createState() => _EngineeringCardState();
}

class _EngineeringCardState extends State<_EngineeringCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                  border: Border.all(
                    color: _hovered ? AppColors.primary : AppColors.border,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.accentSecondary.withValues(
                              alpha: 0.12,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.engineering_rounded,
                            size: 18,
                            color: AppColors.accentSecondary,
                          ),
                        ),
                        const Spacer(),
                        if (widget.project.liveUrl != null)
                          _IconLink(
                            icon: Icons.open_in_new_rounded,
                            url: widget.project.liveUrl!,
                            tooltip: 'Open',
                          ),
                        if (widget.project.githubUrl != null) ...[
                          const SizedBox(width: 8),
                          _IconLink(
                            icon: Icons.code_rounded,
                            url: widget.project.githubUrl!,
                            tooltip: 'Source',
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(widget.project.title, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        widget.project.description,
                        style: AppTextStyles.bodyMedium,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: widget.project.tags
                          .map((t) => _Tag(label: t))
                          .toList(),
                    ),
                  ],
                ),
              )
              .animate(delay: (widget.index * 100).ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.1, end: 0),
    );
  }
}

class _IconLink extends StatelessWidget {
  const _IconLink({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  final IconData icon;
  final String url;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () => launchUrl(Uri.parse(url)),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 18, color: AppColors.textMuted),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundCardLight,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: AppTextStyles.mono.copyWith(fontSize: 11)),
    );
  }
}
