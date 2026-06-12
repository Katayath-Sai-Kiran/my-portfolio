import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/widgets/chapter_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      width: double.infinity,
      color: c.surface.withValues(alpha: 0.4),
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
                number: '03',
                title: 'Journey',
                narrative:
                    'Two companies. Two very different definitions of "production ready". '
                    'Every job taught me something that couldn\'t come from documentation — '
                    'the kind of knowledge that only exists after something breaks in the wild.',
              ),
              const SizedBox(height: 64),
              _SceneList(experiences: PortfolioData.experience),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Scene list ────────────────────────────────────────────────────────────────

class _SceneList extends StatelessWidget {
  const _SceneList({required this.experiences});
  final List<ExperienceModel> experiences;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: experiences.asMap().entries.map((e) {
        final isLast = e.key == experiences.length - 1;
        return Column(
          children: [
            _SceneCard(experience: e.value, index: e.key),
            if (!isLast) const SizedBox(height: 24),
          ],
        );
      }).toList(),
    );
  }
}

// ── Scene card ────────────────────────────────────────────────────────────────

class _SceneCard extends StatelessWidget {
  const _SceneCard({required this.experience, required this.index});
  final ExperienceModel experience;
  final int index;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
          padding: const EdgeInsets.all(36),
          decoration: BoxDecoration(
            color: c.surface,
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            border: Border.all(color: c.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isMobile
                  ? _MobileSceneHeader(experience: experience, c: c)
                  : _DesktopSceneHeader(experience: experience, c: c),

              const SizedBox(height: 28),
              Container(height: 1, color: c.border),
              const SizedBox(height: 28),

              Text(
                experience.description,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: c.textSecondary,
                  height: 1.75,
                ),
              ),

              const SizedBox(height: 28),

              _BulletList(bullets: experience.bullets, c: c),

              const SizedBox(height: 28),

              _TechRow(technologies: experience.technologies, c: c),
            ],
          ),
        )
        .animate(delay: (index * 150).ms)
        .fadeIn(duration: 500.ms)
        .slideY(begin: 0.06, end: 0);
  }
}

class _DesktopSceneHeader extends StatelessWidget {
  const _DesktopSceneHeader({required this.experience, required this.c});
  final ExperienceModel experience;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                experience.role,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: c.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                experience.company,
                style: AppTextStyles.titleLarge.copyWith(
                  color: c.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: c.surfaceHover,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: c.border),
          ),
          child: Text(
            experience.duration,
            style: AppTextStyles.mono.copyWith(
              fontSize: 13,
              color: c.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileSceneHeader extends StatelessWidget {
  const _MobileSceneHeader({required this.experience, required this.c});
  final ExperienceModel experience;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          experience.duration,
          style: AppTextStyles.mono.copyWith(
            fontSize: 11,
            color: c.orange,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          experience.role,
          style: AppTextStyles.headlineMedium.copyWith(
            color: c.textPrimary,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          experience.company,
          style: AppTextStyles.titleLarge.copyWith(
            color: c.orange,
            fontWeight: FontWeight.w500,
          ),
        ),
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
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    color: c.orange.withValues(alpha: 0.7),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: 14),
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

// ── Tech tags ─────────────────────────────────────────────────────────────────

class _TechRow extends StatelessWidget {
  const _TechRow({required this.technologies, required this.c});
  final List<String> technologies;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TECHNOLOGIES',
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
          children: technologies.map((t) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: c.accentBg,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: c.accent.withValues(alpha: 0.25)),
              ),
              child: Text(
                t,
                style: AppTextStyles.mono.copyWith(
                  fontSize: 12,
                  color: c.accentSubtle,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
