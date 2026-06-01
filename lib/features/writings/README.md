# Writings / Blog Feature

## Overview

A production-ready, dynamic article system for the Flutter portfolio website. Articles define their own layout through data, enabling automatic UI rendering without modifying screen code.

This is a **CMS-like pattern** where each article is composed of discrete content blocks, and layout selection is data-driven.

## Architecture

```
features/
└── writings/
    ├── models/
    │   ├── writing_model.dart      # Core article model
    │   ├── writing_block.dart      # Content block types and model
    │   └── writing_layout.dart     # Layout enum
    │
    ├── data/
    │   └── writings_data.dart      # Static article data
    │
    ├── views/
    │   ├── writing_card.dart       # Card preview widget
    │   ├── writing_grid.dart       # Responsive grid container
    │   └── writing_details_screen.dart  # Full-screen detail view
    │
    ├── layouts/
    │   ├── standard_layout.dart    # Traditional article
    │   ├── timeline_layout.dart    # Timeline progression
    │   ├── diagram_layout.dart     # Visual flows
    │   ├── insights_layout.dart    # Lessons & takeaways
    │   └── standard_content_builder.dart  # Shared rendering logic
    │
    └── widgets/
        ├── fade_slide_in.dart           # Reusable animation
        ├── article_header.dart          # Article metadata + cover
        ├── timeline_item.dart           # Timeline event node
        ├── diagram_node.dart            # Diagram flow node
        ├── key_takeaway_card.dart       # Highlighted insight
        └── quote_block.dart             # Quote/callout block
```

## Core Concepts

### 1. WritingLayout Enum

Four layout strategies, each optimized for different content types:

```dart
enum WritingLayout {
  standard,      // Traditional blog article
  timeline,      // Chronological progression
  diagramHeavy,  // Visual flows and diagrams
  insights,      // Key learnings and takeaways
}
```

### 2. WritingBlockType Enum

Content is composed of discrete blocks:

```dart
enum WritingBlockType {
  heading,      // h1, h2, h3
  paragraph,    // Body text
  bulletList,   // Bullet/numbered items
  quote,        // Emphasis/callout
  image,        // Image with caption
  diagram,      // Diagram flow node
  takeaway,     // Key insight card
}
```

### 3. WritingBlock Model

Each block represents a single content unit:

```dart
class WritingBlock {
  const WritingBlock({
    required this.type,           // Content type
    required this.content,        // Primary text
    this.listItems,               // For bulletList
    this.imageUrl,                // For image/diagram
    this.headingLevel = 2,        // For heading
    this.caption,                 // Optional caption
    this.metadata,                // Extensibility
  });
}
```

### 4. WritingModel

The complete article definition:

```dart
class WritingModel {
  const WritingModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.readTime,
    required this.tags,
    required this.layoutType,    // Layout selection
    required this.blocks,        // Content blocks
    this.imageUrl,               // Hero image
  });
}
```

## How It Works

### Adding a New Article

Edit `writings_data.dart` and add a new `WritingModel`:

```dart
WritingModel(
  id: 'my-article-id',
  title: 'My Article Title',
  subtitle: 'A brief summary',
  date: DateTime.utc(2026, 5, 20),
  readTime: '5 min read',
  tags: ['Flutter', 'Design'],
  layoutType: WritingLayout.standard,
  blocks: [
    WritingBlock(
      type: WritingBlockType.heading,
      content: 'Article Heading',
      headingLevel: 1,
    ),
    WritingBlock(
      type: WritingBlockType.paragraph,
      content: 'Paragraph content here...',
    ),
    // ... more blocks
  ],
)
```

**No UI code changes needed.** The system automatically selects the correct layout.

### Viewing an Article

1. User clicks a writing card in `WritingSection`
2. `WritingDetailsScreen` receives the `WritingModel`
3. Screen inspects `layoutType` and renders appropriate layout
4. Layout widget renders blocks according to its strategy

```dart
Widget _buildLayout(WritingModel article) {
  switch (article.layoutType) {
    case WritingLayout.standard:
      return StandardLayout(blocks: article.blocks);
    case WritingLayout.timeline:
      return TimelineLayout(blocks: article.blocks);
    case WritingLayout.diagramHeavy:
      return DiagramLayout(blocks: article.blocks);
    case WritingLayout.insights:
      return InsightsLayout(blocks: article.blocks);
  }
}
```

## Layout Strategies

### Standard Layout

Traditional article with linear content flow.

**Best for:**
- Technical deep-dives
- Engineering writeups
- Educational content
- Blog posts

**Features:**
- Max-width constraint for readability
- Proper typography hierarchy
- Professional spacing
- Fade-in animations
- Handles: heading, paragraph, bulletList, quote, image

### Timeline Layout

Vertical timeline with events and progression.

**Best for:**
- Project evolution stories
- Career timelines
- Historical breakdowns
- Product journeys

**Features:**
- Connected timeline nodes
- Animated nodes
- Timeline indicators
- Extracts events from heading + paragraph pairs

### Diagram Layout

Visual flows with connected nodes.

**Best for:**
- Architecture articles
- Workflow explanations
- System interactions
- Process flows

**Features:**
- Diagram node visualization
- Connected flow indicators
- Hover effects
- Extracts flow steps from diagram block metadata

### Insights Layout

Premium presentation of key learnings.

**Best for:**
- Lessons learned articles
- Best practices guides
- Case study conclusions
- Key takeaways summaries

**Features:**
- Highlighted takeaway cards
- Quote blocks
- Professional spacing
- Handles: heading, paragraph, bulletList, quote, takeaway, image

## Content Blocks

### Heading Block

```dart
WritingBlock(
  type: WritingBlockType.heading,
  content: 'My Heading',
  headingLevel: 1, // 1, 2, or 3
)
```

### Paragraph Block

```dart
WritingBlock(
  type: WritingBlockType.paragraph,
  content: 'Paragraph text content...',
)
```

### Bullet List Block

```dart
WritingBlock(
  type: WritingBlockType.bulletList,
  content: 'List title (optional)',
  listItems: [
    'First item',
    'Second item',
    'Third item',
  ],
)
```

### Quote Block

```dart
WritingBlock(
  type: WritingBlockType.quote,
  content: 'The quote text goes here',
)
```

### Image Block

```dart
WritingBlock(
  type: WritingBlockType.image,
  imageUrl: 'https://example.com/image.jpg',
  caption: 'Image description',
)
```

### Diagram Block

```dart
WritingBlock(
  type: WritingBlockType.diagram,
  content: 'Flow description',
  metadata: {
    'flowSteps': [
      'Step 1',
      'Step 2',
      'Step 3',
      'Step 4',
    ]
  },
)
```

### Takeaway Block

```dart
WritingBlock(
  type: WritingBlockType.takeaway,
  content: 'Key learning or insight',
)
```

## Animations

All content uses the `FadeSlideIn` widget for professional entrance animations:

```dart
FadeSlideIn(
  delay: Duration(milliseconds: 100),
  duration: Duration(milliseconds: 500),
  child: MyWidget(),
)
```

- Combines fade and slide transitions
- Customizable delay and duration
- Used by: headers, timeline nodes, images, diagram blocks, takeaway cards
- No external animation packages required

## Responsive Design

The grid adapts to screen size:

```
Desktop (>= 1024px): 3 columns
Tablet (600-1023px): 2 columns
Mobile (< 600px):   1 column
```

Implemented in `WritingGrid` and responsive helper utilities.

## Styling & Theming

All styling uses existing portfolio theme:

- **Colors:** AppColors (dark theme)
- **Typography:** AppTextStyles (Google Fonts + Inter)
- **Spacing:** AppDimensions (8px grid)
- **Radius:** 16px standard, 8px small
- **Shadows:** Subtle, accent-based on hover

Premium aesthetic inspired by platforms like Medium, Substack, and Intercom.

## Sample Articles

Four complete sample articles are included:

1. **AI and pub.dev Impact** (Timeline Layout)
   - Project: How AI is reshaping package discovery
   - Type: Evolution/history
   - Content: 4 timeline phases

2. **Flutter Package Architecture** (Diagram Layout)
   - Project: Designing scalable utility packages
   - Type: Technical deep-dive
   - Content: Architecture workflows, best practices

3. **Open Source Lessons** (Insights Layout)
   - Project: 8 packages on pub.dev
   - Type: Lessons learned
   - Content: 6 key insights with takeaway cards

4. **CustomPainter Deep Dive** (Standard Layout)
   - Project: Mastering Flutter rendering
   - Type: Technical tutorial
   - Content: Linear article with tips and examples

## Navigation Integration

Articles are linked via `WritingDetailsScreen`, which receives the `WritingModel` via `Navigator.push()`:

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => WritingDetailsScreen(
      article: selectedArticle,
    ),
  ),
);
```

No route parameters or complex state management needed—the model is passed directly.

## Extensibility

### Adding a New Layout

1. Create `lib/features/writings/layouts/my_layout.dart`
2. Implement with proper block handling
3. Add case to `WritingDetailsScreen._buildLayout()`
4. Use in articles via `layoutType: WritingLayout.myNewLayout`

### Adding New Block Types

1. Add to `WritingBlockType` enum
2. Implement rendering in relevant layouts
3. Use in `WritingBlock` definitions
4. No changes to existing articles required

### Custom Metadata

Each `WritingBlock` has optional `metadata` for extensibility:

```dart
WritingBlock(
  type: WritingBlockType.diagram,
  content: 'Custom visualization',
  metadata: {
    'customKey': 'customValue',
    'anotherKey': 123,
  },
)
```

## Code Quality

- ✅ Null-safe (100%)
- ✅ Const constructors where possible
- ✅ Comprehensive documentation
- ✅ Separation of concerns
- ✅ DRY principles (StandardContentBuilder)
- ✅ Feature-first architecture
- ✅ No duplicated UI logic

## File Structure

```
Total files: 16
- Models: 3
- Data: 1
- Views: 3
- Layouts: 5
- Widgets: 6
- Total lines: ~1,500 (excluding samples)
```

## Key Files

| File | Purpose |
|------|---------|
| `writing_model.dart` | Core article structure |
| `writing_block.dart` | Content block types |
| `writing_layout.dart` | Layout enum |
| `writings_data.dart` | Static article repository |
| `writing_details_screen.dart` | Layout selection logic |
| `standard_content_builder.dart` | Shared rendering utilities |
| `fade_slide_in.dart` | Reusable animation widget |

## Performance Considerations

- ✅ GridView.builder for efficient list rendering
- ✅ Lazy animations with delays
- ✅ No unnecessary rebuilds
- ✅ Proper use of const constructors
- ✅ Single responsibility principle

## Future Enhancements

Potential improvements:

1. **Search & Filter** - Full-text search on articles
2. **Categories** - Organize by topic
3. **Related Articles** - Show similar content
4. **Comments** - Community discussion
5. **Syntax Highlighting** - Code block support
6. **Table Support** - Data table blocks
7. **Video Blocks** - Embedded videos
8. **Analytics** - Track popular articles

## Maintenance

To maintain the feature:

1. **Adding Articles:** Edit `writings_data.dart`
2. **Styling Changes:** Update AppColors/AppTextStyles
3. **New Layouts:** Add to layouts/ folder and wire in `WritingDetailsScreen`
4. **New Block Types:** Add to enum and implement in relevant layouts

All changes are localized and don't require coordinating across multiple files.
