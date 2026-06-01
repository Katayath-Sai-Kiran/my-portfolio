import 'package:flutter/material.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/writing_block.dart';
import '../widgets/key_takeaway_card.dart';
import '../widgets/quote_block.dart';
import '../widgets/diagram_node.dart';
import 'standard_content_builder.dart';

/// Insights and takeaways-focused layout.
///
/// Perfect for:
/// - Lessons learned articles
/// - Key takeaways
/// - Best practices summaries
/// - Case study conclusions
///
/// Features:
/// - Highlighted insight cards
/// - Emphasized key takeaways
/// - Quote blocks
/// - Readable spacing
/// - Premium presentation
class InsightsLayout extends StatelessWidget {
  const InsightsLayout({required this.blocks});

  /// Content blocks to render
  final List<WritingBlock> blocks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: blocks.asMap().entries.map((entry) {
        final index = entry.key;
        final block = entry.value;
        final delay = Duration(milliseconds: index * 50);

        switch (block.type) {
          case WritingBlockType.heading:
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? 0 : AppDimensions.spacingXl,
                bottom: AppDimensions.spacingMd,
              ),
              child: StandardContentBuilder.buildHeading(block, delay),
            );

          case WritingBlockType.paragraph:
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: StandardContentBuilder.buildParagraph(block, delay),
            );

          case WritingBlockType.bulletList:
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: StandardContentBuilder.buildBulletList(block, delay),
            );

          case WritingBlockType.quote:
            return Padding(
              padding: const EdgeInsets.only(
                top: AppDimensions.spacingMd,
                bottom: AppDimensions.spacingLg,
              ),
              child: QuoteBlock(content: block.content, delay: delay),
            );

          case WritingBlockType.takeaway:
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: KeyTakeawayCard(content: block.content, delay: delay),
            );

          case WritingBlockType.image:
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: StandardContentBuilder.buildImage(block, delay),
            );

          case WritingBlockType.diagram:
            // Render diagram nodes with flow steps
            final metadata = block.metadata;
            final flowSteps = metadata != null
                ? (metadata['flowSteps'] as List<dynamic>?)?.cast<String>()
                : null;

            if (flowSteps == null || flowSteps.isEmpty) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: Column(
                children: flowSteps.asMap().entries.map((entry) {
                  final nodeIndex = entry.key;
                  final step = entry.value;
                  final nodeDelay = Duration(
                    milliseconds: (index * 50) + (nodeIndex * 30),
                  );

                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: nodeIndex < flowSteps.length - 1 ? 0 : 0,
                    ),
                    child: DiagramNode(
                      label: step,
                      delay: nodeDelay,
                      isFirst: nodeIndex == 0,
                      isLast: nodeIndex == flowSteps.length - 1,
                    ),
                  );
                }).toList(),
              ),
            );
        }
      }).toList(),
    );
  }
}
