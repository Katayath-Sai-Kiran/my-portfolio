import '../models/portfolio_models.dart';

abstract final class PortfolioData {
  // ── Skills (from resume) ─────────────────────────────────────────────────
  static const List<SkillCategory> skills = [
    SkillCategory(
      label: 'Flutter & Dart',
      skills: ['Flutter', 'Dart', 'Widget architecture', 'Custom rendering', 'Animations'],
    ),
    SkillCategory(
      label: 'State & Architecture',
      skills: ['Provider', 'GetIt', 'Clean Architecture', 'Repository pattern', 'UseCase pattern'],
    ),
    SkillCategory(
      label: 'Native & Platform',
      skills: ['Platform channels', 'Kotlin', 'ExoPlayer', 'Camera module', 'IAP'],
    ),
    SkillCategory(
      label: 'Backend & Cloud',
      skills: ['Firebase', 'Node.js', 'MongoDB', 'Express', 'REST API', 'JWT', 'AWS', 'Bubble.io'],
    ),
    SkillCategory(
      label: 'Real-time & Infra',
      skills: ['Socket.io', 'Sendbird', 'WebSockets', 'Hive', 'Sentry', 'Smartlook', 'CI/CD'],
    ),
    SkillCategory(
      label: 'Tooling',
      skills: ['Git', 'GitHub Actions', 'Postman', 'Figma', 'Xcode', 'App Store Connect', 'Play Console'],
    ),
  ];

  // ── App Projects (from resume) ────────────────────────────────────────────
  static const List<EngineeringProject> engineeringProjects = [
    EngineeringProject(
      title: 'Rally Nation',
      category: 'Sports',
      description:
          'Multi-platform sports gaming app with real-time multiplayer '
          'across 5 game modes. Built with clean architecture, offline-first '
          'storage, and production monitoring from day one.',
      bullets: [
        'Multi-game architecture: Moundball, HRD, TDD, Golf, Trivia',
        'Real-time multiplayer powered by Socket.io',
        'Clean Architecture with Repository + UseCase pattern',
        'Offline-first with Hive caching',
        'Production monitoring: Sentry, Smartlook, Firebase',
        'Multi-environment config + CI/CD pipeline',
      ],
      tags: ['Flutter', 'Socket.io', 'Hive', 'Provider', 'GetIt', 'Sentry', 'Firebase'],
    ),
    EngineeringProject(
      title: 'MoneyMinds',
      category: 'EdTech',
      description:
          'Cross-platform educational Flutter web app with native-grade '
          'video streaming and real-time communication features, '
          'optimized for performance across all screen sizes.',
      bullets: [
        'Native video player with MPEG-DASH adaptive streaming',
        'Real-time chat via WebSockets',
        'Cross-platform: Web, iOS, Android',
        'Performance: lazy loading, asset compression, state optimization',
      ],
      tags: ['Flutter', 'WebSockets', 'MPEG-DASH', 'Firebase'],
    ),
    EngineeringProject(
      title: 'Truth Catcher',
      category: 'NFT / Creator',
      description:
          'NFT creation platform with a custom camera module for '
          'high-resolution capture, Figma-driven animated UI, and '
          'full IAP integration across both app stores.',
      bullets: [
        'Custom camera module — native-level performance, filter-free',
        'Figma prototypes → animated Flutter UI',
        'IAP for consumables and non-consumables',
        'End-to-end App Store + Play Store deployment',
      ],
      tags: ['Flutter', 'IAP', 'Camera', 'Dart', 'App Store', 'Play Store'],
    ),
    EngineeringProject(
      title: 'NeurallyMed',
      category: 'EdTech',
      description:
          'Exam preparation platform with premium content gating via IAP, '
          'local caching to reduce API calls, and JWT-secured auth — '
          'responsive across all device sizes.',
      bullets: [
        'IAP for premium content unlocking',
        'Caching layer for offline content and reduced API calls',
        'Responsive UI from Figma designs',
        'JWT + session-based secure authentication',
      ],
      tags: ['Flutter', 'JWT', 'Firebase', 'IAP', 'REST API'],
    ),
    EngineeringProject(
      title: 'Aezo',
      category: 'B2B Platform',
      description:
          'Trade association platform backed by Bubble.io, with custom '
          'Flutter UI components and performance optimizations that kept '
          'load times low for complex data screens.',
      bullets: [
        'Bubble.io backend integration — rapid business logic iteration',
        'Custom branded UI components with animations',
        'Lazy loading, asset bundling, and caching for fast load',
      ],
      tags: ['Flutter', 'Bubble.io', 'REST API', 'Dart'],
    ),
  ];

  // ── SDK / Engineering Challenges ──────────────────────────────────────────
  static const List<ChallengeModel> challenges = [
    ChallengeModel(
      problem: 'Multiline ShaderMask rendering inconsistencies',
      solution:
          'Implemented CustomPainter-based rendering strategies for accurate '
          'multiline dual-tone rendering.',
      technologies: ['Flutter', 'CustomPainter', 'ShaderMask'],
    ),
    ChallengeModel(
      problem: 'Large video upload reliability on unstable networks',
      solution:
          'Designed resumable chunk upload infrastructure with retry handling '
          'and connectivity-aware upload recovery using signed URLs.',
      technologies: ['Flutter', 'Firebase', 'Signed URLs'],
    ),
    ChallengeModel(
      problem: 'Embedding native ExoPlayer inside Flutter layouts',
      solution:
          'Integrated ExoPlayer with custom platform channel communication '
          'and responsive embedded UI.',
      technologies: ['Flutter', 'Kotlin', 'ExoPlayer', 'Platform Channels'],
    ),
    ChallengeModel(
      problem: 'Advanced text similarity calculations',
      solution:
          'Implemented Levenshtein distance and Jaro-Winkler matching '
          'algorithms — packaged and published to pub.dev.',
      technologies: ['Dart', 'Algorithms'],
    ),
  ];

  // ── Open Source Packages ─────────────────────────────────────────────────
  static List<OpenSourcePackage> packages = [
    // ── On-Device AI set ────────────────────────────────────────────────────
    OpenSourcePackage(
      name: 'ai_core_codespark',
      category: PackageCategory.ai,
      status: PackageStatus.live,
      version: '0.1.1',
      publishedOn: DateTime.parse('2026-06-24'),
      tagline: 'On-device text embeddings for Flutter — offline, no API keys.',
      problem:
          'Bringing "AI" into a Flutter app meant a cloud API — keys, latency, '
          'per-call cost, and user data leaving the device. The on-device '
          'options were worse: download the model by hand, or bring your own '
          'vectors. There was no batteries-included local embedding engine.',
      description:
          'The local AI engine the codespark family is built on. It turns text '
          'into vectors entirely on-device using a quantized MiniLM ONNX model, '
          'with a WordPiece tokenizer, cosine similarity, and a vector store '
          'included — no OpenAI, Gemini, Ollama, or server required.',
      tags: ['embeddings', 'onnx', 'semantic-search', 'nlp', 'on-device'],
      pubUrl: 'https://pub.dev/packages/ai_core_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/ai_core_codespark',
      relatedPackages: ['semantic_search_codespark', 'smart_sort_codespark'],
      caseStudy: CaseStudy(
        summary:
            'The honest build log of getting real AI to run on a Flutter '
            'device — the decisions, the dead ends, the one genuine panic, and '
            'the pivots that turned a vague idea into a 160/160 package.',
        highlights: [
          '160 / 160 pub points',
          'Tokenizer verified byte-for-byte vs HuggingFace',
          'int8 ≈ fp32 at cosine 0.99',
          '~23 MB model, auto-downloaded & cached',
          'Verified end-to-end on a real device',
        ],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'Ship one engine, not a framework',
            body:
                'The original plan was a whole suite of AI packages. I stepped '
                'back and made the first real decision: prove ONE thing works '
                'end-to-end before building any framework. Validation beats '
                'architecture when you don\'t yet know that anyone wants it.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.setback,
            heading: 'Killing the "tiny bundled model" dream',
            body:
                'I wanted a small model baked right into the package. Reality '
                'check: the smallest genuinely useful transformer is about '
                '23 MB quantized — there is no 10 MB version. So I dropped '
                'bundling entirely and committed to downloading the model once, '
                'on first run.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'Download and verify — not bundle, not curl',
            body:
                'Two existing packages framed the choice: one bundles the model '
                '(bloating every app build), another makes you curl it into an '
                'assets folder by hand. I chose a third path — auto-download on '
                'first launch, verify with a SHA-256 checksum, then cache it. '
                'Lean binary, zero manual setup, and the URL stays overridable '
                'for air-gapped installs.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'The tokenizer was the actual project',
            body:
                'Everyone assumes the model is the hard part. It isn\'t — it\'s '
                'the easy 80%. The hard 20% is a pure-Dart WordPiece tokenizer '
                'that matches HuggingFace byte-for-byte: accent stripping, CJK '
                'spacing, punctuation rules. Get one subword wrong and every '
                'embedding is silently corrupted — no error, just quietly wrong '
                'results everywhere downstream.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.setback,
            heading: 'Letting the model tell the truth',
            body:
                'Before writing any UI, I probed the demo queries against the '
                'real model. "car" → "automobile" (0.87) and "doctor" → '
                '"physician" nailed it. But "flutter state management" → '
                '"riverpod" scored 0.11 — dead last, below random words. The '
                'model simply doesn\'t know niche jargon. So I cut that demo and '
                'kept the whole package honest about where semantic search '
                'actually works.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'The 0.14 cosine red herring',
            body:
                'The int8 model looked broken — its embeddings scored 0.14 '
                'against the reference when they should have been ~0.99. Hours '
                'of suspicion fell on the quantized model. The real culprit: a '
                'newer tokenizer release was silently emitting all-[UNK] tokens. '
                'Swap in the correct tokenizer and parity jumped to 0.99. The '
                'model had been fine the whole time.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'Byte-for-byte — including the weird stuff',
            body:
                'I built a parity harness that checks the Dart tokenizer '
                'against the reference across the full unicode long tail — '
                'accents, Japanese, Cyrillic, even an emoji collapsing to '
                '[UNK]. All 20 cases matched exactly. The riskiest part of the '
                'package was now proven, not hoped.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.setback,
            heading: 'The packages that "vanished"',
            body:
                'Mid-build, both package folders looked wiped — empty except a '
                'stray test file. I nearly rebuilt everything from scratch. '
                'They had simply been moved to another folder. Lesson learned '
                'the slightly-too-stressful way: check before you panic.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'It compiles — but does it actually run?',
            body:
                'Unit tests were green, but they can\'t load the native ONNX '
                'runtime, so the real inference path was still unproven. I built '
                'a small macOS app to run the actual model on a device — and '
                'immediately hit a silent failure: macOS sandboxes outbound '
                'network, so the download did nothing until I added the '
                'network-client entitlement.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'End-to-end, on a real device',
            body:
                'With the entitlement fixed, the real int8 model downloaded, ran '
                'through ONNX on a background isolate, and returned "doctor" → '
                '"physician" on an actual machine. The last unverified layer — '
                'Dart calling native ML — was finally green.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'Renamed one minute before midnight',
            body:
                'Right before publishing, I caught that the name broke my own '
                'brand — every other package uses a "_codespark" suffix, but '
                'this one led with it. pub.dev names are permanent once '
                'published, so I renamed it while I still could. The kind of '
                'small thing that is impossible to fix later.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: '160 / 160, and honest about its limits',
            body:
                'Published at a perfect 160/160 pub score, verified end-to-end '
                'on-device, and upfront about what it can\'t do. It\'s now the '
                'engine under a whole family of local-AI Flutter packages.',
          ),
        ],
      ),
    ),
    OpenSourcePackage(
      name: 'semantic_search_codespark',
      category: PackageCategory.ai,
      status: PackageStatus.comingSoon,
      tagline: 'Offline semantic search — match by meaning, not spelling.',
      problem:
          'Keyword and fuzzy search miss anything phrased differently. A user '
          'typing "I forgot my login details" should find "Reset your '
          'password" — but they share no words, so traditional search returns '
          'nothing.',
      description:
          'A tiny API over the on-device engine: rank a list of strings or '
          'objects by meaning. No API keys, no cloud — it finds "physician" '
          'when the user types "doctor".',
      tags: ['semantic-search', 'embeddings', 'search', 'nlp', 'on-device'],
      relatedPackages: [
        'ai_core_codespark',
        'smart_sort_codespark',
        'text_comparison_score_codespark',
      ],
      caseStudy: CaseStudy(
        summary:
            'Ready-made semantic search on top of ai_core_codespark — the '
            'developer-experience layer that turns the engine into a one-line '
            'search box.',
        highlights: [
          'Zero-word-overlap matches that fuzzy search cannot find',
          'Embed once, query many (cached index)',
          'Honest about limits — verified against the real model',
        ],
        sections: [
          CaseStudySection(
            heading: 'The idea',
            body:
                'Take the embedding engine and wrap it in the smallest possible '
                'API: pass a query and a list, get back results ranked by '
                'meaning. The whole product is the developer experience — the '
                'hard ML lives in ai_core_codespark.',
          ),
          CaseStudySection(
            heading: 'Validated honestly',
            body:
                'Before building, I probed the real model to see what it '
                'actually knows. General-language synonyms (car → automobile, '
                'doctor → physician) are strong; niche jargon (flutter state '
                'management → riverpod) is not. So the package is upfront about '
                'where semantic search shines and where it doesn\'t, instead of '
                'overpromising.',
          ),
        ],
      ),
    ),
    OpenSourcePackage(
      name: 'smart_sort_codespark',
      category: PackageCategory.ai,
      status: PackageStatus.comingSoon,
      tagline: 'Hybrid ranking — semantic meaning and fuzzy spelling, fused.',
      problem:
          'Semantic search nails meaning but misses exact tokens; fuzzy '
          'matching nails spelling but has no idea what words mean. Used alone, '
          'each is half a ranking engine.',
      description:
          'Fuses on-device semantic similarity with classic fuzzy matching '
          'using Reciprocal Rank Fusion, so word-level and meaning-level '
          'queries both rank well — the bridge between my fuzzy-matching and '
          'AI work.',
      tags: ['hybrid-search', 'ranking', 'fuzzy', 'semantic-search'],
      relatedPackages: [
        'ai_core_codespark',
        'semantic_search_codespark',
        'text_comparison_score_codespark',
      ],
      caseStudy: CaseStudy(
        summary:
            'The differentiator: combine the semantic engine with proven '
            'fuzzy-matching algorithms into a single ranking system.',
        highlights: [
          'Reciprocal Rank Fusion — not a naive weighted blend',
          'Builds on existing fuzzy-matching packages',
        ],
        sections: [
          CaseStudySection(
            heading: 'Why fuse them',
            body:
                'A fixed "0.7 × semantic + 0.3 × fuzzy" blend is a trap — the '
                'two scores live on different scales and distributions. The '
                'right approach is rank fusion (RRF), which combines the two '
                'rankings rather than their raw scores. This is where my '
                'existing fuzzy-matching work and the new AI engine finally '
                'meet.',
          ),
        ],
      ),
    ),
    OpenSourcePackage(
      name: 'intent_detector_codespark',
      category: PackageCategory.ai,
      status: PackageStatus.comingSoon,
      tagline: 'On-device intent classification, zero training.',
      problem:
          'Command bars, chat inputs, and voice features need to know what the '
          'user wants — but training and shipping a classifier is heavyweight, '
          'and cloud NLU means keys and latency.',
      description:
          'Few-shot intent detection on-device: define intents with a handful '
          'of example phrases and the engine matches input against them by '
          'meaning — no training step, no cloud.',
      tags: ['intent', 'classification', 'nlp', 'on-device'],
      relatedPackages: ['ai_core_codespark', 'semantic_search_codespark'],
      caseStudy: CaseStudy(
        summary:
            'Classify user intent locally by comparing an utterance against '
            'embedded prototype phrases — no model training required.',
        highlights: ['Few-shot, no training', 'Reuses the same embedding model'],
        sections: [
          CaseStudySection(
            heading: 'The approach',
            body:
                'Instead of fine-tuning a classifier, embed a few example '
                'phrases per intent and compare an incoming utterance against '
                'them with cosine similarity. Defining a new intent is just '
                'adding examples — no training pipeline, and it runs entirely '
                'on the same on-device model.',
          ),
        ],
      ),
    ),

    // ── Flutter Utilities set ───────────────────────────────────────────────
    OpenSourcePackage(
      version: '0.0.6',
      publishedOn: DateTime.parse('2025-05-26'),
      name: 'text_comparison_score_codespark',
      downloads: 712,
      tagline: 'Fuzzy string matching for Flutter apps.',
      problem:
          'Quiz apps need exact and fuzzy answer matching — Dart has no '
          'built-in string similarity algorithm. I was shipping a quiz feature '
          'and needed scores, not just booleans.',
      description:
          'Compare two strings and get a similarity score using Levenshtein '
          'distance. Built for fuzzy matching in quiz and search scenarios.',
      relatedPackages: ['text_highlight_codespark', 'rich_highlight_text_codespark'],
      tags: ['textcomparison', 'compare', 'score', 'levenshtein'],
      pubUrl: 'https://pub.dev/packages/text_comparison_score_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/text_comparison_score_codespark',
    ),
    OpenSourcePackage(
      downloads: 164,
      name: 'animated_dropdown_search_codespark',
      tagline: 'Searchable, animated dropdowns that scale.',
      problem:
          'Flutter\'s built-in DropdownButton collapses with 30+ items and '
          'offers no search. A client needed a searchable select over 200+ '
          'options — so I built one that actually works.',
      description:
          'Sophisticated dropdown with search, highlighting, and animation. '
          'Built when a client needed searchable selects across 200+ items.',
      relatedPackages: ['advanced_text_input_formatters_codespark'],
      tags: ['dropdown', 'search', 'animation', 'highlighting'],
      pubUrl: 'https://pub.dev/packages/animated_dropdown_search_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark',
    ),
    OpenSourcePackage(
      downloads: 137,
      name: 'advanced_text_input_formatters_codespark',
      tagline: 'A toolkit of reusable TextInputFormatters.',
      problem:
          'The same input validation patterns — typing simulation, clipboard '
          'blocking, palindrome enforcement — get rewritten on every project. '
          'I collected mine into a shareable library.',
      description:
          'Collection of advanced TextInputFormatters — typing simulation, '
          'clipboard blocking, palindrome enforcement, naming conventions and more.',
      relatedPackages: ['animated_dropdown_search_codespark', 'context_extensions_codespark'],
      tags: ['textinput', 'formatter', 'validation', 'typing'],
      pubUrl: 'https://pub.dev/packages/advanced_text_input_formatters_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/advanced_text_input_formatters_codespark',
    ),
    OpenSourcePackage(
      downloads: 23,
      name: 'context_extensions_codespark',
      tagline: 'BuildContext, made ergonomic.',
      problem:
          'Theme, size, navigator, media query, text styles — the same five '
          'BuildContext lookups written in every single project. I packaged '
          'them once so I\'d never write them again.',
      description:
          'BuildContext extensions that cut boilerplate. Wrote the same 5 '
          'lookups in every project — packaged them once.',
      relatedPackages: ['date_formatter_codespark', 'advanced_text_input_formatters_codespark'],
      tags: ['buildcontext', 'extensions', 'flutter', 'productivity'],
      pubUrl: 'https://pub.dev/packages/context_extensions_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/context_extensions_codespark',
    ),
    OpenSourcePackage(
      name: 'icon_to_text_extension_codespark',
      downloads: 94,
      tagline: 'IconData as inline text inside RichText.',
      problem:
          'Flutter\'s text engine cannot render icons inline. There is no '
          'native way to mix IconData with TextSpan in a RichText widget — '
          'I needed it for a label system and had to build the bridge.',
      description:
          'Render any IconData as Text or TextSpan for inline icons in rich '
          'text and custom layouts. Flutter has no native solution for this.',
      relatedPackages: ['rich_highlight_text_codespark', 'curved_text_codespark'],
      tags: ['icondata', 'inline-icons', 'rich-text', 'extensions'],
      pubUrl: 'https://pub.dev/packages/icon_to_text_extension_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark',
    ),
    OpenSourcePackage(
      name: 'internet_quality_codespark',
      downloads: 95,
      tagline: 'Real-time network quality monitoring.',
      problem:
          'Upload failures in production kept looking like code bugs. The '
          'real cause was poor network quality — something the app had no '
          'visibility into. I built this to surface that signal in real time.',
      description:
          'Measure and display real-time internet connection quality. '
          'Built while debugging upload failures caused by network quality, not code.',
      relatedPackages: [],
      tags: ['internet', 'connectivity', 'network', 'quality'],
      pubUrl: 'https://pub.dev/packages/internet_quality_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/internet_quality_codespark',
    ),
    OpenSourcePackage(
      name: 'dual_tone_text_codespark',
      downloads: 47,
      tagline: 'Sharp dual-tone color splits on multi-line text.',
      problem:
          'ShaderMask gradients reset at every line boundary, making '
          'multi-line dual-tone text impossible without custom rendering. '
          'I spent a week debugging this before deciding to build the '
          'proper solution using CustomPainter.',
      description:
          'Sharp dual-tone color splits on text — vertical, horizontal, or radial. '
          'The package that emerged after a week debugging a ShaderMask bug.',
      relatedPackages: ['curved_text_codespark', 'rich_highlight_text_codespark'],
      tags: ['text', 'shader', 'typography', 'dual-tone'],
      pubUrl: 'https://pub.dev/packages/dual_tone_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/dual_tone_text_codespark',
    ),
    OpenSourcePackage(
      name: 'rich_highlight_text_codespark',
      downloads: 76,
      tagline: 'Highlight substrings in Text with one call.',
      problem:
          'Search result highlighting requires splitting strings into '
          'TextSpan arrays manually — tedious, error-prone, and written '
          'differently in every project. One extension method should do it.',
      description:
          'Highlight substrings in Text or String via extension methods. '
          'Simple inline highlighting with minimal code.',
      relatedPackages: ['text_highlight_codespark', 'dual_tone_text_codespark'],
      tags: ['text', 'highlight', 'richtext', 'textspan'],
      pubUrl: 'https://pub.dev/packages/rich_highlight_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/rich_highlight_text_codespark',
    ),
    OpenSourcePackage(
      name: 'curved_text_codespark',
      downloads: 43,
      tagline: 'Text rendered along circular, wave, and custom paths.',
      problem:
          'Flutter\'s text engine only renders in straight lines. Curved '
          'labels, arcs, and path-following text are completely unsupported '
          'and require building a rendering layer from scratch.',
      description:
          'Render text along circular, spiral, wave, elliptical, or custom '
          'paths with animation and interactivity.',
      relatedPackages: ['dual_tone_text_codespark', 'icon_to_text_extension_codespark'],
      tags: ['curved-text', 'path-text', 'animation'],
      pubUrl: 'https://pub.dev/packages/curved_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/curved_text_codespark',
    ),
    OpenSourcePackage(
      downloads: 43,
      name: 'read_more_codespark',
      tagline: 'Expandable text with a read more toggle.',
      problem:
          'Truncated text with an expand/collapse toggle is stateful '
          'boilerplate that gets duplicated across every project. I\'ve '
          'written it from scratch too many times.',
      description:
          'Expandable text with a "read more / show less" toggle. '
          'Simple, customizable, and reusable across projects.',
      relatedPackages: ['rich_highlight_text_codespark'],
      tags: ['text', 'expandable', 'read-more'],
      pubUrl: 'https://pub.dev/packages/read_more_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/read_more_codespark',
    ),
    OpenSourcePackage(
      name: 'date_formatter_codespark',
      downloads: 51,
      tagline: 'Date formatting without the intl boilerplate.',
      problem:
          'The `intl` package formats dates but the API is verbose for '
          'common cases. I was writing the same format strings in every '
          'project and decided to wrap the patterns I actually use.',
      description:
          'Format dates with various patterns and locales — one call instead '
          'of writing the same intl boilerplate in every project.',
      relatedPackages: ['context_extensions_codespark'],
      tags: ['date', 'formatter', 'localization'],
      pubUrl: 'https://pub.dev/packages/date_formatter_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/date_formatter_codespark',
    ),
    OpenSourcePackage(
      downloads: 18,
      name: 'text_highlight_codespark',
      tagline: 'Highlight single, multiple, or regex queries in text.',
      problem:
          'Highlighting multiple substrings or regex matches in Flutter text '
          'requires manual TextSpan construction every time — no clean, '
          'reusable abstraction existed.',
      description:
          'Highlight text within a string with single, multiple, or regex '
          'query support.',
      relatedPackages: ['rich_highlight_text_codespark', 'text_comparison_score_codespark'],
      tags: ['text', 'highlight', 'regex'],
      pubUrl: 'https://pub.dev/packages/text_highlight_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/text_highlight_codespark',
    ),
  ];

  // ── Experience (from resume) ─────────────────────────────────────────────
  static const List<ExperienceModel> experience = [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Enspirit',
      duration: 'May 2025 – Present',
      description:
          'Architecting a multi-platform production Flutter application with '
          'real-time multiplayer, offline-first storage, and clean architecture '
          'across 5 game modules deployed on Web, iOS, and Android.',
      bullets: [
        'Multi-game architecture: 5 separate game modules (Moundball, HRD, TDD, Golf, Trivia)',
        'Real-time multiplayer with Socket.io',
        'Sendbird chat integration',
        'RESTful APIs + JWT authentication',
        'Offline-first architecture using Hive caching',
        'Clean Architecture with Repository/UseCase pattern and Provider',
        'Production monitoring with Sentry, Smartlook, and Firebase',
        'Multi-environment configuration + CI/CD pipeline',
      ],
      technologies: [
        'Flutter', 'Dart', 'Socket.io', 'Sendbird', 'Hive',
        'Provider', 'GetIt', 'Firebase', 'Sentry', 'Smartlook',
        'JWT', 'REST API', 'Deeplinks', 'Webview',
      ],
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Wielabs',
      duration: 'Sept 2021 – Apr 2025',
      description:
          'Delivered production mobile applications integrating Flutter '
          'frontends with Node.js and Firebase backends — including native '
          'video, real-time chat, custom camera, and App Store deployment.',
      bullets: [
        'Native video player with MPEG-DASH adaptive streaming',
        'Real-time chat using WebSockets',
        'Custom camera module with high-resolution capture',
        'In-App Purchases for consumables and non-consumables',
        'End-to-end App Store + Play Store deployment',
        'Secure JWT and session-based authentication',
        'Bubble.io backend integration for business logic',
        'Built and published reusable Flutter package ecosystem',
      ],
      technologies: [
        'Flutter', 'Dart', 'Firebase', 'Node.js', 'MongoDB',
        'Express', 'REST API', 'AWS', 'Git', 'GitHub Actions',
        'Xcode', 'Bubble.io',
      ],
    ),
  ];

  // ── Technical Writing ────────────────────────────────────────────────────
  static const List<WritingArticle> articles = [
    WritingArticle(
      title: 'Handling Multiline Gradient Rendering in Flutter',
      summary:
          'Deep-dive into ShaderMask limitations and how CustomPainter '
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
          'API design principles, versioning strategy, and pub.dev publishing '
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
          'breaking changes, and building a coherent suite.',
    ),
  ];

  // ── Computed stats ────────────────────────────────────────────────────────
  static int get totalDownloads =>
      packages.fold(0, (sum, p) => sum + (p.downloads ?? 0));
}
