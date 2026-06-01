import 'package:flutter/material.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/writing_block.dart';
import '../widgets/timeline_item.dart';

/// Timeline-based article layout with vertical progression.
///
/// Perfect for:
/// - Project evolution stories
/// - Career journeys
/// - Historical breakdowns
/// - Product timelines
///
/// Features:
/// - Vertical timeline visualization
/// - Animated timeline nodes
/// - Connected timeline line
/// - Professional progression style
class TimelineLayout extends StatelessWidget {
  const TimelineLayout({required this.blocks});

  /// Content blocks to render
  final List<WritingBlock> blocks;

  @override
  Widget build(BuildContext context) {
    // Extract timeline events from blocks
    final events = <(String, String)>[];

    for (final block in blocks) {
      if (block.type == WritingBlockType.heading) {
        // Use heading as title
        String? nextDescription;
        final blockIndex = blocks.indexOf(block);

        // Look for next paragraph
        for (int i = blockIndex + 1; i < blocks.length; i++) {
          if (blocks[i].type == WritingBlockType.paragraph) {
            nextDescription = blocks[i].content;
            break;
          } else if (blocks[i].type == WritingBlockType.heading) {
            break;
          }
        }

        if (nextDescription != null) {
          events.add((block.content, nextDescription));
        }
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: events.asMap().entries.map((entry) {
          final index = entry.key;
          final (title, description) = entry.value;
          final delay = Duration(milliseconds: index * 100);

          return Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.spacingXxl),
            child: TimelineItem(
              title: title,
              description: description,
              isLast: index == events.length - 1,
              delay: delay,
            ),
          );
        }).toList(),
      ),
    );
  }
}
