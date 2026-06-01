import 'package:flutter/material.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/writing_block.dart';
import '../widgets/key_takeaway_card.dart';
import '../widgets/quote_block.dart';
import 'standard_content_builder.dart';

/// Standard article layout with traditional typography and spacing.
///
/// Perfect for:
/// - Technical deep-dives
/// - Engineering writeups
/// - Educational content
/// - Traditional blog posts
///
/// Features:
/// - Maximum readable width constraint
/// - Proper typography hierarchy
/// - Professional spacing
/// - Rich content block rendering
/// - Fade-in animations
class StandardLayout extends StatelessWidget {
  const StandardLayout({required this.blocks});

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

          case WritingBlockType.image:
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: StandardContentBuilder.buildImage(block, delay),
            );

          case WritingBlockType.takeaway:
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: KeyTakeawayCard(content: block.content, delay: delay),
            );

          case WritingBlockType.diagram:
            // Skip diagrams in standard layout
            return Padding(
              padding: const EdgeInsets.only(bottom: AppDimensions.spacingLg),
              child: KeyTakeawayCard(content: block.content, delay: delay),
            );
        }
      }).toList(),
    );
  }
}
