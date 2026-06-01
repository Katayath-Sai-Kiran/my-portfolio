/// Enum defining the types of content blocks in an article.
///
/// This system enables flexible, modular article construction without
/// storing content as a single monolithic string. Each block type can be
/// independently rendered and styled.
enum WritingBlockType {
  /// Heading blocks (h1, h2, h3)
  heading,

  /// Paragraph blocks with rich text content
  paragraph,

  /// Unordered or ordered list blocks
  bulletList,

  /// Standalone quote or callout
  quote,

  /// Image with optional caption
  image,

  /// Diagram node (for diagram-heavy layouts)
  diagram,

  /// Key takeaway or highlight card
  takeaway,
}

/// Represents a single content block within an article.
///
/// This model provides flexibility to support diverse content types
/// while maintaining a consistent structure. New block types can be
/// added by extending this class or adding to the enum.
class WritingBlock {
  const WritingBlock({
    required this.type,
    required this.content,
    this.listItems,
    this.imageUrl,
    this.headingLevel = 2,
    this.caption,
    this.metadata,
  });

  /// The type of content this block contains
  final WritingBlockType type;

  /// Primary text content (heading text, paragraph, quote, etc.)
  final String content;

  /// List items (used when type is bulletList)
  final List<String>? listItems;

  /// Image URL (used when type is image or diagram)
  final String? imageUrl;

  /// Heading level (1-3). Defaults to 2 (h2)
  final int headingLevel;

  /// Caption text for images or diagrams
  final String? caption;

  /// Additional metadata for extensibility
  /// Can store layout hints, styling preferences, or other data
  final Map<String, dynamic>? metadata;

  WritingBlock copyWith({
    WritingBlockType? type,
    String? content,
    List<String>? listItems,
    String? imageUrl,
    int? headingLevel,
    String? caption,
    Map<String, dynamic>? metadata,
  }) {
    return WritingBlock(
      type: type ?? this.type,
      content: content ?? this.content,
      listItems: listItems ?? this.listItems,
      imageUrl: imageUrl ?? this.imageUrl,
      headingLevel: headingLevel ?? this.headingLevel,
      caption: caption ?? this.caption,
      metadata: metadata ?? this.metadata,
    );
  }
}
