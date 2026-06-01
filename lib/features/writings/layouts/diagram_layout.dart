import 'package:flutter/material.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/writing_block.dart';
import '../widgets/diagram_node.dart';

/// Diagram-focused layout with visual flow nodes.
///
/// Perfect for:
/// - Architecture articles
/// - Workflow explanations
/// - System interactions
/// - Process flows
/// - Visual conceptual models
///
/// Features:
/// - Connected diagram nodes
/// - Flow-based visualization
/// - Animated node entrance
/// - Professional diagram styling
class DiagramLayout extends StatelessWidget {
  const DiagramLayout({required this.blocks});

  /// Content blocks to render
  final List<WritingBlock> blocks;

  @override
  Widget build(BuildContext context) {
    // Extract diagram flows and supporting content
    final diagramMetadata = _extractDiagramFlow();

    return Column(
      children: [
        // Render diagram flow
        if (diagramMetadata.isNotEmpty)
          Column(
            children: diagramMetadata.asMap().entries.map((entry) {
              final index = entry.key;
              final node = entry.value;
              final delay = Duration(milliseconds: index * 120);

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index < diagramMetadata.length - 1
                      ? AppDimensions.spacingXl
                      : AppDimensions.spacingXxl,
                ),
                child: DiagramNode(
                  label: node,
                  delay: delay,
                  isFirst: index == 0,
                  isLast: index == diagramMetadata.length - 1,
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  /// Extract diagram flow from metadata
  List<String> _extractDiagramFlow() {
    final diagramBlock = blocks.firstWhere(
      (b) => b.type == WritingBlockType.diagram,
      orElse: () => throw Exception('No diagram block found'),
    );

    final metadata = diagramBlock.metadata;
    if (metadata == null) return [];

    final flowSteps = metadata['flowSteps'] as List<dynamic>?;
    if (flowSteps != null) {
      return flowSteps.cast<String>().toList();
    }

    return [];
  }
}
