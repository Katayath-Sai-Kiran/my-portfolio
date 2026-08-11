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
      displayName: 'AI Core',
      category: PkgCategory.onDeviceAI,
      status: PackageStatus.live,
      isFeatured: true,
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
      category: PkgCategory.onDeviceAI,
      status: PackageStatus.live,
      isFeatured: true,
      pubUrl: 'https://pub.dev/packages/semantic_search_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/semantic_search_codespark',
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
      name: 'smart_suggestions_codespark',
      category: PkgCategory.onDeviceAI,
      status: PackageStatus.live,
      isFeatured: true,
      tagline: 'Anchor-based recommendations, entirely on-device.',
      problem: 'Recommendations needed a database. What if they didn\'t?',
      description:
          'Anchor-based recommendation engine built on the same on-device '
          'embeddings as the rest of the AI set — ranks suggestions by '
          'meaning without a server or a database.',
      tags: ['MMR', 'Centroid', 'Web'],
      relatedPackages: ['ai_core_codespark', 'semantic_search_codespark'],
      pubUrl: 'https://pub.dev/packages/smart_suggestions_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/smart_suggestions_codespark',
    ),
    OpenSourcePackage(
      name: 'smart_sort_codespark',
      category: PkgCategory.onDeviceAI,
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
      category: PkgCategory.onDeviceAI,
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
      category: PkgCategory.textUI,
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
      caseStudy: CaseStudy(
        summary:
            'Built for a quiz app that needed fuzzy answer matching — accept '
            '"Barack Obama" when the user types "barack obama" or even "obama '
            'barack". Dart has no built-in string similarity, so I implemented '
            'Levenshtein distance and Jaro-Winkler from scratch.',
        highlights: ['Levenshtein + Jaro-Winkler algorithms', '712+ downloads'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'Quizzes need fuzzy matching',
            body:
                'A quiz feature needed to accept near-correct answers: "barack '
                'obama" should match "Barack Obama", and minor typos should be '
                'accepted. Dart\'s core library has no string comparison beyond '
                'exact equality — no Levenshtein, no similarity scoring.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'Implementing the algorithms from scratch',
            body:
                'I implemented Levenshtein distance for edit-distance scoring '
                'and Jaro-Winkler for prefix-heavy matching (common in names). '
                'The result: a flexible similarity API that returns a score '
                '(0.0–1.0) instead of a boolean, so apps can set their own '
                'thresholds.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/text_comparison_score_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/text_comparison_score_codespark',
    ),
    OpenSourcePackage(
      downloads: 164,
      name: 'animated_dropdown_search_codespark',
      category: PkgCategory.textUI,
      isFeatured: true,
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
      caseStudy: CaseStudy(
        summary:
            'The package that started the whole codespark ecosystem. A client '
            'needed a searchable select over 200+ items and Flutter\'s built-in '
            'DropdownButton couldn\'t handle it — so I built one from scratch '
            'and published it just to learn the pub.dev workflow.',
        highlights: [
          'Kicked off the entire 15-package ecosystem',
          '200+ item search without jank',
          'Animated open/close transitions',
        ],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.chapter,
            heading: 'A weekend experiment that snowballed',
            body:
                'What started as a simple weekend project to learn how publishing '
                'a package on pub.dev actually worked turned into something much '
                'bigger. The dropdown itself was complex — animated, searchable, '
                'with custom rendering — but the real story is what came next.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'Building it properly the first time',
            body:
                'Instead of hacking a search bar onto a standard dropdown, I '
                'built a purpose-built widget with its own animation controller, '
                'filter state, and overlay management. It handled 200+ items '
                'smoothly because it was designed for scale from day one.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'The SRP violation that grew the ecosystem',
            body:
                'While testing the dropdown, I noticed users couldn\'t see why '
                'results matched — the highlighting logic was trapped inside the '
                'dropdown widget. Ripping it out as text_highlight_codespark was '
                'the moment the ecosystem was born: one package naturally split '
                'into two, then four, then fourteen.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/animated_dropdown_search_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/animated_dropdown_search_codespark',
    ),
    OpenSourcePackage(
      downloads: 137,
      name: 'advanced_text_input_formatters_codespark',
      category: PkgCategory.devUtilities,
      displayName: 'Advanced Input Formatters',
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
      caseStudy: CaseStudy(
        summary:
            'A spawn from the dropdown project. The dropdown needed strict '
            'input formatting for its search field, and once I had built the '
            'formatters, I realized they were useful everywhere — clipboard '
            'blocking, typing simulation, naming conventions.',
        highlights: ['Collection of 6+ reusable formatters'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.chapter,
            heading: 'Naturally extracted from the dropdown',
            body:
                'The animated_dropdown_search needed formatting rules for its '
                'text field — blocking clipboard paste during animations, '
                'simulating typing for the search highlight, and enforcing '
                'naming conventions for the filter. Once these existed outside '
                'the dropdown, they became an independent toolkit.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'Published as a standalone set',
            body:
                'Instead of burying formatters inside each package that needs '
                'them, I published them as a collection. Any project can now '
                'import reusable formatters without pulling in the dropdown.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/advanced_text_input_formatters_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/advanced_text_input_formatters_codespark',
    ),
    OpenSourcePackage(
      downloads: 23,
      name: 'context_extensions_codespark',
      category: PkgCategory.devUtilities,
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
      caseStudy: CaseStudy(
        summary:
            'Sheer boilerplate fatigue. Every Flutter project starts with the '
            'same five lookups — MediaQuery, Theme, Navigator, FocusScope, '
            'TextStyle — each requiring the verbose BuildContext pattern. '
            'I packed them into extensions once and never wrote them again.',
        highlights: ['Cuts 5+ lines per lookup to 1', '15+ extension methods'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'Writing the same lookups for the 100th time',
            body:
                'MediaQuery.of(context).size.width. Theme.of(context).textTheme. '
                'FocusScope.of(context).unfocus(). Every project, every screen, '
                'every day. It\'s not hard code — it\'s just tedious, and '
                'tedium in bulk slows you down more than any complex logic.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'One extension, done forever',
            body:
                'context.width, context.textTheme, context.unfocus(), '
                'context.nextFocus(), context.previousFocus(), '
                'context.isMobile, context.isTablet, context.isDesktop — '
                '15+ methods that replace the most common boilerplate patterns. '
                'Published once, imported everywhere.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/context_extensions_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/context_extensions_codespark',
    ),
    OpenSourcePackage(
      name: 'icon_to_text_extension_codespark',
      category: PkgCategory.textUI,
      displayName: 'Icon to Text',
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
      caseStudy: CaseStudy(
        summary:
            'Built out of pure developer rage. I needed a clickable info icon '
            'inline inside a paragraph of wrapped text — impossible with '
            'Flutter\'s native widgets because Row breaks text wrapping. '
            'The spite-driven solution: convert IconData directly into a '
            'TextSpan.',
        highlights: ['Zero text-wrapping breaks', 'Works with any IconData'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'The inline icon problem',
            body:
                'Try putting a clickable "info" icon inside a wrapped paragraph '
                'of text. The obvious approach — Row with IconButton and Text — '
                'breaks text wrapping entirely. The alternative is a hacky '
                'combination of WidgetSpans or custom layout builders. Neither '
                'is clean.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'TextSpan is the answer',
            body:
                'If the icon could become a TextSpan, it would flow naturally '
                'inside the text without breaking anything. I built a widget '
                'that renders any IconData as inline text — it paints the icon '
                'into a TextSpan using a custom WidgetSpan, preserving natural '
                'text flow while keeping the icon clickable.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/icon_to_text_extension_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/icon_to_text_extension_codespark',
    ),
    OpenSourcePackage(
      name: 'internet_quality_codespark',
      category: PkgCategory.devUtilities,
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
      caseStudy: CaseStudy(
        summary:
            'A production debugging session that revealed the real problem '
            'wasn\'t the code — it was the network. The app had no visibility '
            'into connection quality, so every upload failure looked like a '
            'bug. I built a latency-based quality monitor to surface the truth.',
        highlights: ['Latency-based, not just connected/disconnected'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'Chasing a ghost bug',
            body:
                'Users reported upload failures, logs showed no errors, and '
                'everything worked fine on the office Wi-Fi. After days of '
                'debugging, the cause was obvious: poor network quality on '
                'mobile connections. The app only knew if it was "connected" '
                'or "disconnected" — useless for real-world conditions.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'Measuring what matters: latency',
            body:
                'Instead of a binary connected/disconnected check, I built a '
                'latency-based quality analyzer that pings endpoints and '
                'classifies the connection as excellent, good, fair, or poor '
                'based on response times. Surface that to the user before they '
                'hit an upload button.',
          ),
        ],
      ),
      tags: ['internet', 'connectivity', 'network', 'quality'],
      pubUrl: 'https://pub.dev/packages/internet_quality_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/internet_quality_codespark',
    ),
    OpenSourcePackage(
      name: 'dual_tone_text_codespark',
      category: PkgCategory.textUI,
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
      caseStudy: CaseStudy(
        summary:
            'Inspired by a welcome email. A friend showed me a design where '
            '"WELCOME" had the top half in white and bottom in green — '
            'impossible with Flutter\'s built-in text rendering. What followed '
            'was a week-long deep-dive into ShaderMask, blending modes, and '
            'CustomPainter that produced a focused utility package.',
        highlights: ['Multi-line support via CustomPainter', 'Vertical, horizontal, radial splits'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'ShaderMask is a single-line lie',
            body:
                'Flutter\'s ShaderMask applies a gradient that resets at every '
                'line boundary, making multi-line dual-tone text impossible '
                'without custom rendering. A week of debugging ShaderMask '
                'variants proved it was a dead end for anything beyond single '
                'lines.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'CustomPainter fixed what ShaderMask broke',
            body:
                'I built a CustomPainter that treats the entire text block as '
                'one canvas — painting each glyph individually with the correct '
                'color from the gradient, crossing line boundaries cleanly. '
                'The result: sharp dual-tone splits that work on any number of '
                'lines.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/dual_tone_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/dual_tone_text_codespark',
    ),
    OpenSourcePackage(
      name: 'rich_highlight_text_codespark',
      category: PkgCategory.textUI,
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
      caseStudy: CaseStudy(
        summary:
            'The zero-boilerplate evolution of text_highlight_codespark. '
            'The core highlighting logic worked, but still required manual '
            'TextSpan construction. This package wraps it in a single '
            'extension method: .highlight("term").',
        highlights: ['One-method highlighting', 'Supports single, multiple, and regex'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'Even extracted, highlighting was verbose',
            body:
                'text_highlight_codespark solved the SRP violation, but using '
                'it still meant constructing TextSpan arrays manually. Every '
                'search result page had the same boilerplate — different in '
                'every project.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'An extension method changes everything',
            body:
                'By wrapping the core logic in a simple string extension, '
                'highlighting became a single chained call: Text("hello world")'
                '.highlight("world", style: ...). No splitting, no spans, '
                'no boilerplate. The API design was the product.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/rich_highlight_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/rich_highlight_text_codespark',
    ),
    OpenSourcePackage(
      name: 'curved_text_codespark',
      category: PkgCategory.textUI,
      isFeatured: true,
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
      caseStudy: CaseStudy(
        summary:
            'Flutter renders text in straight lines — full stop. Curved '
            'labels, circular text, and path-following typography require a '
            'custom rendering layer. I built one that places individual glyphs '
            'along any Path with animation support.',
        highlights: ['Circular, spiral, wave, elliptical paths', 'Animated along-path movement'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'No curved text in Flutter',
            body:
                'Flutter\'s text engine has one mode: straight lines. Curved '
                'labels, radial text, or any path-following typography is '
                'completely unsupported. The engine simply does not have the '
                'concept of placing glyphs along a curve.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'Glyph-by-glyph path placement',
            body:
                'I built a renderer that extracts individual glyph metrics '
                'from the text, positions each one along a Path using the '
                'path\'s tangent at each step, and rotates them to follow the '
                'curve. Circular, spiral, wave, elliptical — any path works, '
                'including animation.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/curved_text_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/curved_text_codespark',
    ),
    OpenSourcePackage(
      downloads: 43,
      name: 'read_more_codespark',
      category: PkgCategory.textUI,
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
      caseStudy: CaseStudy(
        summary:
            'The most-rewritten widget in any Flutter project: truncated '
            'text with a "read more" button. I built it once, properly, '
            'with animation and flexible line counts.',
        highlights: ['Animated expand/collapse', 'Configurable line count'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'Writing the same widget for the 10th time',
            body:
                'Almost every content-heavy app needs truncated text with a '
                '"read more" toggle. I had written this boilerplate — '
                'TextPainter for measuring, state management for toggling, '
                'InkWell for the button — in at least half a dozen projects. '
                'Each time, slightly differently.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'One reusable widget with animation',
            body:
                'I packaged the pattern into a single widget: configure the '
                'max lines, the toggle label, and the animation duration. '
                'Smooth expand/collapse via AnimatedCrossFade, zero '
                'boilerplate in the consuming project.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/read_more_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/read_more_codespark',
    ),
    OpenSourcePackage(
      name: 'date_formatter_codespark',
      category: PkgCategory.textUI,
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
      caseStudy: CaseStudy(
        summary:
            'The `intl` package works but its API is verbose for everyday '
            'patterns. I was writing "5 minutes ago" and "29 May" formatting '
            'in every project — decided to build a zero-dependency DateTime '
            'extension package that does it in one call.',
        highlights: ['Zero external dependencies', 'TimeAgo, date formatting, quarter math'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.problem,
            heading: 'intl is powerful, but verbose',
            body:
                'DateFormat("MMM d, yyyy").format(date) works, but when you\'re '
                'writing it for the 50th time across projects, you start '
                'wondering why there isn\'t a date.toTimeAgo() or '
                'date.isToday(). The intl package handles localization but '
                'offers no ergonomic extensions for everyday patterns.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'DateTime extensions that feel native',
            body:
                'Built a pure-Dart extension set: dateTime.toTimeAgo() for '
                'relative time, dateTime.isToday/isYesterday/isThisWeek for '
                'checks, dateTime.startOfMonth/endOfQuarter for calendar math, '
                'and dateTime.toShortDateString() for display. One package, '
                'zero deps, every pattern I actually use.',
          ),
        ],
      ),
      pubUrl: 'https://pub.dev/packages/date_formatter_codespark',
      githubUrl: 'https://github.com/Katayath-Sai-Kiran/date_formatter_codespark',
    ),
    OpenSourcePackage(
      downloads: 18,
      name: 'text_highlight_codespark',
      category: PkgCategory.textUI,
      isFeatured: true,
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
      caseStudy: CaseStudy(
        summary:
            'The first extraction. While building animated_dropdown_search, '
            'the search-result highlighting code was trapped inside the '
            'dropdown widget — a clear SRP violation. I ripped it out and '
            'published it as its own package, and the ecosystem was born.',
        highlights: ['First package extracted from the dropdown', 'Single/multiple/regex highlighting'],
        sections: [
          CaseStudySection(
            kind: CaseStudyKind.decision,
            heading: 'Spotting the SRP violation',
            body:
                'The dropdown\'s search filter highlighted matching letters '
                'inside each result. It worked well, but the highlighting '
                'logic had nothing to do with dropdown animation or overlay '
                'management. It was a general-purpose text utility trapped '
                'in a widget-specific file.',
          ),
          CaseStudySection(
            kind: CaseStudyKind.breakthrough,
            heading: 'The extraction that started everything',
            body:
                'I pulled the highlighting code into its own package with '
                'a clean API: pass a string and a query, get back a list of '
                'TextSpans with highlighted matches. That single decision — '
                'respecting the boundary between UI and utility — turned a '
                'one-package weekend experiment into a multi-package ecosystem.',
          ),
        ],
      ),
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

  // NOTE: Published writing lives in a single canonical list — `_articles` in
  // lib/features/home/home_page.dart. The old stale `articles`/`WritingArticle`
  // duplicate was removed to keep one source of truth.

  // ── Computed stats ────────────────────────────────────────────────────────
  static int get totalDownloads =>
      packages.fold(0, (sum, p) => sum + (p.downloads ?? 0));
}
