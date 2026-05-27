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
    this.githubUrl,
    this.liveUrl,
  });

  final String title;
  final String description;
  final List<String> tags;
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

/// Open-source package card (Open Source Ecosystem section).
class OpenSourcePackage {
  const OpenSourcePackage({
    required this.name,
    required this.description,
    required this.tags,
    required this.pubUrl,
    this.githubUrl,
  });

  final String name;
  final String description;
  final List<String> tags;
  final String pubUrl;
  final String? githubUrl;
}

/// Technical writing article card (Technical Writing section).
class WritingArticle {
  const WritingArticle({required this.title, required this.summary, this.url});

  final String title;
  final String summary;
  final String? url;
}
