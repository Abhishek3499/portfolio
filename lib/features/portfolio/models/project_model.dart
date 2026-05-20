class ProjectModel {
  final String title;
  final String description;
  final List<String> techTags;
  final List<String> features;
  final String? githubUrl;
  final String? liveUrl;
  final String emoji;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.techTags,
    required this.features,
    this.githubUrl,
    this.liveUrl,
    required this.emoji,
  });
}
