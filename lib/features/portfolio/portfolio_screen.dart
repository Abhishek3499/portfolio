import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sections/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/tech_stack_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  final _scrollController = ScrollController();

  // Section keys for scroll navigation
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _aboutKey,
      _skillsKey,
      _projectsKey,
      _experienceKey,
      _contactKey,
    ];
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  onViewWork: () => _scrollTo(_projectsKey),
                  onContact: () => _scrollTo(_contactKey),
                ),
                KeyedSubtree(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
                KeyedSubtree(
                  key: _skillsKey,
                  child: const TechStackSection(),
                ),
                KeyedSubtree(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),
                KeyedSubtree(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),
                KeyedSubtree(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
                const FooterSection(),
              ],
            ),
          ),
          // Sticky NavBar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
