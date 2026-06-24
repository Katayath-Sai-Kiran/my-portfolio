class ProjectModel {
  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    required this.githubUrl,
    this.liveUrl,
    this.imageAsset,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String githubUrl;
  final String? liveUrl;
  final String? imageAsset;
}

class SkillCategory {
  const SkillCategory({required this.label, required this.skills});
  final String label;
  final List<String> skills;
}

class ExperienceModel {
  const ExperienceModel({
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    required this.bullets,
    required this.technologies,
  });

  final String role;
  final String company;
  final String duration;
  final String description;
  final List<String> bullets;
  final List<String> technologies;
}

/// Engineering-focused project (Engineering Work section).
class EngineeringProject {
  const EngineeringProject({
    required this.title,
    required this.description,
    required this.tags,
    this.category,
    this.bullets,
    this.githubUrl,
    this.liveUrl,
  });

  final String title;
  final String description;
  final List<String> tags;
  final String? category;
  final List<String>? bullets;
  final String? githubUrl;
  final String? liveUrl;
}

/// Technical challenge card (Engineering Challenges Solved section).
class ChallengeModel {
  const ChallengeModel({
    required this.problem,
    required this.solution,
    required this.technologies,
  });

  final String problem;
  final String solution;
  final List<String> technologies;
}

/// Whether a package is live on pub.dev or still on the roadmap.
enum PackageStatus { live, comingSoon }

/// Groups packages under titled sets on the Open Source section.
enum PackageCategory {
  ai(
    'On-Device AI',
    'Local, offline intelligence — embeddings, semantic search, and the '
        'engine that powers them. No API keys, no cloud.',
  ),
  utility(
    'Flutter Utilities',
    'Small, focused tools that remove boilerplate from everyday Flutter work.',
  );

  const PackageCategory(this.title, this.blurb);

  /// Section title shown above the group.
  final String title;

  /// One-line description shown under the group title.
  final String blurb;
}

/// The texture of a case-study beat — drives its label, colour, and icon so the
/// story reads as a real build log (decisions, setbacks, problems, wins).
enum CaseStudyKind { chapter, decision, setback, problem, breakthrough }

/// One labelled beat of a package case study.
class CaseStudySection {
  const CaseStudySection({
    required this.heading,
    required this.body,
    this.kind = CaseStudyKind.chapter,
  });
  final String heading;
  final String body;
  final CaseStudyKind kind;
}

/// The engineering story behind a package: the idea, how it was built, and
/// what came out of it. Rendered inside the package detail page.
class CaseStudy {
  const CaseStudy({
    required this.summary,
    required this.sections,
    this.highlights = const [],
    this.url,
  });

  /// One or two sentences: what it is and why it exists.
  final String summary;

  /// Ordered chapters (Problem, Approach, Outcome, …).
  final List<CaseStudySection> sections;

  /// Key results / metrics shown as chips.
  final List<String> highlights;

  /// Optional external write-up (blog post, README, etc.).
  final String? url;
}

/// Open-source package card.
class OpenSourcePackage {
  const OpenSourcePackage({
    required this.name,
    required this.description,
    required this.tags,
    this.pubUrl,
    this.githubUrl,
    this.downloads,
    this.version,
    this.publishedOn,
    this.tagline,
    this.problem,
    this.relatedPackages = const [],
    this.status = PackageStatus.live,
    this.category = PackageCategory.utility,
    this.caseStudy,
  });

  final String name;

  /// Full narrative description — the "why I built this" story.
  final String description;

  /// Short one-liner used as the hero subtitle on the detail page.
  final String? tagline;

  /// The specific problem this package was built to solve.
  final String? problem;

  final List<String> tags;

  /// pub.dev URL — null for packages that aren't published yet.
  final String? pubUrl;
  final String? githubUrl;
  final int? downloads;
  final String? version;
  final DateTime? publishedOn;

  /// Names of related packages from this publisher.
  final List<String> relatedPackages;

  /// Whether the package is live on pub.dev or still on the roadmap.
  final PackageStatus status;

  /// Which titled set this package belongs to.
  final PackageCategory category;

  /// Optional long-form engineering story shown on the detail page.
  final CaseStudy? caseStudy;

  bool get isComingSoon => status == PackageStatus.comingSoon;
  bool get isLive => status == PackageStatus.live;

  /// URL-safe slug derived from the package name.
  String get slug => name.replaceAll('_', '-');

  /// Display name: strips the `_codespark` suffix for cleaner headings.
  String get displayName =>
      name.replaceAll('_codespark', '').replaceAll('_', ' ').trim();
}

/// Technical writing article card (Technical Writing section).
class WritingArticle {
  const WritingArticle({required this.title, required this.summary, this.url});

  final String title;
  final String summary;
  final String? url;
}
