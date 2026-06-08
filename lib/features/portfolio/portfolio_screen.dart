import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/premium_effects.dart';
import '../journey/journey_page.dart';
import 'sections/nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/tech_stack_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'sections/why_hire_me_section.dart';
import 'sections/currently_learning_section.dart';
import 'sections/availability_cta_section.dart';
import 'sections/footer_section.dart';

class PortfolioScreen extends ConsumerStatefulWidget {
  const PortfolioScreen({super.key});

  @override
  ConsumerState<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends ConsumerState<PortfolioScreen> {
  final _scrollController = ScrollController();
  double _scrollProgress = 0;
  int _activeSectionIndex = -1;
  bool _showLoader = true;

  // Section keys for scroll navigation
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _whyHireKey = GlobalKey();
  final _learningKey = GlobalKey();
  final _contactKey = GlobalKey();

  late final List<GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = [
      _heroKey,
      _aboutKey,
      _skillsKey,
      _projectsKey,
      _experienceKey,
      _whyHireKey,
      _learningKey,
      _contactKey,
    ];
    _scrollController.addListener(_handleScroll);
    Future<void>.delayed(const Duration(milliseconds: 1250), () {
      if (mounted) setState(() => _showLoader = false);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    final position = _scrollController.position;
    final progress = position.maxScrollExtent == 0
        ? 0.0
        : (position.pixels / position.maxScrollExtent).clamp(0.0, 1.0);
    final activeIndex = _calculateActiveSection();

    if ((progress - _scrollProgress).abs() > 0.003 ||
        activeIndex != _activeSectionIndex) {
      setState(() {
        _scrollProgress = progress;
        _activeSectionIndex = activeIndex;
      });
    }
  }

  int _calculateActiveSection() {
    final viewportCenter = MediaQuery.of(context).size.height * 0.38;
    var closestIndex = -1;
    var closestDistance = double.infinity;

    for (var i = 0; i < _sectionKeys.length; i++) {
      final ctx = _sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final y = box.localToGlobal(Offset.zero).dy;
      final distance = (y - viewportCenter).abs();
      if (distance < closestDistance) {
        closestDistance = distance;
        closestIndex = i;
      }
    }

    return closestIndex;
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

  void _openJourney() {
    Navigator.of(context).pushNamed(JourneyPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return PremiumCursorLayer(
      child: Scaffold(
        body: Stack(
          children: [
            TweenAnimationBuilder<double>(
              key: ValueKey(AppColors.isDark),
              tween: Tween(begin: 0.985, end: 1),
              duration: const Duration(milliseconds: 520),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: AnimatedOpacity(
                    opacity: value,
                    duration: const Duration(milliseconds: 520),
                    child: child!,
                  ),
                );
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    KeyedSubtree(
                      key: _heroKey,
                      child: HeroSection(
                        onViewWork: () => _scrollTo(_projectsKey),
                        onContact: () => _scrollTo(_contactKey),
                        onJourney: _openJourney,
                      ),
                    ),
                    KeyedSubtree(key: _aboutKey, child: const AboutSection()),
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
                      key: _whyHireKey,
                      child: const WhyHireMeSection(),
                    ),
                    KeyedSubtree(
                      key: _learningKey,
                      child: const CurrentlyLearningSection(),
                    ),
                    KeyedSubtree(
                      key: _contactKey,
                      child: const ContactSection(),
                    ),
                    AvailabilityCtaSection(
                      onContact: () => _scrollTo(_contactKey),
                      onJourney: _openJourney,
                    ),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: NavBar(
                scrollController: _scrollController,
                sectionKeys: _sectionKeys,
                activeIndex: _activeSectionIndex,
                onJourney: _openJourney,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _ScrollProgressBar(progress: _scrollProgress),
            ),
            PremiumLoader(visible: _showLoader),
          ],
        ),
      ),
    );
  }
}

class _ScrollProgressBar extends StatelessWidget {
  final double progress;

  const _ScrollProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: FractionallySizedBox(
        widthFactor: progress,
        child: Container(
          height: 3,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.45),
                blurRadius: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
