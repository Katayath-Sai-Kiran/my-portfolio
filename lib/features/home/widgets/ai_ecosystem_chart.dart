import 'package:flutter/material.dart';

import '../../../core/design/app_colors.dart';
import '../../../core/design/app_typography.dart';
import '../../../data/models/package_model.dart';

class AiEcosystemChart extends StatelessWidget {
  const AiEcosystemChart({super.key});

  static const _root = PackageModel(
    name: 'ai_core_codespark',
    displayName: 'AI Core',
    description: 'Offline embedding engine',
    category: PkgCategory.onDeviceAI,
    tags: ['23MB MiniLM', 'Semantic'],
    pubUrl: '',
    githubUrl: '',
    isFeatured: true,
  );

  static const _children = [
    PackageModel(
      name: 'semantic_search_codespark',
      displayName: 'Semantic Search',
      description: 'Query-driven search',
      category: PkgCategory.onDeviceAI,
      tags: ['MMR', 'Debounced'],
      pubUrl: '',
      githubUrl: '',
      isFeatured: true,
    ),
    PackageModel(
      name: 'smart_suggestions_codespark',
      displayName: 'Smart Suggestions',
      description: 'Anchor-based recommendations',
      category: PkgCategory.onDeviceAI,
      tags: ['MMR', 'Centroid'],
      pubUrl: '',
      githubUrl: '',
      isFeatured: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return CustomPaint(
      painter: _ConnectorPainter(color: c.border.withValues(alpha: 0.4)),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: _NodeCard(pkg: _root, c: c, isRoot: true),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: _children
                .map(
                  (p) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _NodeCard(pkg: p, c: c, isRoot: false),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _NodeCard extends StatelessWidget {
  const _NodeCard({required this.pkg, required this.c, required this.isRoot});
  final PackageModel pkg;
  final PortfolioColors c;
  final bool isRoot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isRoot ? 16 : 12),
      decoration: BoxDecoration(
        border: Border.all(color: c.border),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            pkg.displayName,
            style:
                (isRoot ? AppTypography.titleMedium : AppTypography.labelLarge)
                    .copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
          ),
          const SizedBox(height: 2),
          Text(
            pkg.description,
            style: AppTypography.bodySmall.copyWith(color: c.textMuted),
          ),
        ],
      ),
    );
  }
}

class _ConnectorPainter extends CustomPainter {
  _ConnectorPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final cx = size.width * 0.48;
    final midY = size.height / 2;
    final childY1 = size.height * 0.28;
    final childY2 = size.height * 0.72;

    final path = Path()
      ..moveTo(cx, midY)
      ..lineTo(cx + 20, midY)
      ..moveTo(cx + 20, childY1)
      ..lineTo(cx + 20, childY2)
      ..moveTo(cx + 20, childY1)
      ..lineTo(cx + 40, childY1)
      ..moveTo(cx + 20, childY2)
      ..lineTo(cx + 40, childY2);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
