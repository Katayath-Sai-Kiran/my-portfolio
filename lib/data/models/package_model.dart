enum PkgCategory { onDeviceAI, textUI, devUtilities }

class PackageModel {
  final String name;
  final String displayName;
  final String description;
  final PkgCategory category;
  final List<String> tags;
  final String pubUrl;
  final String githubUrl;
  final bool isFeatured;
  final String version;

  const PackageModel({
    required this.name,
    required this.displayName,
    required this.description,
    required this.category,
    required this.tags,
    required this.pubUrl,
    required this.githubUrl,
    this.isFeatured = false,
    this.version = '',
  });
}
