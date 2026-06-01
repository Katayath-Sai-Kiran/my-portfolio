import 'writing_block.dart';
import 'writing_layout.dart';

/// Core model representing a complete article with metadata and content blocks.
///
/// This model follows modern CMS patterns, storing content as discrete blocks
/// rather than monolithic strings. This enables:
/// - Layout-agnostic content definition
/// - Easy extensibility for new block types
/// - Cleaner data structures
/// - Better content reusability
///
/// Example:
/// ```dart
/// WritingModel(
///   id: 'ai-pubdev-impact',
///   title: 'How AI is Reshaping Package Discovery on pub.dev',
///   subtitle: 'From manual search to intelligent recommendations',
///   date: DateTime(2026, 5, 15),
///   readTime: '8 min read',
///   tags: ['AI', 'pub.dev', 'Package Discovery'],
///   layoutType: WritingLayout.timeline,
///   blocks: [
///     WritingBlock(
///       type: WritingBlockType.heading,
///       content: 'The Evolution of Package Discovery',
///       headingLevel: 1,
///     ),
///     // ... more blocks
///   ],
/// )
/// ```
class WritingModel {
  const WritingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.readTime,
    required this.tags,
    required this.layoutType,
    required this.blocks,
    this.imageUrl,
    this.author = 'Sai Kiran',
  });

  /// Unique identifier for the article
  final String id;

  /// Article title
  final String title;

  /// Article subtitle or tagline
  final String subtitle;

  /// Publication date
  final DateTime date;

  /// Estimated read time (e.g., '8 min read')
  final String readTime;

  /// List of tags/topics for categorization and discovery
  final List<String> tags;

  /// Hero image URL (optional cover image)
  final String? imageUrl;

  /// Layout strategy that determines how content is rendered
  final WritingLayout layoutType;

  /// Ordered list of content blocks making up the article body
  final List<WritingBlock> blocks;

  /// Author name
  final String author;

  /// Convenience getter to format the date as a readable string
  String get formattedDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  WritingModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    DateTime? date,
    String? readTime,
    List<String>? tags,
    String? imageUrl,
    WritingLayout? layoutType,
    List<WritingBlock>? blocks,
    String? author,
  }) {
    return WritingModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      date: date ?? this.date,
      readTime: readTime ?? this.readTime,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      layoutType: layoutType ?? this.layoutType,
      blocks: blocks ?? this.blocks,
      author: author ?? this.author,
    );
  }
}
