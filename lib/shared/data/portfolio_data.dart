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
  static const List<OpenSourcePackage> packages = [
    OpenSourcePackage(
      name: 'dual_tone_text_codespark',
      description:
          'Advanced dual-tone and split-color text rendering utilities with '
          'multiline rendering support and custom visual effects.',
      tags: ['CustomPainter', 'ShaderMask', 'Text Rendering'],
      pubUrl: 'https://pub.dev/packages/dual_tone_text_codespark',
      githubUrl: 'https://github.com/saikirankatayath/dual_tone_text_codespark',
    ),
    OpenSourcePackage(
      name: 'rich_highlight',
      description:
          'Reusable inline text highlighting utilities using TextSpan-based '
          'rendering systems.',
      tags: ['TextSpan', 'Highlight', 'Text'],
      pubUrl: 'https://pub.dev/packages/rich_highlight',
      githubUrl: 'https://github.com/saikirankatayath/rich_highlight',
    ),
    OpenSourcePackage(
      name: 'read_more_codespark',
      description:
          'Expandable text system with animations and customizable read-more '
          'behavior.',
      tags: ['Animation', 'Text', 'UX'],
      pubUrl: 'https://pub.dev/packages/read_more_codespark',
      githubUrl: 'https://github.com/saikirankatayath/read_more_codespark',
    ),
    OpenSourcePackage(
      name: 'text_comparison_score_codespark',
      description:
          'Text similarity utility package supporting multiple comparison '
          'algorithms and scoring systems.',
      tags: ['Dart', 'Algorithms', 'NLP'],
      pubUrl: 'https://pub.dev/packages/text_comparison_score_codespark',
      githubUrl:
          'https://github.com/saikirankatayath/text_comparison_score_codespark',
    ),
    OpenSourcePackage(
      name: 'icon_to_text_extension_codespark',
      description:
          'Extension utilities for converting Flutter icons into reusable text '
          'widgets and spans.',
      tags: ['Icons', 'TextSpan', 'Extensions'],
      pubUrl: 'https://pub.dev/packages/icon_to_text_extension_codespark',
      githubUrl:
          'https://github.com/saikirankatayath/icon_to_text_extension_codespark',
    ),
    OpenSourcePackage(
      name: 'advanced_text_input_formatters_codespark',
      description:
          'Reusable advanced text input formatting utilities for Flutter '
          'applications.',
      tags: ['Forms', 'Input', 'Formatter'],
      pubUrl:
          'https://pub.dev/packages/advanced_text_input_formatters_codespark',
      githubUrl:
          'https://github.com/saikirankatayath/advanced_text_input_formatters_codespark',
    ),
    OpenSourcePackage(
      name: 'animated_dropdown_search_codespark',
      description:
          'Animated searchable dropdown system with customizable interaction '
          'behavior.',
      tags: ['Animation', 'Dropdown', 'Search'],
      pubUrl: 'https://pub.dev/packages/animated_dropdown_search_codespark',
      githubUrl:
          'https://github.com/saikirankatayath/animated_dropdown_search_codespark',
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
