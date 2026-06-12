import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';

/// Editorial chapter header — used by every storytelling section.
///
/// Renders:
///   "01 — SECTION NAME"    ← indigo mono ordinal
///   "Section Title"         ← Space Grotesk bold
///   Narrative paragraph     ← italic, with left gradient bar (start-aligned only)
class ChapterHeader extends StatelessWidget {
  const ChapterHeader({
    super.key,
    required this.number,
    required this.title,
    required this.narrative,
    this.alignment = CrossAxisAlignment.start,
  });

  final String number;
  final String title;
  final String narrative;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final centered = alignment == CrossAxisAlignment.center;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Ordinal chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: c.accentBg,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: c.accent.withValues(alpha: 0.25)),
          ),
          child: Text(
            '$number — ${title.toUpperCase()}',
            style: AppTextStyles.monoSmall.copyWith(color: c.accent),
          ),
        ).animate().fadeIn(duration: 400.ms),

        const SizedBox(height: 20),

        Text(
          title,
          style: (isMobile ? AppTextStyles.headlineLarge : AppTextStyles.displayMedium)
              .copyWith(color: c.textPrimary),
          textAlign: centered ? TextAlign.center : TextAlign.start,
        )
            .animate()
            .fadeIn(delay: 80.ms, duration: 500.ms)
            .slideY(begin: 0.1, end: 0),

        const SizedBox(height: 24),

        centered
            ? ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  narrative,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: c.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ).animate().fadeIn(delay: 160.ms, duration: 500.ms)
            : IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [c.accent, c.accent.withValues(alpha: 0.0)],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        narrative,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: c.textSecondary,
                          fontStyle: FontStyle.italic,
                          fontSize: isMobile ? 16 : 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 160.ms, duration: 500.ms),
      ],
    );
  }
}
