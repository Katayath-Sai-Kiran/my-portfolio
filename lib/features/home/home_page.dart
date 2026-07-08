import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';
import '../../shared/providers/scroll_provider.dart';
import '../../shared/widgets/footer.dart';
import '../../shared/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.read<ScrollProvider>();

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SingleChildScrollView(
              controller: scrollProvider.scrollController,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroSection(),
                  _FeaturedProjectSection(),
                  _OpenSourceSection(),
                  _ArticlesExperienceRow(),
                  _ContactSection(),
                  PortfolioFooter(),
                ],
              ),
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: PortfolioNavBar()),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// HERO — left text + right stats
// ──────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    return Container(
      key: context.read<ScrollProvider>().sectionKeys[PortfolioSection.hero],
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(hPad, 56 + 32, hPad, 48),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _HeroText(),
                const SizedBox(height: 32),
                _StatsGrid(c: c),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(flex: 5, child: _HeroText()),
                const SizedBox(width: 64),
                Expanded(flex: 4, child: _StatsGrid(c: c)),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Building Flutter packages\nthat ship',
          style: AppTypography.displayHero.copyWith(
            color: c.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Flutter engineer creating open-source tools for AI, text rendering, '
            'and developer workflows. 15 packages on pub.dev.',
            style: AppTypography.bodyLarge.copyWith(
              color: c.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _GhostBtn(label: 'View Packages', onTap: () {}, c: c),
            const SizedBox(width: 16),
            _OutlineBtn(label: 'Read Articles', onTap: () {}, c: c),
          ],
        ),
      ],
    );
  }
}

class _GhostBtn extends StatelessWidget {
  const _GhostBtn({required this.label, required this.onTap, required this.c});
  final String label;
  final VoidCallback onTap;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: c.accent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: c.background == Colors.white ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _OutlineBtn extends StatelessWidget {
  const _OutlineBtn({
    required this.label,
    required this.onTap,
    required this.c,
  });
  final String label;
  final VoidCallback onTap;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: c.border),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: AppTypography.labelLarge.copyWith(
            color: c.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({required this.c});
  final PortfolioColors c;

  static const _stats = [
    ('15', 'packages'),
    ('2500+', 'downloads'),
    ('5+', 'years'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ..._stats.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  s.$1,
                  style: AppTypography.displayMedium.copyWith(
                    color: c.textPrimary,
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  s.$2,
                  style: AppTypography.bodyLarge.copyWith(color: c.textMuted),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// FEATURED PROJECT
// ──────────────────────────────────────────────
class _FeaturedProjectSection extends StatelessWidget {
  const _FeaturedProjectSection();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    return Container(
      key: context
          .read<ScrollProvider>()
          .sectionKeys[PortfolioSection.featuredProject],
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: c.borderSubtle),
          bottom: BorderSide(color: c.borderSubtle),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FEATURED PROJECT',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'AI Engine Ecosystem',
            style: isMobile
                ? AppTypography.headlineLarge
                : AppTypography.displayMedium,
          ),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Three packages that bring offline ML to Flutter. A 23MB MiniLM model powers semantic understanding without a server.',
              style: AppTypography.bodyLarge.copyWith(
                color: c.textSecondary,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _Tag(label: 'On-device intelligence', c: c),
              const SizedBox(width: 8),
              _Tag(label: '2026', c: c),
            ],
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.c});
  final String label;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.surfaceHover,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: AppTypography.monoSmall.copyWith(
          color: c.textMuted,
          fontSize: 9,
        ),
      ),
    );
  }
}

// ──────────────────────────────────────────────
// OPEN SOURCE
// ──────────────────────────────────────────────
class _OpenSourceSection extends StatelessWidget {
  const _OpenSourceSection();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    return Container(
      key: context
          .read<ScrollProvider>()
          .sectionKeys[PortfolioSection.openSource],
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'OPEN SOURCE',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '15 packages on pub.dev',
            style: isMobile
                ? AppTypography.headlineLarge
                : AppTypography.displayMedium,
          ),
          const SizedBox(height: 24),
          ...List.generate(_categories.length, (i) {
            final cat = _categories[i];
            return Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat.name,
                    style: AppTypography.titleMedium.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...cat.packages.map(
                    (pkg) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '${pkg.name} — ${pkg.description}',
                        style: AppTypography.bodyMedium.copyWith(
                          color: c.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _Category {
  const _Category({required this.name, required this.packages});
  final String name;
  final List<_Pkg> packages;
}

class _Pkg {
  const _Pkg({required this.name, required this.description});
  final String name;
  final String description;
}

const _categories = [
  _Category(
    name: 'On-Device AI',
    packages: [
      _Pkg(
        name: 'ai_core_codespark',
        description:
            'Core embedding engine with offline MiniLM model for semantic understanding',
      ),
      _Pkg(
        name: 'semantic_search_codespark',
        description:
            'Query-driven semantic search with debounced input and MMR diversity ranking',
      ),
      _Pkg(
        name: 'smart_suggestions_codespark',
        description:
            'Anchor-based recommendations with MMR diverse ranking and centroid matching',
      ),
    ],
  ),
  _Category(
    name: 'Text & UI',
    packages: [
      _Pkg(
        name: 'text_comparison_score_codespark',
        description:
            'String similarity using Levenshtein, Damerau-Levenshtein, and Jaro-Winkler algorithms',
      ),
      _Pkg(
        name: 'text_highlight_codespark',
        description:
            'Text highlighting with single, multiple, and regex query support',
      ),
      _Pkg(
        name: 'rich_highlight_text_codespark',
        description:
            'Inline substring highlighting using Text.rich with custom styles',
      ),
      _Pkg(
        name: 'dual_tone_text_codespark',
        description:
            'Dual-tone gradient text rendering with vertical and horizontal color splits',
      ),
      _Pkg(
        name: 'curved_text_codespark',
        description:
            'Render text along circular, spiral, wave, elliptical, or custom paths',
      ),
      _Pkg(
        name: 'date_formatter_codespark',
        description:
            'DateTime extensions for formatting, relative time, time ago, and business day calculations',
      ),
      _Pkg(
        name: 'animated_dropdown_search_codespark',
        description: 'Customisable animated search dropdown widget',
      ),
      _Pkg(
        name: 'read_more_codespark',
        description:
            'Expandable text widget for long-form content with customizable truncation',
      ),
      _Pkg(
        name: 'icon_to_text_extension_codespark',
        description:
            'Convert any IconData to inline Text or TextSpan with rich text builder',
      ),
    ],
  ),
  _Category(
    name: 'Developer Utilities',
    packages: [
      _Pkg(
        name: 'advanced_text_input_formatters_codespark',
        description:
            'Extended input text formatter utilities for Flutter TextFields',
      ),
      _Pkg(
        name: 'internet_quality_codespark',
        description:
            'Measure real-world internet quality using latency-based analysis',
      ),
      _Pkg(
        name: 'context_extensions_codespark',
        description: 'Build context utility extensions for cleaner widget code',
      ),
    ],
  ),
];

// ──────────────────────────────────────────────
// ARTICLES + EXPERIENCE
// ──────────────────────────────────────────────
class _ArticlesExperienceRow extends StatelessWidget {
  const _ArticlesExperienceRow();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: c.borderSubtle),
          bottom: BorderSide(color: c.borderSubtle),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 48),
      child: isMobile
          ? Column(
              children: const [
                _ArticlesColumn(),
                SizedBox(height: 48),
                _ExperienceColumn(),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(child: _ArticlesColumn()),
                SizedBox(width: 48),
                Expanded(child: _ExperienceColumn()),
              ],
            ),
    );
  }
}

class _ArticlesColumn extends StatelessWidget {
  const _ArticlesColumn();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final scrollProvider = context.read<ScrollProvider>();

    return Container(
      key: scrollProvider.sectionKeys[PortfolioSection.articles],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'RECENT ARTICLES',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          ..._articles.map(
            (a) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                hoverColor: c.surfaceHover,
                onTap: () {
                  launchUrl(Uri.parse(a.link));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 12,
                    bottom: 12,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              a.title,
                              style: AppTypography.titleMedium.copyWith(
                                color: c.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              a.summary,
                              style: AppTypography.bodyMedium.copyWith(
                                color: c.textSecondary,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              a.date,
                              style: AppTypography.monoSmall.copyWith(
                                color: c.textMuted,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.open_in_new,
                        color: c.textMuted.withAlpha(100),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _articles = [
  _Article(
    title: 'The Accidental Ecosystem',
    summary: 'How fixing personal frustrations led to 15 packages on pub.dev.',
    date: 'Apr 14, 2026',
    link:
        'https://medium.com/@saikirankatayath/how-i-accidentally-built-a-14-package-flutter-ecosystem-21882300919f',
  ),
  _Article(
    title: 'Future-Proofing Flutter',
    summary: 'What happens when AI can generate UI code?',
    date: 'May 2, 2026',
    link:
        'https://medium.com/@saikirankatayath/how-i-future-proofed-my-14-package-flutter-ecosystem-against-ai-and-why-you-need-to-e705aecf0cd7?sharedUserId=saikirankatayath',
  ),
  _Article(
    title: 'Dependency Management at Scale',
    summary: 'Lessons from maintaining a 15-package ecosystem.',
    date: 'May 28, 2026',
    link:
        'https://medium.com/@saikirankatayath/flutter-dependency-management-in-2025-how-to-use-flutter-pub-deps-effectively-782080bef85e',
  ),
  _Article(
    title: 'The AI Shift and pub.dev',
    summary: 'How AI-assisted development changes the package ecosystem.',
    date: 'Jun 15, 2026',
    link:
        'https://medium.com/@saikirankatayath/the-ai-shift-nobody-is-talking-about-on-pub-dev-c2b45d2c7f0e',
  ),
];

class _Article {
  const _Article({
    required this.title,
    required this.summary,
    required this.date,
    required this.link,
  });
  final String title;
  final String summary;
  final String date;
  final String link;
}

class _ExperienceColumn extends StatelessWidget {
  const _ExperienceColumn();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final scrollProvider = context.read<ScrollProvider>();

    return Container(
      key: scrollProvider.sectionKeys[PortfolioSection.experience],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPERIENCE',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          _ExpCard(
            role: 'Flutter Engineer',
            org: 'Enspirit',
            location: 'Hyderabad',
            year: '2025 – Present',
            highlights: [
              'Rally Nation — Multi-platform sports app with 5 real-time multiplayer game modules (Socket.io, Hive offline fallback)',
            ],
            c: c,
          ),
          const SizedBox(height: 24),
          _ExpCard(
            role: 'Flutter Developer',
            org: 'Wielabs',
            location: 'Hyderabad',
            year: '2021 – 2025',
            highlights: [
              'MoneyMinds — EdTech web app with MPEG-DASH adaptive video player and real-time chat',
              'Truth Catcher — NFT app with custom high-res camera module and In-App Purchases',
              'NeurallyMed — Exam prep platform with JWT auth, offline-first caching, and IAP gating',
              'Aezo — Trade association app integrating Bubble.io no-code backend with custom UI',
            ],
            c: c,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: c.borderSubtle),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Common across all projects',
                  style: AppTypography.labelLarge.copyWith(
                    color: c.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                _commonPoint(
                  'Published to App Store & Google Play — code signing, compliance, release coordination',
                  c,
                ),
                _commonPoint(
                  'Firebase + Node.js backends with REST APIs and WebSockets',
                  c,
                ),
                _commonPoint(
                  'Full lifecycle ownership — Figma through to production deployment',
                  c,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _commonPoint(String text, PortfolioColors c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '— ',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpCard extends StatelessWidget {
  const _ExpCard({
    required this.role,
    required this.org,
    required this.location,
    required this.year,
    required this.highlights,
    required this.c,
  });
  final String role;
  final String org;
  final String location;
  final String year;
  final List<String> highlights;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: c.borderSubtle),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  role,
                  style: AppTypography.titleMedium.copyWith(
                    color: c.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                year,
                style: AppTypography.monoSmall.copyWith(
                  color: c.textMuted,
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$org · $location',
            style: AppTypography.bodyMedium.copyWith(color: c.textSecondary),
          ),
          const SizedBox(height: 12),
          ...highlights.map(
            (h) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '— ',
                    style: AppTypography.monoSmall.copyWith(
                      color: c.textMuted,
                      fontSize: 10,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      h,
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────
// CONTACT
// ──────────────────────────────────────────────
class _ContactSection extends StatelessWidget {
  const _ContactSection();

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 768;
    final hPad = isMobile ? 24.0 : 64.0;

    return Container(
      key: context.read<ScrollProvider>().sectionKeys[PortfolioSection.contact],
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: c.borderSubtle)),
      ),
      padding: EdgeInsets.fromLTRB(hPad, 48, hPad, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CONTACT',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s build something.',
            style: isMobile
                ? AppTypography.headlineLarge
                : AppTypography.displayMedium,
          ),
          const SizedBox(height: 24),
          _GhostBtn(label: 'Start a Conversation', onTap: () {}, c: c),
        ],
      ),
    );
  }
}
