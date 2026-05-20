import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';
import '../models/experience_model.dart';

final portfolioProvider = Provider<PortfolioController>((ref) {
  return PortfolioController();
});

final scrollControllerProvider = Provider<ScrollController>((ref) {
  final controller = ScrollController();
  ref.onDispose(controller.dispose);
  return controller;
});

class PortfolioController {
  final List<ProjectModel> projects = const [
    ProjectModel(
      title: 'Sports App',
      description:
          'A feature-rich sports companion app with live scores, match schedules, team stats, and personalized notifications for sports enthusiasts.',
      techTags: ['Flutter', 'Dart', 'REST API', 'Riverpod', 'Firebase'],
      features: [
        'Live score updates',
        'Team & player stats',
        'Push notifications',
        'Favorites & bookmarks',
      ],
      githubUrl: 'https://github.com/dashboard',
      emoji: '⚽',
    ),
    ProjectModel(
      title: 'Auth Module',
      description:
          'A production-ready authentication module with email/password, Google Sign-In, biometric auth, and secure token management.',
      techTags: ['Flutter', 'Firebase Auth', 'Clean Architecture', 'GetX'],
      features: [
        'Email & Google Sign-In',
        'Biometric authentication',
        'JWT token management',
        'Clean Architecture',
      ],
      githubUrl: 'https://github.com/dashboard',
      emoji: '🔐',
    ),
    ProjectModel(
      title: 'Real-time Chat App',
      description:
          'A scalable real-time messaging application with WebSocket support, media sharing, read receipts, and online presence indicators.',
      techTags: ['Flutter', 'WebSocket', 'Firebase', 'Riverpod'],
      features: [
        'Real-time messaging',
        'Media & file sharing',
        'Read receipts',
        'Online presence',
      ],
      githubUrl: 'https://github.com/dashboard',
      emoji: '💬',
    ),
  ];

  final List<SkillModel> skills = const [
    SkillModel(
      name: 'Flutter',
      icon: FontAwesomeIcons.mobile,
      category: 'Framework',
    ),
    SkillModel(name: 'Dart', icon: FontAwesomeIcons.code, category: 'Language'),
    SkillModel(
      name: 'Firebase',
      icon: FontAwesomeIcons.fire,
      category: 'Backend',
    ),
    SkillModel(
      name: 'REST APIs',
      icon: FontAwesomeIcons.plug,
      category: 'Integration',
    ),
    SkillModel(
      name: 'WebSocket',
      icon: FontAwesomeIcons.wifi,
      category: 'Real-time',
    ),
    SkillModel(
      name: 'Riverpod',
      icon: FontAwesomeIcons.layerGroup,
      category: 'State',
    ),
    SkillModel(name: 'GetX', icon: FontAwesomeIcons.bolt, category: 'State'),
    SkillModel(
      name: 'Clean Arch',
      icon: FontAwesomeIcons.cubes,
      category: 'Architecture',
    ),
    SkillModel(
      name: 'Animations',
      icon: FontAwesomeIcons.wandMagicSparkles,
      category: 'UI/UX',
    ),
  ];

  final List<ExperienceModel> experiences = const [
    ExperienceModel(
      title: 'Flutter Development Training',
      organization: 'Hardkore Tech, Mohali, Punjab',
      period: 'Nov 2025 - May 2026',
      description:
          'Completed 6 months of Flutter development training and worked on 2 practical app projects using modern UI practices and clean architecture basics.',
      type: 'work',
    ),
    ExperienceModel(
      title: 'Bachelor of Computer Applications',
      organization: 'Govt. Degree College, Sarkaghat',
      period: '2019 - 2022',
      description:
          'Built a strong foundation in programming, computer applications, databases, and software development fundamentals.',
      type: 'education',
    ),
    ExperienceModel(
      title: 'Master of Computer Applications',
      organization: 'Shoolini University, Solan, HP',
      period: '2023 - 2025',
      description:
          'Advanced studies in application development, software engineering, data structures, algorithms, and modern development practices.',
      type: 'education',
    ),
  ];
}
