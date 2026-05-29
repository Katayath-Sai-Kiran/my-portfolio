import '../models/portfolio_models.dart';

abstract final class PortfolioData {
  // ── Skills ──────────────────────────────────────────────────────────────
  static const List<SkillCategory> skills = [
    SkillCategory(
      label: 'Flutter Rendering',
      skills: [
        'CustomPainter',
        'ShaderMask',
        'TextSpan',
        'Animation systems',
        'Rendering optimization',
      ],
    ),
    SkillCategory(
      label: 'SDK & Package Development',
      skills: [
        'Reusable package architecture',
        'API design',
        'pub.dev publishing',
        'Utility package systems',
      ],
    ),
    SkillCategory(
      label: 'Native Platform Integration',
      skills: [
        'Kotlin',
        'Platform channels',
        'Android integrations',
        'ExoPlayer',
      ],
    ),
    SkillCategory(
      label: 'Backend & Infrastructure',
      skills: [
        'Firebase',
        'Node.js',
        'Express',
        'MongoDB',
        'Cloud Storage',
        'Realtime systems',
      ],
    ),
    SkillCategory(
      label: 'Performance & Architecture',
      skills: [
        'Scalable Flutter architecture',
        'Responsive systems',
        'Rebuild optimization',
        'Async handling',
        'Upload recovery systems',
      ],
    ),
  ];

  // ── Engineering Work ─────────────────────────────────────────────────────
  static const List<EngineeringProject> engineeringProjects = [
    EngineeringProject(
      title: 'Fastpix Upload SDK',
      description:
          'Designed resumable chunk upload infrastructure using signed URLs, '
          'upload recovery, and internet connectivity monitoring for reliable '
          'large video uploads.',
      tags: [
        'Flutter',
        'Firebase',
        'Signed URLs',
        'Connectivity',
        'Resumable Upload',
      ],
    ),
    EngineeringProject(
      title: 'ExoPlayer Flutter Integration',
      description:
          'Integrated native ExoPlayer into Flutter with custom UI controls, '
          'platform communication, and embedded responsive layouts.',
      tags: ['Flutter', 'Kotlin', 'ExoPlayer', 'Platform Channels', 'Android'],
    ),
    EngineeringProject(
      title: 'Dual Tone Rendering System',
      description:
          'Built advanced dual-tone text rendering systems using CustomPainter '
          'and ShaderMask techniques for multiline rendering consistency.',
      tags: ['Flutter', 'CustomPainter', 'ShaderMask', 'Text Rendering'],
    ),
    EngineeringProject(
      title: 'LMS Platform',
      description:
          'Developed scalable learning platform architecture with dashboard '
          'systems, academy modules, and modular Flutter structure.',
      tags: ['Flutter', 'Firebase', 'Scalable Architecture', 'Modular Design'],
    ),
  ];

  // ── Engineering Challenges ────────────────────────────────────────────────
  static const List<ChallengeModel> challenges = [
    ChallengeModel(
      problem: 'Multiline ShaderMask rendering inconsistencies',
      solution:
          'Implemented CustomPainter-based rendering strategies for accurate '
          'multiline dual-tone rendering.',
      technologies: ['Flutter', 'CustomPainter', 'ShaderMask'],
    ),
    ChallengeModel(
      problem: 'Large video upload reliability on unstable internet',
      solution:
          'Designed resumable chunk upload infrastructure with retry handling '
          'and connectivity-aware upload recovery.',
      technologies: ['Flutter', 'Firebase', 'Signed URLs'],
    ),
    ChallengeModel(
      problem: 'Embedding native media players inside Flutter layouts',
      solution:
          'Integrated ExoPlayer with custom platform communication and '
          'responsive embedded UI.',
      technologies: ['Flutter', 'Kotlin', 'ExoPlayer'],
    ),
    ChallengeModel(
      problem: 'Advanced text similarity calculations',
      solution:
          'Implemented multiple comparison algorithms including Levenshtein '
          'distance and Jaro-Winkler matching.',
      technologies: ['Dart', 'Algorithms'],
    ),
  ];

  // ── Open Source Packages ─────────────────────────────────────────────────
  static List<OpenSourcePackage> packages = [
    OpenSourcePackage(
      version: '0.0.6',
      publishedOn: DateTime.parse('2025-05-26'),
      name: 'text_comparison_score_codespark',
      downloads: 662,
      description:
          'The TextComparisonScore package is a straightforward and efficient tool for comparing two strings and calculating their similarity score using the Levenshtein distance algorithm.',
      tags: ['textcomparison', 'compare', 'score', 'levenshteindistance'],
      pubUrl: 'https://pub.dev/packages/text_comparison_score_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/text_comparison_score_codespark',
    ),

    OpenSourcePackage(
      downloads: 164,
      name: 'animated_dropdown_search_codespark',
      description:
          'Empower your app with a sophisticated dropdown widget, featuring search and highlighting.',
      tags: [
        'dropdownmenu',
        'multiselectdropdown',
        'search',
        'highlighting',
        'animateddropdown',
      ],
      pubUrl: 'https://pub.dev/packages/animated_dropdown_search_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark',
    ),
    OpenSourcePackage(
      downloads: 137,
      name: 'advanced_text_input_formatters_codespark',
      description:
          'A Flutter package with advanced custom TextInputFormatters—simulate typing, block clipboard, allow only palindromes, enforce naming conventions and more.',
      tags: [
        'textinput',
        'inputformatter',
        'validation',
        'typing',
        'formatting',
      ],
      pubUrl:
          'https://pub.dev/packages/advanced_text_input_formatters_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/advanced_text_input_formatters_codespark',
    ),
    OpenSourcePackage(
      downloads: 0,
      name: 'context_extensions_codespark',
      description:
          'A lightweight Flutter package that provides powerful and convenient BuildContext extensions to reduce boilerplate and improve developer productivity.',
      tags: [
        'buildcontext',
        'extensions',
        'flutter',
        'productivity',
        'boilerplate',
      ],
      pubUrl: 'https://pub.dev/packages/context_extensions_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/context_extensions_codespark',
    ),
    OpenSourcePackage(
      name: 'icon_to_text_extension_codespark',
      downloads: 94,
      description:
          'Flutter extension to render any IconData (Material or Cupertino) as Text or TextSpan for inline icons in rich text and custom layouts.',
      tags: [
        'icondata',
        'icons-to-text',
        'material-icons',
        'inline-icons',
        'flutter-extensions',
      ],
      pubUrl: 'https://pub.dev/packages/icon_to_text_extension_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark',
    ),
    OpenSourcePackage(
      name: 'rich_highlight_text_codespark',
      downloads: 76,

      description:
          'Adds extension methods to highlight substrings in Text or String using Text.rich and custom styles. Simple inline highlighting with minimal code.',
      tags: ['text', 'highlight', 'richtext', 'inline-style', 'textspan'],
      pubUrl: 'https://pub.dev/packages/rich_highlight_text_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/rich_highlight_text_codespark',
    ),
    OpenSourcePackage(
      downloads: 44,
      name: 'read_more_codespark',
      description:
          'Tired of truncated text? read_more_codespark offers a simple and customizable solution for displaying expandable text in your Flutter projects.',
      tags: [],
      pubUrl: 'https://pub.dev/packages/read_more_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/read_more_codespark',
    ),
    OpenSourcePackage(
      downloads: 41,
      name: 'dual_tone_text_codespark',
      description:
          'A Flutter package to render text with sharp dual-tone color splits '
          '—vertical, horizontal, or radial. Great for stylish titles and headers.',
      tags: ['text', 'shader', 'custom-text', 'typography', 'dual-tone'],
      pubUrl: 'https://pub.dev/packages/dual_tone_text_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/dual_tone_text_codespark',
    ),
    OpenSourcePackage(
      downloads: 41,
      name: 'curved_text_codespark',
      description:
          'Render text along circular, spiral, wave, elliptical, or custom paths with full animation, interactivity, and styling.  A modern curved text widget for Flutter.',
      tags: [
        'curved-text',
        'path-text',
        'text-effects',
        'text-animation',
        'interactive-text',
      ],
      pubUrl: 'https://pub.dev/packages/curved_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/curved_text_codespark',
    ),
    OpenSourcePackage(
      downloads: 19,
      name: 'text_highlight_codespark',
      description:
          'A Flutter package for highlighting text within a string, supporting single, multiple, and regex-based queries.',
      tags: [],
      pubUrl: 'https://pub.dev/packages/text_highlight_codespark',
      githubUrl:
          'https://github.com/Katayath-Sai-Kiran/text_highlight_codespark',
    ),
  ];

  // ── Experience ───────────────────────────────────────────────────────────
  static const List<ExperienceModel> experience = [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Wielabs',
      duration: '2012 – 2025',
      description:
          'Built and maintained a reusable Flutter package ecosystem on pub.dev, '
          'focused on rendering utilities, text systems, and developer tooling.',
      bullets: [
        'Integrated a native video player with support for the MPEG-DASH protocol, enabling smooth streaming and adaptive playback.',
        'Implemented real-time chat functionality using WebSockets, ensuring seamless and responsive user communication.',
        'Built a custom camera module in Flutter to capture high-resolution photos, ensuring native-level performance and filter-free output.',
        'Integrated In-App Purchases (IAP) for both consumables and non-consumables, with robust, state-safe purchase flow and error handling.',
        'Managed end-to-end deployment of the app on both the Apple App Store and Google Play Store, ensuring compliance with platform guidelines, proper code signing, and smooth release processes.',
        'Applied secure authentication & authorization using JWT and session-based mechanisms.',
        'Integrated Bubble.io as the backend platform, enabling rapid no-code/low-code development for business logic and database management.',
        'Built and maintained reusable Flutter package ecosystem',
      ],
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        "Deployment",
        'Xcode',
        'Node.js',
        'REST API',
        'AWS',
        'MongoDB',
        'Express',
        'Git',
        'GitHub Actions',
      ],
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Enspirit',
      duration: '2025 – Present',
      description:
          'Architected production Flutter applications with backend integrations, '
          'advanced animations, and scalable mobile UI systems.',
      bullets: [
        'Architected production Flutter applications',
        'Clean Architecture with Repository/UseCase pattern',
        'Multi-game architecture (Feature driven development with 5 games: Moundball, HRD, TDD, Golf, Trivia)',
        'Real-time multiplayer with Socket.io',
        'Multi-platform deployment (3 platforms, Web, IOS, Android)',
        'Offline-first with Hive caching',
        'Production monitoring (Sentry, Smartlook, Firebase)',
        'Integrated backend and realtime systems',
        'Built scalable mobile UI architectures',
        'Developed reusable component systems',
      ],
      technologies: [
        'Flutter',
        'Firebase',
        'Dart',
        'Sentry',
        'Smartlook',
        'SMLER',
        'OAuth',
        'Sendbird (Chat)',
        'Deeplinks',
        'Webview',
      ],
    ),
  ];

  // ── Technical Writing ────────────────────────────────────────────────────
  static const List<WritingArticle> articles = [
    WritingArticle(
      title: 'Handling Multiline Gradient Rendering in Flutter',
      summary:
          'Deep-dive into the rendering limitations of ShaderMask and how CustomPainter '
          'resolves multiline gradient consistency.',
    ),
    WritingArticle(
      title: 'Building Resumable Upload Systems in Flutter',
      summary:
          'Architecture and implementation of chunk-based resumable upload '
          'infrastructure with connectivity-aware recovery.',
    ),
    WritingArticle(
      title: 'Designing Reusable Flutter Utility Packages',
      summary:
          'Principles for API design, versioning strategy, and pub.dev publishing '
          'workflows for open-source Flutter packages.',
    ),
    WritingArticle(
      title: 'Flutter Rendering Lessons with CustomPainter',
      summary:
          'Practical rendering techniques, coordinate systems, and performance '
          'considerations when building with CustomPainter.',
    ),
    WritingArticle(
      title: 'Scaling Open Source Flutter Package Ecosystems',
      summary:
          'Strategies for maintaining multiple pub.dev packages, managing '
          'breaking changes, and building a coherent package suite.',
    ),
  ];
}
