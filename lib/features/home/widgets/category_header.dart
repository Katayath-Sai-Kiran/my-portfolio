import 'package:flutter/material.dart';
import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../shared/models/portfolio_models.dart';

class CategoryHeader extends StatelessWidget {
  const CategoryHeader({required this.category, super.key});
  final PkgCategory category;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final data = _dataFor(category);
    return Row(
      children: [
        Icon(data.icon, size: 18, color: c.textMuted),
        const SizedBox(width: 10),
        Text(
          data.name,
          style: AppTypography.titleMedium.copyWith(
            color: c.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            border: Border.all(color: c.borderSubtle),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${data.count} packages',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 9,
            ),
          ),
        ),
      ],
    );
  }
}

class _CatData {
  const _CatData({required this.name, required this.icon, required this.count});
  final String name;
  final IconData icon;
  final int count;
}

_CatData _dataFor(PkgCategory cat) {
  switch (cat) {
    case PkgCategory.onDeviceAI:
      return const _CatData(name: 'On-Device AI', icon: Icons.auto_awesome, count: 3);
    case PkgCategory.textUI:
      return const _CatData(name: 'Text & UI', icon: Icons.text_fields, count: 9);
    case PkgCategory.devUtilities:
      return const _CatData(name: 'Developer Utilities', icon: Icons.build, count: 3);
  }
}
