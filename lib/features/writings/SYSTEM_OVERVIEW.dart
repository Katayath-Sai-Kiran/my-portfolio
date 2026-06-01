/// ────────────────────────────────────────────────────────────────────────────
/// WRITINGS FEATURE: COMPLETE SYSTEM OVERVIEW
/// ────────────────────────────────────────────────────────────────────────────
///
/// This document explains how all pieces work together to create a dynamic,
/// layout-agnostic article system.
///
/// ────────────────────────────────────────────────────────────────────────────
/// 1. DATA FLOW
/// ────────────────────────────────────────────────────────────────────────────
///
/// Article Definition (WritingsData)
///     ↓
/// WritingModel with blocks and layout
///     ↓
/// WritingSection displays grid of cards
///     ↓
/// User clicks card
///     ↓
/// WritingDetailsScreen receives WritingModel
///     ↓
/// Switch on layoutType
///     ↓
/// Correct Layout renders blocks
///     ↓
/// Beautiful article display
///
/// ────────────────────────────────────────────────────────────────────────────
/// 2. KEY INSIGHT: LAYOUT-AGNOSTIC CONTENT
/// ────────────────────────────────────────────────────────────────────────────
///
/// The same WritingBlock can be rendered differently by different layouts:
///
/// WritingBlock (heading)
///     ├─ StandardLayout → Formatted as h1/h2/h3 heading
///     ├─ TimelineLayout → Used to create timeline event
///     ├─ DiagramLayout → Skipped (diagrams use metadata)
///     └─ InsightsLayout → Formatted as h1/h2/h3 heading
///
/// This means:
/// - Content is defined once
/// - Rendering is layout-specific
/// - Adding new layouts doesn't require changing data
///
/// ────────────────────────────────────────────────────────────────────────────
/// 3. ARTICLE LIFECYCLE
/// ────────────────────────────────────────────────────────────────────────────
///
/// Step 1: DEFINITION (WritingsData)
///   Write article as WritingModel with blocks
///   Choose layoutType
///   Add to writings list
///
/// Step 2: DISCOVERY (WritingSection)
///   WritingGrid displays all articles as cards
///   Cards show title, subtitle, tags, read time, metadata
///   Cards are fully responsive (3/2/1 columns)
///
/// Step 3: SELECTION (User Interaction)
///   User clicks card
///   WritingModel is passed to WritingDetailsScreen
///
/// Step 4: ROUTING (WritingDetailsScreen)
///   Screen receives WritingModel
///   Switches on article.layoutType
///   Instantiates correct layout widget
///
/// Step 5: RENDERING (Layout Widget)
///   Layout iterates through blocks
///   Renders each block according to its type
///   Uses shared utilities (StandardContentBuilder) where appropriate
///
/// Step 6: DISPLAY
///   Article displays with proper typography
///   Animations fade in smoothly
///   Responsive layout adapts to screen size
///
/// ────────────────────────────────────────────────────────────────────────────
/// 4. CONTENT COMPOSITION
/// ────────────────────────────────────────────────────────────────────────────
///
/// Every article is a list of WritingBlocks:
///
/// WritingBlock = {
///   type: WritingBlockType enum
///   content: primary text
///   listItems?: list of items (for bulletList)
///   imageUrl?: URL (for image/diagram)
///   headingLevel?: 1-3 (for heading)
///   caption?: text (for image)
///   metadata?: custom data (for extensibility)
/// }
///
/// Types available:
/// - heading (with level 1-3)
/// - paragraph
/// - bulletList (with items)
/// - quote
/// - image (with caption)
/// - diagram (with metadata)
/// - takeaway
///
/// ────────────────────────────────────────────────────────────────────────────
/// 5. LAYOUT STRATEGIES
/// ────────────────────────────────────────────────────────────────────────────
///
/// STANDARD LAYOUT
///   Purpose: Traditional blog post
///   Best for: Technical articles, tutorials, documentation
///   Handles: heading, paragraph, bulletList, quote, image
///   Ignores: diagram, takeaway
///   Flow: Linear, sequential content
///
/// TIMELINE LAYOUT
///   Purpose: Chronological progression
///   Best for: Evolution stories, journeys, histories
///   Handles: Extracts events from heading + paragraph pairs
///   Creates: Visual timeline with connected nodes
///   Ignores: Other block types
///
/// DIAGRAM LAYOUT
///   Purpose: Visual flows and process diagrams
///   Best for: Architecture, workflows, system explanations
///   Handles: Diagram blocks with flowSteps metadata
///   Creates: Connected node visualization
///   Ignores: Other block types
///
/// INSIGHTS LAYOUT
///   Purpose: Key learnings and takeaways
///   Best for: Lessons learned, best practices, case studies
///   Handles: heading, paragraph, bulletList, quote, image, takeaway
///   Emphasizes: Takeaway cards and quotes
///
/// ────────────────────────────────────────────────────────────────────────────
/// 6. RENDERING EXAMPLE: STANDARD LAYOUT
/// ────────────────────────────────────────────────────────────────────────────
///
/// Given this article:
///
/// WritingModel(
///   blocks: [
///     WritingBlock(heading: "My Title", level: 1),
///     WritingBlock(paragraph: "Introduction..."),
///     WritingBlock(bulletList: ["Item 1", "Item 2"]),
///     WritingBlock(quote: "Important insight"),
///   ]
/// )
///
/// StandardLayout renders:
///
/// 1. Heading block
///    └─ FadeSlideIn animation
///       └─ Text with displayMedium style
///
/// 2. Paragraph block
///    └─ FadeSlideIn animation
///       └─ Text with bodyLarge style
///
/// 3. BulletList block
///    └─ FadeSlideIn animation
///       └─ Column of bullet items
///
/// 4. Quote block
///    └─ FadeSlideIn animation
///       └─ QuoteBlock widget (with accent border)
///
/// ────────────────────────────────────────────────────────────────────────────
/// 7. RENDERING EXAMPLE: TIMELINE LAYOUT
/// ────────────────────────────────────────────────────────────────────────────
///
/// Given article with timeline layout and blocks:
///
/// WritingBlock(heading: "2024: Launch Year")
/// WritingBlock(paragraph: "We launched the product...")
/// WritingBlock(heading: "2025: Scale Year")
/// WritingBlock(paragraph: "Growth accelerated...")
///
/// TimelineLayout renders:
///
/// 1. Pairs heading + paragraph into timeline events
/// 2. Extracts event title: "2024: Launch Year"
/// 3. Extracts event description: "We launched..."
/// 4. Creates TimelineItem widget for each pair
/// 5. TimelineItem includes:
///    - Circular node indicator
///    - Connected vertical line
///    - Event content
///    - Staggered animations
///
/// Visual output:
/// ● Event 1
/// │
/// ● Event 2
/// │
/// ● Event 3
///
/// ────────────────────────────────────────────────────────────────────────────
/// 8. RENDERING EXAMPLE: DIAGRAM LAYOUT
/// ────────────────────────────────────────────────────────────────────────────
///
/// Given article with diagram layout and block:
///
/// WritingBlock(
///   type: WritingBlockType.diagram,
///   metadata: {
///     'flowSteps': [
///       'Step 1: Identify',
///       'Step 2: Design',
///       'Step 3: Implement',
///       'Step 4: Test',
///     ]
///   }
/// )
///
/// DiagramLayout renders:
///
/// 1. Extracts flowSteps from metadata
/// 2. Creates DiagramNode for each step
/// 3. DiagramNode includes:
///    - Box with label
///    - Connection line to next (if not last)
///    - Hover effects
///    - Staggered animations
///
/// Visual output:
///
/// ┌─────────────┐
/// │   Step 1    │
/// └─────────────┘
///       ↓
/// ┌─────────────┐
/// │   Step 2    │
/// └─────────────┘
///       ↓
/// ┌─────────────┐
/// │   Step 3    │
/// └─────────────┘
///
/// ────────────────────────────────────────────────────────────────────────────
/// 9. RENDERING EXAMPLE: INSIGHTS LAYOUT
/// ────────────────────────────────────────────────────────────────────────────
///
/// Given article with insights layout:
///
/// WritingBlock(heading: "Key Lesson")
/// WritingBlock(paragraph: "The insight...")
/// WritingBlock(takeaway: "Remember this")
/// WritingBlock(quote: "Wise saying")
///
/// InsightsLayout renders:
///
/// 1. Heading → Standard heading style
/// 2. Paragraph → Standard paragraph style
/// 3. Takeaway → KeyTakeawayCard widget (highlighted)
/// 4. Quote → QuoteBlock widget (with accent)
///
/// Visual effect:
/// - Normal content areas
/// - Highlighted insight cards (orange accent)
/// - Emphasized quotes (italic, large)
/// - Professional spacing between sections
///
/// ────────────────────────────────────────────────────────────────────────────
/// 10. EXTENSIBILITY PATTERNS
/// ────────────────────────────────────────────────────────────────────────────
///
/// ADDING A NEW BLOCK TYPE:
///   1. Add to WritingBlockType enum
///   2. Add handling in relevant layouts
///   3. Use in articles immediately
///   4. Other layouts ignore it automatically
///
/// ADDING A NEW LAYOUT:
///   1. Create layout widget in layouts/ folder
///   2. Add to WritingLayout enum
///   3. Add case to WritingDetailsScreen._buildLayout()
///   4. Use in articles by setting layoutType
///
/// ADDING A NEW ARTICLE:
///   1. Edit writings_data.dart
///   2. Create WritingModel with blocks
///   3. Choose existing layout type
///   4. Deploy
///   5. No other code changes needed
///
/// ────────────────────────────────────────────────────────────────────────────
/// 11. ANIMATION SYSTEM
/// ────────────────────────────────────────────────────────────────────────────
///
/// All content uses FadeSlideIn widget:
///
/// FadeSlideIn(
///   delay: Duration(milliseconds: 50 * index),
///   duration: Duration(milliseconds: 500),
///   child: widget,
/// )
///
/// Creates:
/// - Fade in: 0 → 1 opacity
/// - Slide in: (-5%, 0) → (0, 0) offset
/// - Staggered delays: each block delayed by 50ms
/// - Smooth easing: easeOut curve
///
/// Result: Professional entrance animation without external packages
///
/// ────────────────────────────────────────────────────────────────────────────
/// 12. RESPONSIVE BEHAVIOR
/// ────────────────────────────────────────────────────────────────────────────
///
/// HOMEPAGE GRID:
///   Desktop (≥ 1024px): 3 columns
///   Tablet (600-1023px): 2 columns
///   Mobile (< 600px): 1 column
///
/// ARTICLE DETAILS:
///   All devices: max-width 900px
///   Horizontal padding: adapts with screen size
///   Typography: consistent across all sizes
///   Spacing: maintains visual hierarchy
///
/// ────────────────────────────────────────────────────────────────────────────
/// 13. STYLING CONSISTENCY
/// ────────────────────────────────────────────────────────────────────────────
///
/// All styling uses portfolio theme:
///
/// Colors:
///   - Primary: AppColors.primary (#7F8C8D)
///   - Accent: AppColors.accentSecondary (#FF9800 orange)
///   - Text: AppColors.textPrimary, textSecondary, textMuted
///   - Background: AppColors.backgroundDark, backgroundCard
///
/// Typography:
///   - Font: Google Fonts Inter
///   - Headlines: displayMedium, headlineMedium, titleLarge
///   - Body: bodyLarge, bodyMedium
///   - Code: mono (Fira Code)
///
/// Spacing:
///   - 8px base unit (spacingSm, spacingMd, spacingLg, etc.)
///   - Section padding: 80px vertical, 120px horizontal (desktop)
///   - Content width: max 1200px container
///
/// ────────────────────────────────────────────────────────────────────────────
/// 14. CURRENT STATE
/// ────────────────────────────────────────────────────────────────────────────
///
/// Implemented:
/// ✓ All models (WritingModel, WritingBlock, WritingLayout)
/// ✓ All layouts (Standard, Timeline, Diagram, Insights)
/// ✓ All widgets (card, grid, details, animations, content blocks)
/// ✓ One personal insights article (AI package discovery)
/// ✓ Homepage integration
/// ✓ Responsive design
/// ✓ Professional animations
/// ✓ Complete documentation
///
/// Not Implemented (optional future enhancements):
/// - Search functionality
/// - Article categories
/// - Comments
/// - Code syntax highlighting
/// - Video embeds
/// - Analytics
///
/// ────────────────────────────────────────────────────────────────────────────
