import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/widgets/chapter_header.dart';

const _insights = [
  'The rendering pipeline isn\'t magic — it\'s composable, measurable, and debuggable. '
      'I work at the layer where most engineers give up and reach for a package.',
  'Good architecture isn\'t about patterns — it\'s about where change can happen without '
      'cascading. I design state so the UI never knows where data comes from.',
  'Flutter is not an island. Knowing when and how to cross the platform boundary — '
      'and come back cleanly — is its own discipline.',
  'Data doesn\'t just appear in widgets. The full path from server to state makes '
      'debugging faster and architecture better.',
  'Sockets, reconnection logic, and offline queues. Real-time feels magical until it '
      'doesn\'t — I build the infra that makes it feel magical consistently.',
  'The gap between "it works on my machine" and "it ships reliably" is tooling. '
      'CI/CD and build automation aren\'t optional — they\'re the product.',
];

const _categoryColors = [
  Color(0xFF6366F1), // indigo   — Flutter & Dart
  Color(0xFF8B5CF6), // violet   — State & Architecture
  Color(0xFF06B6D4), // cyan     — Native & Platform
  Color(0xFFF97316), // orange   — Backend & Cloud
  Color(0xFF10B981), // emerald  — Real-time & Infra
  Color(0xFFF43F5E), // rose     — Tooling
];

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
                number: '04',
                title: 'Craft',
                narrative:
                    'I don\'t think in frameworks. I think in constraints. '
                    'Every skill below is a way of working — not just a tool I know, '
                    'but a mental model I\'ve built through shipping real things.',
              ),
              const SizedBox(height: 56),
              _SkillList(skills: PortfolioData.skills),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Skill list ────────────────────────────────────────────────────────────────

class _SkillList extends StatelessWidget {
  const _SkillList({required this.skills});
  final List<SkillCategory> skills;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Column(
      children: [
        // Top rule
        Container(height: 1, color: c.border),
        ...skills.asMap().entries.map(
          (e) => _SkillRow(
            category: e.value,
            insight: _insights[e.key],
            color: _categoryColors[e.key % _categoryColors.length],
            index: e.key,
          ),
        ),
      ],
    );
  }
}

// ── Single skill row ──────────────────────────────────────────────────────────

class _SkillRow extends StatefulWidget {
  const _SkillRow({
    required this.category,
    required this.insight,
    required this.color,
    required this.index,
  });

  final SkillCategory category;
  final String insight;
  final Color color;
  final int index;

  @override
  State<_SkillRow> createState() => _SkillRowState();
}

class _SkillRowState extends State<_SkillRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        color: _hovered ? widget.color.withValues(alpha: 0.04) : Colors.transparent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 4),
              child: isMobile
                  ? _MobileContent(
                      category: widget.category,
                      insight: widget.insight,
                      color: widget.color,
                      hovered: _hovered,
                      c: c,
                    )
                  : _DesktopContent(
                      category: widget.category,
                      insight: widget.insight,
                      color: widget.color,
                      hovered: _hovered,
                      c: c,
                    ),
            ),
            Container(height: 1, color: c.border),
          ],
        ),
      ),
    )
        .animate(delay: (widget.index * 70).ms)
        .fadeIn(duration: 400.ms)
        .slideX(begin: -0.03, end: 0);
  }
}

// ── Desktop: left label + right chips ────────────────────────────────────────

class _DesktopContent extends StatelessWidget {
  const _DesktopContent({
    required this.category,
    required this.insight,
    required this.color,
    required this.hovered,
    required this.c,
  });

  final SkillCategory category;
  final String insight;
  final Color color;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: category name + insight
        SizedBox(
          width: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Colored bar + label
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    width: 3,
                    height: 18,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: hovered ? 1.0 : 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      category.label,
                      style: AppTextStyles.titleLarge.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: hovered ? color : c.textPrimary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: Text(
                  insight,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 12,
                    color: c.textMuted,
                    height: 1.7,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 48),

        // Right: skill chips
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: category.skills
                  .map((s) => _Chip(label: s, color: color, c: c, hovered: hovered))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Mobile: stacked label / chips ────────────────────────────────────────────

class _MobileContent extends StatelessWidget {
  const _MobileContent({
    required this.category,
    required this.insight,
    required this.color,
    required this.hovered,
    required this.c,
  });

  final SkillCategory category;
  final String insight;
  final Color color;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 16,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              category.label,
              style: AppTextStyles.titleLarge.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: hovered ? color : c.textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          insight,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 12,
            color: c.textMuted,
            height: 1.7,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: category.skills
              .map((s) => _Chip(label: s, color: color, c: c, hovered: hovered))
              .toList(),
        ),
      ],
    );
  }
}

// ── Chip ──────────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.color,
    required this.c,
    required this.hovered,
  });

  final String label;
  final Color color;
  final PortfolioColors c;
  final bool hovered;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
      decoration: BoxDecoration(
        color: hovered
            ? color.withValues(alpha: 0.12)
            : color.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: hovered
              ? color.withValues(alpha: 0.45)
              : color.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(
          fontSize: 12,
          color: hovered
              ? color.withValues(alpha: 1.0)
              : color.withValues(alpha: 0.75),
        ),
      ),
    );
  }
}
