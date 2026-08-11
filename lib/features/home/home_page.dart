import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../features/manifesto/manifesto_section.dart';
import '../../features/now/now_section.dart';
import '../../shared/providers/scroll_provider.dart';
import '../../shared/widgets/footer.dart';
import '../../shared/widgets/nav_bar.dart';
import 'widgets/category_header.dart';
import 'widgets/pkg_grid.dart';
import 'widgets/pkg_stat_card.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeroSection(),
                  _FeaturedProjectSection(),
                  _OpenSourceSection(),
                  _ArticlesExperienceRow(),
                  Builder(
                    builder: (context) => Container(
                      key: scrollProvider
                          .sectionKeys[PortfolioSection.manifesto],
                      child: const ManifestoSection(),
                    ),
                  ),
                  Builder(
                    builder: (context) => Container(
                      key: scrollProvider.sectionKeys[PortfolioSection.now],
                      child: const NowSection(),
                    ),
                  ),
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
    final scrollProvider = context.read<ScrollProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Packages that ship.\nInvestigations that teach.',
          style: AppTypography.displayHero.copyWith(
            color: c.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 24),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'I build reusable engineering systems for Flutter, investigate unexpected '
            'software behavior, and document the reasoning behind the solutions.',
            style: AppTypography.bodyLarge.copyWith(
              color: c.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Engineer • Open-source maintainer • Technical storyteller\n'
            'Turning recurring software problems into reusable tools.',
            style: AppTypography.bodyMedium.copyWith(
              color: c.textMuted,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            _GhostBtn(
              label: 'View Packages',
              onTap: () =>
                  scrollProvider.scrollToSection(PortfolioSection.openSource),
              c: c,
            ),
            const SizedBox(width: 16),
            _OutlineBtn(
              label: 'Read Investigations',
              onTap: () =>
                  scrollProvider.scrollToSection(PortfolioSection.articles),
              c: c,
            ),
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
          // On-accent label: accent is black in light / white in dark, so the
          // contrasting text color is exactly the page background in both themes.
          style: AppTypography.labelLarge.copyWith(
            color: c.background,
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
      child: InkWell(
        hoverColor: c.surfaceHover,
        onTap: () => context.go('/packages/ai-core-codespark'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FEATURED BUILD LOG',
                style: AppTypography.monoSmall.copyWith(
                  color: c.textMuted,
                  fontSize: 10,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Getting real AI to run on-device',
                style: isMobile
                    ? AppTypography.headlineLarge
                    : AppTypography.displayMedium,
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 640),
                child: Text(
                  'Real text embeddings on the device — no API keys, no server, '
                  'no data leaving the phone. A 23MB quantized MiniLM model and a '
                  'pure-Dart tokenizer verified byte-for-byte against HuggingFace. '
                  'The tokenizer was the actual project; the model was the easy 80%. '
                  'Then int8 embeddings scored 0.14 against the reference instead of '
                  '0.99 — and hours of suspicion fell on the wrong suspect. Shipped '
                  'at 160/160, honest about what it can\'t do.',
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
                  _Tag(label: '160 / 160 pub points', c: c),
                  const SizedBox(width: 8),
                  _Tag(label: '2026', c: c),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Read the build log →',
                style: AppTypography.labelLarge.copyWith(
                  color: c.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
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

    final livePkgs = PortfolioData.packages.where((p) => p.isLive).toList();
    // Home shows a taste of each category — featured packages first, capped
    // at 2 — the rest live behind "View All Packages".
    List<OpenSourcePackage> topTwo(PkgCategory category) {
      final inCategory = livePkgs.where((p) => p.category == category);
      return [
        ...inCategory.where((p) => p.isFeatured),
        ...inCategory.where((p) => !p.isFeatured),
      ].take(2).toList();
    }

    final aiPkgs = topTwo(PkgCategory.onDeviceAI);
    final textPkgs = topTwo(PkgCategory.textUI);
    final utilPkgs = topTwo(PkgCategory.devUtilities);

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
              height: 1,
            ),
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              style:
                  (isMobile
                          ? AppTypography.headlineLarge
                          : AppTypography.displayMedium)
                      .copyWith(color: c.textPrimary, height: 1.1),
              children: [
                const TextSpan(text: 'Fifteen packages,\none '),
                TextSpan(
                  text: 'ecosystem',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: c.accent,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              'Each one began as a personal frustration — the refusal to write '
              'the same boilerplate twice. Extracted from real projects, '
              'hardened, and shipped to pub.dev.',
              style: AppTypography.bodyLarge.copyWith(
                color: c.textSecondary,
                height: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _StatsRow(c: c, isMobile: isMobile),
          const SizedBox(height: 56),
          _CategoryBlock(
            subtitle:
                'Real ML on the device — no API keys, no server. AI Core is '
                'the engine; Semantic Search and Smart Suggestions build on it.',
            packages: aiPkgs,
            c: c,
          ),
          const SizedBox(height: 40),
          _CategoryBlock(
            subtitle:
                'Rendering Flutter doesn\'t ship out of the box — curved and '
                'dual-tone text, inline icons, and one-call highlighting.',
            packages: textPkgs,
            c: c,
          ),
          const SizedBox(height: 40),
          _CategoryBlock(
            subtitle:
                'The boilerplate I refused to rewrite again — context '
                'extensions, input formatters, and network-quality checks.',
            packages: utilPkgs,
            c: c,
          ),
          const SizedBox(height: 40),
          Center(child: _ViewAllPackagesButton(c: c)),
        ],
      ),
    );
  }
}

class _ViewAllPackagesButton extends StatefulWidget {
  const _ViewAllPackagesButton({required this.c});
  final PortfolioColors c;

  @override
  State<_ViewAllPackagesButton> createState() => _ViewAllPackagesButtonState();
}

class _ViewAllPackagesButtonState extends State<_ViewAllPackagesButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => GoRouter.of(context).go('/packages'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: _hovered ? c.textPrimary : c.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View All Packages',
                style: AppTypography.labelLarge.copyWith(
                  color: c.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.arrow_forward_rounded, size: 16, color: c.textPrimary),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final stats = [
      ('15', 'Packages'),
      ('2,500+', 'Downloads'),
      ('3', 'Categories'),
      ('160/160', 'Best pub score'),
    ];
    if (isMobile) {
      return Wrap(
        spacing: 32,
        runSpacing: 20,
        children: stats
            .map((s) => PkgStatCard(value: s.$1, label: s.$2))
            .toList(),
      );
    }
    return Row(
      children: List.generate(stats.length, (i) {
        final s = stats[i];
        return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [PkgStatCard(value: s.$1, label: s.$2)],
          ),
        );
      }),
    );
  }
}

class _CategoryBlock extends StatelessWidget {
  const _CategoryBlock({
    required this.subtitle,
    required this.packages,
    required this.c,
  });
  final String subtitle;
  final List<OpenSourcePackage> packages;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryHeader(category: packages.first.category),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            subtitle,
            style: AppTypography.bodyMedium.copyWith(
              color: c.textMuted,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        PkgGrid(packages: packages),
      ],
    );
  }
}

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
            'ENGINEERING INVESTIGATIONS',
            style: AppTypography.monoSmall.copyWith(
              color: c.textMuted,
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          // Featured Investigation
          InkWell(
            hoverColor: c.surfaceHover,
            onTap: () {
              launchUrl(Uri.parse(_articles[0].link));
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(color: c.borderSubtle),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: c.accent.withAlpha(30),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'FEATURED',
                          style: AppTypography.monoSmall.copyWith(
                            color: c.accent,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _articles[0].title,
                    style: AppTypography.titleLarge.copyWith(
                      color: c.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _articles[0].summary,
                    style: AppTypography.bodyMedium.copyWith(
                      color: c.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        _articles[0].date,
                        style: AppTypography.monoSmall.copyWith(
                          color: c.textMuted,
                          fontSize: 9,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Read Investigation →',
                        style: AppTypography.labelLarge.copyWith(
                          color: c.accent,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ..._articles
              .skip(1)
              .map(
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

/// Canonical source of truth for published investigations.
/// The homepage Engineering Investigations column reads from this list; keep
/// any other surface in sync with it rather than duplicating article facts.
const _articles = [
  _Article(
    title: 'The Accidental Ecosystem',
    summary:
        'A weekend dropdown widget quietly grew into an open-source ecosystem. '
        'The story of one SRP violation I couldn\'t unsee — and how splitting '
        'it out taught me the way ecosystems actually grow.',
    date: 'Apr 14, 2026',
    link:
        'https://medium.com/@saikirankatayath/how-i-accidentally-built-a-14-package-flutter-ecosystem-21882300919f',
  ),
  _Article(
    title: 'Future-Proofing Flutter Against AI',
    summary:
        'When AI can generate any widget on demand, what actually makes an '
        'engineer irreplaceable? A case for reasoning over syntax.',
    date: 'May 2, 2026',
    link:
        'https://medium.com/@saikirankatayath/how-i-future-proofed-my-14-package-flutter-ecosystem-against-ai-and-why-you-need-to-e705aecf0cd7?sharedUserId=saikirankatayath',
  ),
  _Article(
    title: 'Managing Dependencies at Ecosystem Scale',
    summary:
        'What maintaining an interdependent package family taught me about '
        '`flutter pub deps` — and the traps that only surface at scale.',
    date: 'May 28, 2026',
    link:
        'https://medium.com/@saikirankatayath/flutter-dependency-management-in-2025-how-to-use-flutter-pub-deps-effectively-782080bef85e',
  ),
  _Article(
    title: 'The AI Shift Nobody\'s Talking About',
    summary:
        'AI changed how developers discover packages before it changed how '
        'they write them. What that quietly means for open source on pub.dev.',
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
              'Rally Nation — Five real-time multiplayer game modes on one clean-architecture core (Repository + UseCase, Provider, GetIt).',
              'Offline-first with Hive, because unreliable mobile networks taught me the offline path can\'t be an afterthought — it has to be the foundation.',
              'Chasing "upload bugs" that turned out to be network-quality bugs is exactly what became internet_quality_codespark.',
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
              'MoneyMinds — Shipped native MPEG-DASH video and WebSocket chat to Flutter web, back when the accepted wisdom was that Flutter web couldn\'t stream video.',
              'Truth Catcher — Built a filter-free custom camera module over Kotlin platform channels because no off-the-shelf plugin hit the capture quality the product needed.',
              'NeurallyMed & Aezo — Offline-first caching to cut API calls, JWT-secured content gating, IAP across both stores, and a Bubble.io backend for fast business-logic iteration.',
              'The open-source work started here: a searchable dropdown over 200+ items Flutter\'s built-in couldn\'t handle. Pulling its highlighting logic into its own package split one widget into a whole ecosystem.',
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
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '— ',
                    style: AppTypography.monoSmall.copyWith(
                      color: c.textMuted,
                      fontSize: 10,
                      height: 1.5,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      h,
                      style: AppTypography.bodyMedium.copyWith(
                        color: c.textSecondary,
                        height: 1.5,
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
          _GhostBtn(
            label: 'Start a Conversation',
            onTap: () => context.go('/conversation-start'),
            c: c,
          ),
        ],
      ),
    );
  }
}
