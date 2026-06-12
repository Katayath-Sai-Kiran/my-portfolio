import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: c.border)),
      ),
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Designed & Built by ',
                  style: AppTextStyles.bodyMedium.copyWith(color: c.textMuted),
                ),
                TextSpan(
                  text: AppStrings.heroName,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: c.accent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          Text(
            '© ${DateTime.now().year} All rights reserved.',
            style: AppTextStyles.labelLarge.copyWith(color: c.textMuted),
          ),
        ],
      ),
    );
  }
}
