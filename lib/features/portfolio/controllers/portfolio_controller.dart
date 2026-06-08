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
      title: 'Gruve App',
      description:
          'A responsive social and communication platform using Flutter and Firebase with modern UI, authentication, chat functionality, and state management.',
      techTags: [
        'Flutter',
        'Firebase',
        'Riverpod',
        'REST API',
        'Chat',
        'Responsive UI',
      ],
      features: [
        'Authentication',
        'Real-time Chat',
        'Push Notifications',
        'Responsive Design',
        'Clean UI Architecture',
      ],
      role: 'Flutter Developer',
      problem:
          'Users needed a modern, responsive, and seamless real-time social platform that maintains consistent performance across web and mobile viewports.',
      solution:
          'Developed the Gruve platform using Flutter Web/Mobile, integrated real-time Firestore database with Riverpod state management, and built clean custom UI widgets.',
      githubUrl: 'https://github.com/Abhishek3499',
      emoji: 'Gruve',
    ),
    ProjectModel(
      title: 'Weather App',
      description:
          'A weather forecasting application providing real-time weather details and hourly/weekly forecasts.',
      techTags: ['Flutter', 'REST API', 'Dart', 'Responsive UI'],
      features: [
        'Weather Forecast',
        'REST API Integration',
        'Clean UI',
        'Responsive Layout',
        'Error Handling',
      ],
      githubUrl: 'https://github.com/Abhishek3499',
      emoji: 'Cloud',
    ),
    ProjectModel(
      title: 'Finance Management App',
      description:
          'An expense tracking and personal finance application with visual dashboard analytics and category management.',
      techTags: ['Flutter', 'Riverpod', 'SQLite', 'Charts'],
      features: [
        'Expense Tracking',
        'Dashboard Analytics',
        'Modern UI',
        'State Management',
      ],
      githubUrl: 'https://github.com/Abhishek3499',
      emoji: 'Chart',
    ),
    ProjectModel(
      title: 'E-Commerce App',
      description:
          'A modern e-commerce shopping experience with product catalog, search filtering, and cart integration.',
      techTags: ['Flutter', 'Firebase Auth', 'Firestore', 'Provider'],
      features: [
        'Product Catalog',
        'Cart System',
        'Responsive UI',
        'Firebase Backend',
      ],
      githubUrl: 'https://github.com/Abhishek3499',
      emoji: 'Bag',
    ),
    ProjectModel(
      title: 'Sports Management App UI',
      description:
          'A premium sports management dashboard showcasing responsive design and micro-animations for booking events.',
      techTags: ['Flutter', 'Animations', 'Responsive UI', 'Custom Painter'],
      features: [
        'Modern Sports Dashboard',
        'Responsive Design',
        'Custom Animations',
      ],
      githubUrl: 'https://github.com/Abhishek3499',
      emoji: 'Trophy',
    ),
  ];

  final List<SkillModel> skills = const [
    // Framework & Language
    SkillModel(
      name: 'Flutter',
      icon: FontAwesomeIcons.mobile,
      category: 'Framework & Language',
    ),
    SkillModel(
      name: 'Dart',
      icon: FontAwesomeIcons.code,
      category: 'Framework & Language',
    ),
    // State Management
    SkillModel(
      name: 'Riverpod',
      icon: FontAwesomeIcons.layerGroup,
      category: 'State Management',
    ),
    SkillModel(
      name: 'GetX',
      icon: FontAwesomeIcons.bolt,
      category: 'State Management',
    ),
    SkillModel(
      name: 'Provider',
      icon: FontAwesomeIcons.puzzlePiece,
      category: 'State Management',
    ),
    // Architecture
    SkillModel(
      name: 'Clean Architecture',
      icon: FontAwesomeIcons.cubes,
      category: 'Architecture',
    ),
    // API & Integration
    SkillModel(
      name: 'REST APIs',
      icon: FontAwesomeIcons.plug,
      category: 'API & Integration',
    ),
    SkillModel(
      name: 'API Integration',
      icon: FontAwesomeIcons.cloud,
      category: 'API & Integration',
    ),
    // UI/UX
    SkillModel(
      name: 'Responsive UI',
      icon: FontAwesomeIcons.laptop,
      category: 'UI/UX',
    ),
    SkillModel(
      name: 'Material Design',
      icon: FontAwesomeIcons.palette,
      category: 'UI/UX',
    ),
    SkillModel(
      name: 'Custom Animations',
      icon: FontAwesomeIcons.wandMagicSparkles,
      category: 'UI/UX',
    ),
    SkillModel(
      name: 'Dark/Light Themes',
      icon: FontAwesomeIcons.circleHalfStroke,
      category: 'UI/UX',
    ),
    // Backend
    SkillModel(
      name: 'Firebase',
      icon: FontAwesomeIcons.fire,
      category: 'Backend',
    ),
    SkillModel(
      name: 'Local Storage',
      icon: FontAwesomeIcons.database,
      category: 'Backend',
    ),
    // Services
    SkillModel(
      name: 'Authentication',
      icon: FontAwesomeIcons.lock,
      category: 'Services',
    ),
    SkillModel(
      name: 'Push Notifications',
      icon: FontAwesomeIcons.bell,
      category: 'Services',
    ),
    // Tools
    SkillModel(
      name: 'Git',
      icon: FontAwesomeIcons.gitAlt,
      category: 'Tools',
    ),
    SkillModel(
      name: 'GitHub',
      icon: FontAwesomeIcons.github,
      category: 'Tools',
    ),
    SkillModel(
      name: 'VS Code',
      icon: FontAwesomeIcons.laptopCode,
      category: 'Tools',
    ),
    SkillModel(
      name: 'Android Studio',
      icon: FontAwesomeIcons.android,
      category: 'Tools',
    ),
    SkillModel(
      name: 'Postman',
      icon: FontAwesomeIcons.circleDot,
      category: 'Tools',
    ),
    SkillModel(
      name: 'Figma',
      icon: FontAwesomeIcons.figma,
      category: 'Tools',
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
