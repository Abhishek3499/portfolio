class ExperienceModel {
  final String title;
  final String organization;
  final String period;
  final String description;
  final String type; // 'work' | 'education' | 'cert'

  const ExperienceModel({
    required this.title,
    required this.organization,
    required this.period,
    required this.description,
    required this.type,
  });
}
