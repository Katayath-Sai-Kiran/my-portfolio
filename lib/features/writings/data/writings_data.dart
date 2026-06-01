import '../models/writing_block.dart';
import '../models/writing_layout.dart';
import '../models/writing_model.dart';

/// Static repository of all articles for the portfolio.
///
/// This data file is designed for ease of maintenance and extensibility.
/// To add a new article:
///
/// 1. Create a new [WritingModel] instance
/// 2. Choose the appropriate [WritingLayout]
/// 3. Define content as [WritingBlock] instances
/// 4. Add to the [writings] list
///
/// No UI code modifications needed—rendering is layout-driven.
///
/// Example:
/// ```dart
/// WritingModel(
///   id: 'my-article-id',
///   title: 'My Article Title',
///   subtitle: 'Subtitle here',
///   date: DateTime(2026, 5, 20),
///   readTime: '5 min read',
///   tags: ['tag1', 'tag2'],
///   layoutType: WritingLayout.standard,
///   blocks: [
///     WritingBlock(
///       type: WritingBlockType.heading,
///       content: 'Article heading',
///     ),
///     // ... more blocks
///   ],
/// )
/// ```
abstract final class WritingsData {
  static final List<WritingModel> writings = [
    // ─────────────────────────────────────────────────────────────────────────
    // ARTICLE: The AI Shift Nobody Is Talking About on pub.dev
    // A personal observation from a Flutter package maintainer
    // ─────────────────────────────────────────────────────────────────────────
    WritingModel(
      id: 'ai-package-discovery',
      title: 'The AI Shift Nobody Is Talking About on pub.dev',
      subtitle:
          'A Flutter package maintainer\'s perspective on how AI is changing package discovery',
      date: DateTime.utc(2026, 5, 28),
      readTime: '8 min read',
      tags: ['Flutter', 'AI', 'pub.dev', 'Open Source', 'Package Development'],
      layoutType: WritingLayout.insights,
      blocks: [
        // SECTION 1: Personal Story
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'The Story',
          headingLevel: 1,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'Over the last few years, I\'ve published multiple Flutter packages on pub.dev. Like many package maintainers, I assumed package discovery was straightforward. Developers needed functionality, searched pub.dev, found a package, and installed it. A simple workflow.',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'Recently, I noticed something changing. Not in download numbers. Not in ratings. In my own behavior.',
        ),

        // SECTION 2: The Shift
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'A Year of Behavior Change',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'A year ago, if I needed a utility, I would search pub.dev. Compare packages, read READMEs, check the maintainer\'s reputation. Today? I often ask Claude or Copilot first.',
        ),
        WritingBlock(
          type: WritingBlockType.bulletList,
          content: 'Recent examples from my own work:',
          listItems: [
            'Needed a relative time formatter ("2 minutes ago") → asked Claude',
            'Built a custom "Read More" widget → generated and pasted',
            'Wanted a string extension for capitalization → AI output',
            'Text highlighting logic → same approach',
          ],
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'I didn\'t consciously decide to stop searching pub.dev. It just happened. The friction of asking AI is lower than the friction of discovering, comparing, and integrating a package.',
        ),

        // SECTION 3: The Question
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'The Central Question',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'If developers are increasingly asking AI for solutions, what happens to package discovery?',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'I don\'t have an answer yet. But I can\'t stop thinking about it.',
        ),

        // SECTION 4: Before vs Today
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'The Two Paths',
          headingLevel: 2,
        ),
        WritingBlock(type: WritingBlockType.paragraph, content: 'Before AI:'),
        WritingBlock(
          type: WritingBlockType.diagram,
          content: 'The traditional package discovery workflow',
          metadata: {
            'flowSteps': [
              'Need functionality',
              'Search pub.dev',
              'Compare packages',
              'Install dependency',
            ],
          },
        ),
        WritingBlock(type: WritingBlockType.paragraph, content: 'Today:'),
        WritingBlock(
          type: WritingBlockType.diagram,
          content: 'The modern AI-assisted workflow',
          metadata: {
            'flowSteps': [
              'Need functionality',
              'Ask Claude / Copilot',
              'Paste generated code',
              'Done',
            ],
          },
        ),

        // SECTION 5: The Hidden Consequence
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'The Hidden Consequence',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'Here\'s what I think matters: the demand for functionality still exists. The need hasn\'t gone away. But the package is no longer the thing being discovered.',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content: 'Before: Need → Package → Dependency',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content: 'Today: Need → AI → Code',
        ),
        WritingBlock(
          type: WritingBlockType.takeaway,
          content:
              'The demand for functionality may still exist, but the package is no longer the thing being discovered.',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,

          content:
              'That shift feels significant. Not catastrophic. Just... different.',
        ),

        // SECTION 6: Which Packages Are Most Affected?
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'Vulnerability Varies',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'Not all packages are equally affected. Some are resilient. Others are exposed.',
        ),
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'High Risk:',
          headingLevel: 3,
        ),
        WritingBlock(
          type: WritingBlockType.bulletList,
          content: '',
          listItems: [
            'String utilities (trim, split, format)',
            'Date helpers (relative time, parsing)',
            'Small widgets (read more, badges)',
            'Extensions (capitalize, reverse)',
          ],
        ),
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'Lower Risk:',
          headingLevel: 3,
        ),
        WritingBlock(
          type: WritingBlockType.bulletList,
          content: '',
          listItems: [
            'Firebase integration',
            'Payment processing',
            'Maps and geolocation',
            'Native integrations',
            'Complex video playback',
          ],
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'The pattern is clear: simple utilities are easier for AI to generate. Complex integrations and battle-tested solutions remain valuable because they abstract complexity and handle edge cases.',
        ),

        // SECTION 7: The Uncomfortable Question
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'The Uncomfortable Question',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.quote,
          content:
              'If an AI can generate a package in one prompt, should it have been a package at all?',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'I\'m not answering that. I\'m asking it. And I think it\'s worth discussing.',
        ),

        // SECTION 8: Challenge My Own Argument
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'But Here\'s the Thing',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'AI is not replacing every package. Developers still rely on mature, battle-tested solutions. We trust Firebase because it handles authentication, real-time databases, and analytics—complexity that AI can\'t reasonably generate and maintain.',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'Payment processing packages exist because integrating Stripe or PayPal is complex. Video playback packages exist because native integration is fragile. Maps packages exist because location data and platform differences are real problems.',
        ),
        WritingBlock(
          type: WritingBlockType.takeaway,
          content:
              'Trust, maintenance, testing, and ecosystem support still matter. AI is not the answer to everything.',
        ),

        // SECTION 9: Reflection
        WritingBlock(
          type: WritingBlockType.heading,
          content: 'Reflection',
          headingLevel: 2,
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'I\'m not convinced AI is killing pub.dev. But I do think it is changing how developers discover solutions. As both a Flutter developer and package maintainer, that feels like an important shift.',
        ),
        WritingBlock(
          type: WritingBlockType.paragraph,
          content:
              'If discovery changes, package development may change too. We might see fewer trivial utility packages and more focus on complex, integrated solutions. Or we might see packaging strategies evolve in ways we haven\'t anticipated.',
        ),
        WritingBlock(
          type: WritingBlockType.quote,
          content:
              'The real question is whether package maintainers are paying attention.',
        ),
      ],
    ),
  ];
}
