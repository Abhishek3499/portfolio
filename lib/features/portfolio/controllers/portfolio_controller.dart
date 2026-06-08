import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

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
      title: 'Sports Management App',
      description:
          'A responsive sports management application focused on real-time updates, booking management, chat, voice messages, and push notifications.',
      techTags: [
        'Flutter',
        'Firebase',
        'Riverpod',
        'Chat',
        'Push Notifications',
        'Responsive UI',
      ],
      features: [
        'Authentication',
        'Chat and voice messages',
        'Push notifications',
        'Responsive design',
      ],
      role: 'Flutter Developer',
      problem:
          'Needed real-time sports updates and booking management in a clean mobile experience.',
      solution:
          'Built a responsive Flutter app with Firebase backend support, Riverpod state management, and a modern user interface.',
      githubUrl: 'https://github.com/dashboard',
      emoji: 'Sports',
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
      emoji: 'Lock',
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
      emoji: 'Chat',
    ),
  ];

  final List<SkillModel> skills = const [
    SkillModel(
      name: 'Flutter',
      icon: FontAwesomeIcons.mobile,
      category: 'Framework',
    ),
    SkillModel(
      name: 'Dart',
      icon: FontAwesomeIcons.code,
      category: 'Language',
    ),
    SkillModel(
      name: 'Riverpod',
      icon: FontAwesomeIcons.layerGroup,
      category: 'State Management',
    ),
    SkillModel(
      name: 'Bloc',
      icon: FontAwesomeIcons.puzzlePiece,
      category: 'State Management',
    ),
    SkillModel(
      name: 'GetX',
      icon: FontAwesomeIcons.bolt,
      category: 'State Management',
    ),
    SkillModel(
      name: 'Clean Architecture',
      icon: FontAwesomeIcons.cubes,
      category: 'Architecture',
    ),
    SkillModel(
      name: 'API Integration',
      icon: FontAwesomeIcons.cloud,
      category: 'API & Integration',
    ),
    SkillModel(
      name: 'REST APIs',
      icon: FontAwesomeIcons.plug,
      category: 'API & Integration',
    ),
    SkillModel(
      name: 'WebSocket',
      icon: FontAwesomeIcons.wifi,
      category: 'API & Integration',
    ),
    SkillModel(
      name: 'Custom Animations',
      icon: FontAwesomeIcons.wandMagicSparkles,
      category: 'UI/UX & Design',
    ),
    SkillModel(
      name: 'Responsive UI',
      icon: FontAwesomeIcons.laptop,
      category: 'UI/UX & Design',
    ),
    SkillModel(
      name: 'Material Design',
      icon: FontAwesomeIcons.palette,
      category: 'UI/UX & Design',
    ),
    SkillModel(
      name: 'Dark/Light Theme',
      icon: FontAwesomeIcons.circleHalfStroke,
      category: 'UI/UX & Design',
    ),
    SkillModel(
      name: 'Firebase',
      icon: FontAwesomeIcons.fire,
      category: 'Backend & DB',
    ),
    SkillModel(
      name: 'Local Storage',
      icon: FontAwesomeIcons.database,
      category: 'Backend & DB',
    ),
    SkillModel(
      name: 'Authentication',
      icon: FontAwesomeIcons.lock,
      category: 'Security & Services',
    ),
    SkillModel(
      name: 'Push Notifications',
      icon: FontAwesomeIcons.bell,
      category: 'Security & Services',
    ),
    SkillModel(
      name: 'Git & GitHub',
      icon: FontAwesomeIcons.github,
      category: 'DevOps & Tools',
    ),
  ];

  final List<ExperienceModel> experiences = const [
    ExperienceModel(
      title: 'Flutter Development Training',
      organization: 'Hardkore Tech, Mohali, Punjab',
      period: 'Nov 2025 - May 2026',
      description:
          'Completed 6 months of Flutter development training and worked on practical Flutter app projects using Firebase, state management, responsive UI, and clean architecture basics.',
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
