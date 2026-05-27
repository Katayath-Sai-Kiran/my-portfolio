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

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
            children: [
              const SectionTitle(title: AppStrings.openSourceTitle),
              const SizedBox(height: 60),
              _ProjectsGrid(
                projects: PortfolioData.packages
                    .map(
                      (p) => ProjectModel(
                        title: p.name,
                        description: p.description,
                        tags: p.tags,
                        githubUrl: p.githubUrl ?? '',
                        liveUrl: p.pubUrl,
                      ),
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

class _ProjectsGrid extends StatelessWidget {
  const _ProjectsGrid({required this.projects});
  final List<ProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: isMobile ? 1 : 2,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      childAspectRatio: isMobile ? 1.2 : 1.0,
      children: projects
          .asMap()
          .entries
          .map((e) => _ProjectCard(project: e.value, index: e.key))
          .toList(),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project, required this.index});
  final ProjectModel project;
  final int index;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(28),
                transform: Matrix4.identity()
                  ..translate(0.0, _hovered ? -6.0 : 0.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                  border: Border.all(
                    color: _hovered ? AppColors.primary : AppColors.border,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.folder_open_rounded,
                          color: AppColors.accent,
                          size: 32,
                        ),
                        const Spacer(),
                        _IconLink(
                          icon: Icons.code_rounded,
                          url: widget.project.githubUrl,
                          tooltip: 'Code',
                        ),
                        if (widget.project.liveUrl != null) ...[
                          const SizedBox(width: 8),
                          _IconLink(
                            icon: Icons.open_in_new_rounded,
                            url: widget.project.liveUrl!,
                            tooltip: 'Live Demo',
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(widget.project.title, style: AppTextStyles.titleLarge),
                    const SizedBox(height: 12),
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
                      runSpacing: 8,
                      children: widget.project.tags
                          .map(
                            (tag) => Text(
                              tag,
                              style: AppTextStyles.mono.copyWith(fontSize: 12),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              )
              .animate(delay: (widget.index * 100).ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
    );
  }
}

class _IconLink extends StatefulWidget {
  const _IconLink({
    required this.icon,
    required this.url,
    required this.tooltip,
  });

  final IconData icon;
  final String url;
  final String tooltip;

  @override
  State<_IconLink> createState() => _IconLinkState();
}

class _IconLinkState extends State<_IconLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: () => launchUrl(Uri.parse(widget.url)),
          child: Icon(
            widget.icon,
            size: 22,
            color: _hovered ? AppColors.primary : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}
