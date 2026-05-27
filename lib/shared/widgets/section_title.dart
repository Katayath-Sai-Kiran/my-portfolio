import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.alignment = CrossAxisAlignment.center,
  });

  final String title;
  final String? subtitle;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          '// ${title.toLowerCase().replaceAll(' ', '_')}',
          style: AppTextStyles.mono,
        ).animate().fadeIn(duration: 400.ms),
        const SizedBox(height: 8),
        Text(title, style: AppTextStyles.headlineLarge)
            .animate()
            .fadeIn(delay: 100.ms, duration: 400.ms)
            .slideY(begin: 0.2, end: 0),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: AppTextStyles.bodyLarge,
          ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
        ],
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ).animate().fadeIn(delay: 300.ms).scaleX(begin: 0, end: 1),
      ],
    );
  }
}
