import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  static const List<String> _specializations = [
    'Flutter Rendering & CustomPainter',
    'ShaderMask & Shader-based UI',
    'Package Architecture & pub.dev',
    'Native Android Integrations',
    'Video & Media Infrastructure',
    'Firebase Systems',
    'Resumable Upload Infrastructure',
    'SDK-oriented Architecture',
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(title: AppStrings.aboutTitle),
              const SizedBox(height: 60),
              isMobile
                  ? _MobileAbout(specializations: _specializations)
                  : _DesktopAbout(specializations: _specializations),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  const _DesktopAbout({required this.specializations});
  final List<String> specializations;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _AboutText()),
        const SizedBox(width: 80),
        Expanded(flex: 2, child: _SpecializationsList(items: specializations)),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  const _MobileAbout({required this.specializations});
  final List<String> specializations;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _AboutText(),
        const SizedBox(height: 48),
        _SpecializationsList(items: specializations),
      ],
    );
  }
}

class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutDescription,
          style: AppTextStyles.bodyLarge,
        ).animate().fadeIn(duration: 500.ms),
        const SizedBox(height: 24),
        Text(
          AppStrings.aboutDetail,
          style: AppTextStyles.bodyMedium,
        ).animate().fadeIn(delay: 150.ms, duration: 500.ms),
      ],
    );
  }
}

class _SpecializationsList extends StatelessWidget {
  const _SpecializationsList({required this.items});
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specializations',
          style: AppTextStyles.titleLarge.copyWith(color: AppColors.textMuted),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items
              .asMap()
              .entries
              .map((e) => _SpecChip(label: e.value, index: e.key))
              .toList(),
        ),
      ],
    );
  }
}

class _SpecChip extends StatelessWidget {
  const _SpecChip({required this.label, required this.index});
  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.textSecondary,
        ),
      ),
    ).animate(delay: (index * 60).ms).fadeIn(duration: 300.ms);
  }
}
