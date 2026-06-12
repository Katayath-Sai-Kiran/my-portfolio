import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/widgets/chapter_header.dart';

class EngineeringSection extends StatelessWidget {
  const EngineeringSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: c.background,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChapterHeader(
                number: '02',
                title: 'Engineering',
                narrative:
                    'Not all problems are worth solving. These were. Each one required '
                    'throwing away the obvious approach, reading Flutter internals, and '
                    'building something the framework doesn\'t give you out of the box.',
              ),
              const SizedBox(height: 64),
              _CaseStudyList(projects: PortfolioData.engineeringProjects),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Case study list ───────────────────────────────────────────────────────────

class _CaseStudyList extends StatelessWidget {
  const _CaseStudyList({required this.projects});
  final List<EngineeringProject> projects;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: projects.asMap().entries.map((e) {
        final isLast = e.key == projects.length - 1;
        return Column(
          children: [
            _CaseStudyItem(project: e.value, index: e.key),
            if (!isLast) _Separator(),
          ],
        );
      }).toList(),
    );
  }
}

class _Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: c.border)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: c.orange, shape: BoxShape.circle),
            ),
          ),
          Expanded(child: Container(height: 1, color: c.border)),
        ],
      ),
    );
  }
}

// ── Individual case study ─────────────────────────────────────────────────────

class _CaseStudyItem extends StatelessWidget {
  const _CaseStudyItem({required this.project, required this.index});
  final EngineeringProject project;
  final int index;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category badge + number row
            Row(
              children: [
                Text(
                  (index + 1).toString().padLeft(2, '0'),
                  style: AppTextStyles.mono.copyWith(
                    fontSize: 11,
                    color: c.orange,
                    letterSpacing: 2,
                  ),
                ),
                if (project.category != null) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: c.accentBg,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: c.accent.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      project.category!.toUpperCase(),
                      style: AppTextStyles.monoSmall.copyWith(
                        color: c.accentSubtle,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: 14),

            // Title
            Text(
              project.title,
              style: (isMobile ? AppTextStyles.headlineMedium : AppTextStyles.headlineLarge)
                  .copyWith(
                color: c.textPrimary,
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),

            const SizedBox(height: 24),

            // Description + bullets + tag panel
            isMobile
                ? _MobileBody(project: project, c: c)
                : _DesktopBody(project: project, c: c),

            // External links
            if (project.githubUrl != null || project.liveUrl != null) ...[
              const SizedBox(height: 24),
              Wrap(
                spacing: 12,
                children: [
                  if (project.liveUrl != null)
                    _OutlineLink(label: 'Live demo', icon: Icons.open_in_new_rounded, url: project.liveUrl!, c: c),
                  if (project.githubUrl != null)
                    _OutlineLink(label: 'Source code', icon: Icons.code_rounded, url: project.githubUrl!, c: c),
                ],
              ),
            ],
          ],
        )
        .animate(delay: (index * 120).ms)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.08, end: 0);
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({required this.project, required this.c});
  final EngineeringProject project;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.description,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: c.textSecondary,
                  height: 1.75,
                ),
              ),
              if (project.bullets != null && project.bullets!.isNotEmpty) ...[
                const SizedBox(height: 20),
                _BulletList(bullets: project.bullets!, c: c),
              ],
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _TagPanel(tags: project.tags, c: c)),
      ],
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({required this.project, required this.c});
  final EngineeringProject project;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.description,
          style: AppTextStyles.bodyLarge.copyWith(color: c.textSecondary, height: 1.75),
        ),
        if (project.bullets != null && project.bullets!.isNotEmpty) ...[
          const SizedBox(height: 16),
          _BulletList(bullets: project.bullets!, c: c),
        ],
        const SizedBox(height: 20),
        _TagPanel(tags: project.tags, c: c),
      ],
    );
  }
}

// ── Bullet list ───────────────────────────────────────────────────────────────

class _BulletList extends StatelessWidget {
  const _BulletList({required this.bullets, required this.c});
  final List<String> bullets;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bullets.map((b) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 9),
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    color: c.orange.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  b,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: c.textSecondary,
                    height: 1.65,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── Tag panel ─────────────────────────────────────────────────────────────────

class _TagPanel extends StatelessWidget {
  const _TagPanel({required this.tags, required this.c});
  final List<String> tags;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STACK',
          style: AppTextStyles.mono.copyWith(
            fontSize: 10,
            letterSpacing: 2,
            color: c.textMuted,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tags.map((t) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: c.border),
              ),
              child: Text(
                t,
                style: AppTextStyles.mono.copyWith(
                  fontSize: 11,
                  color: c.textSecondary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// ── Outline link ──────────────────────────────────────────────────────────────

class _OutlineLink extends StatefulWidget {
  const _OutlineLink({
    required this.label,
    required this.icon,
    required this.url,
    required this.c,
  });
  final String label;
  final IconData icon;
  final String url;
  final PortfolioColors c;

  @override
  State<_OutlineLink> createState() => _OutlineLinkState();
}

class _OutlineLinkState extends State<_OutlineLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _hovered ? c.surfaceHover : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _hovered ? c.accent : c.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 13,
                color: _hovered ? c.textPrimary : c.textMuted,
              ),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: AppTextStyles.labelLarge.copyWith(
                  color: _hovered ? c.textPrimary : c.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
