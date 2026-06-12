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

/// Open-source package card.
class OpenSourcePackage {
  const OpenSourcePackage({
    required this.name,
    required this.description,
    required this.tags,
    required this.pubUrl,
    this.githubUrl,
    this.downloads,
    this.version,
    this.publishedOn,
    this.tagline,
    this.problem,
    this.relatedPackages = const [],
  });

  final String name;

  /// Full narrative description — the "why I built this" story.
  final String description;

  /// Short one-liner used as the hero subtitle on the detail page.
  final String? tagline;

  /// The specific problem this package was built to solve.
  final String? problem;

  final List<String> tags;
  final String pubUrl;
  final String? githubUrl;
  final int? downloads;
  final String? version;
  final DateTime? publishedOn;

  /// Names of related packages from this publisher.
  final List<String> relatedPackages;

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
