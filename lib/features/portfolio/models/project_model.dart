class ProjectModel {
  final String title;
  final String description;
  final List<String> techTags;
  final List<String> features;
  final String? githubUrl;
  final String? liveUrl;
  final String emoji;
  final String? role;
  final String? problem;
  final String? solution;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.techTags,
    required this.features,
    this.githubUrl,
    this.liveUrl,
    required this.emoji,
    this.role,
    this.problem,
    this.solution,
  });
}
