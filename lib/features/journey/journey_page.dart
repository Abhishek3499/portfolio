import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_strings.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/premium_effects.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_title.dart';
import '../../responsive/responsive.dart';
import '../portfolio/controllers/portfolio_controller.dart';
import '../portfolio/models/project_model.dart';

class JourneyPage extends ConsumerWidget {
  static const routeName = '/journey';

  const JourneyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolio = ref.watch(portfolioProvider);

    return PremiumCursorLayer(
      child: Scaffold(
        body: PremiumBackground(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    _JourneyHero(projectCount: portfolio.projects.length),
                    const _AboutJourneySection(),
                    const _SkillsJourneySection(),
                    const _ExperienceJourneySection(),
                    const _EducationJourneySection(),
                    _JourneyProjectsSection(projects: portfolio.projects),
                    const _JourneyContactSection(),
                  ],
                ),
              ),
              const _JourneyTopBar(),
            ],
          ),
        ),
      ),
    );
  }
}

class _JourneyTopBar extends StatelessWidget {
  const _JourneyTopBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: AppSpacing.navHeight,
        decoration: BoxDecoration(
          color: AppColors.surface.withValues(alpha: 0.9),
          border: Border(bottom: BorderSide(color: AppColors.border)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: AppColors.isDark ? 0.22 : 0.06,
              ),
              blurRadius: 18,
            ),
          ],
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxContentWidth,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
              ),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Back to portfolio',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  ShaderMask(
                    shaderCallback: AppColors.accentGradient.createShader,
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      'My Journey',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: Responsive.isSmallPhone(context) ? 17 : 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (!Responsive.isSmallPhone(context))
                    Text(
                      'Premium profile',
                      style: TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _JourneyHero extends StatelessWidget {
  final int projectCount;

  const _JourneyHero({required this.projectCount});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isSmallPhone = Responsive.isSmallPhone(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppColors.heroGradient),
      padding: EdgeInsets.fromLTRB(
        Responsive.horizontalPadding(context),
        AppSpacing.navHeight + Responsive.sectionPadding(context),
        Responsive.horizontalPadding(context),
        Responsive.sectionPadding(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _JourneyHeroCopy(isSmallPhone: isSmallPhone),
                    const SizedBox(height: AppSpacing.xl),
                    _JourneySnapshot(projectCount: projectCount),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: _JourneyHeroCopy(isSmallPhone: isSmallPhone),
                    ),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(
                      flex: 4,
                      child: _JourneySnapshot(projectCount: projectCount),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _JourneyHeroCopy extends StatelessWidget {
  final bool isSmallPhone;

  const _JourneyHeroCopy({required this.isSmallPhone});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Pill(label: 'Open for Internship & Freelance Opportunities'),
        const SizedBox(height: AppSpacing.xl),
        Text(
          AppStrings.name,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isSmallPhone
                ? 34
                : (Responsive.isMobile(context) ? 42 : 64),
            fontWeight: FontWeight.w900,
            height: 1.05,
          ),
        ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.12, end: 0),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Junior Flutter Developer',
          style: TextStyle(
            color: AppColors.accentSecondary,
            fontSize: isSmallPhone
                ? 23
                : (Responsive.isMobile(context) ? 28 : 38),
            fontWeight: FontWeight.w800,
          ),
        ).animate().fadeIn(delay: 130.ms, duration: 650.ms),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '6 Months Professional Internship Experience',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isSmallPhone ? 15 : 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Flutter - Firebase - Riverpod',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isSmallPhone ? 14 : 16,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

class _JourneySnapshot extends StatelessWidget {
  final int projectCount;

  const _JourneySnapshot({required this.projectCount});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatData('6 mo', 'Internship Experience'),
      _StatData('$projectCount+', 'Real Flutter Projects'),
      _StatData('7', 'Core Skills'),
      _StatData('Open', 'Roles & Freelance'),
    ];

    return GradientBorder(
          active: true,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          child: GlassCard(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Snapshot',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 1.18,
                  children: stats
                      .map(
                        (stat) => Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(
                              AppSpacing.radiusMd,
                            ),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                stat.value,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                stat.label,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: 11,
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: 220.ms, duration: 700.ms)
        .scale(begin: const Offset(0.96, 0.96), end: const Offset(1, 1));
  }
}

class _AboutJourneySection extends StatelessWidget {
  const _AboutJourneySection();

  @override
  Widget build(BuildContext context) {
    return _JourneySection(
      surface: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            slideBegin: Offset(-0.05, 0),
            child: SectionTitle(
              title: 'About Me',
              subtitle: 'A concise professional summary for recruiters.',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          GlassCard(
            child: Text(
              'I am a junior Flutter developer with 6 months of professional internship experience at Hardkore Tech. I build responsive Flutter interfaces, connect apps with Firebase and REST APIs, and manage app state with Riverpod. I am focused on clean implementation, practical problem solving, and growing through real project work, feedback, and team collaboration.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: Responsive.isSmallPhone(context) ? 14 : 16,
                height: 1.8,
              ),
            ),
          ).animate().fadeIn(duration: 650.ms).slideY(begin: 0.08, end: 0),
        ],
      ),
    );
  }
}

class _SkillsJourneySection extends StatelessWidget {
  const _SkillsJourneySection();

  @override
  Widget build(BuildContext context) {
    const skills = [
      'Flutter',
      'Dart',
      'Firebase',
      'REST APIs',
      'Riverpod',
      'Git/GitHub',
      'Responsive UI',
    ];

    return _JourneySection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            slideBegin: Offset(-0.05, 0),
            child: SectionTitle(
              title: 'Skills',
              subtitle: 'Core tools I use for Flutter app development.',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.md,
            children: skills.asMap().entries.map((entry) {
              return _SkillBadge(label: entry.value)
                  .animate()
                  .fadeIn(delay: (entry.key * 70).ms, duration: 500.ms)
                  .slideY(begin: 0.08, end: 0);
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _ExperienceJourneySection extends StatelessWidget {
  const _ExperienceJourneySection();

  @override
  Widget build(BuildContext context) {
    return _JourneySection(
      surface: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            slideBegin: Offset(-0.05, 0),
            child: SectionTitle(
              title: 'Experience',
              subtitle:
                  'Professional internship and practical responsibilities.',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          _TimelineCard(
            icon: Icons.work_outline_rounded,
            title: 'Flutter Developer Intern',
            organization: 'Hardkore Tech',
            period: 'Nov 2025 - May 2026',
            bullets: const [
              'Built responsive Flutter screens for mobile and web layouts.',
              'Practiced Firebase integration for authentication and backend workflows.',
              'Worked with state management concepts including Riverpod and GetX.',
              'Improved UI consistency, spacing, animations, and reusable widgets.',
              'Collaborated through feedback and iterative implementation.',
            ],
          ),
        ],
      ),
    );
  }
}

class _EducationJourneySection extends StatelessWidget {
  const _EducationJourneySection();

  @override
  Widget build(BuildContext context) {
    return _JourneySection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            slideBegin: Offset(-0.05, 0),
            child: SectionTitle(
              title: 'Education',
              subtitle: 'Academic foundation in computer applications.',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = Responsive.isMobile(context);
              return Wrap(
                spacing: AppSpacing.lg,
                runSpacing: AppSpacing.lg,
                children: [
                  SizedBox(
                    width: isMobile
                        ? constraints.maxWidth
                        : (constraints.maxWidth - AppSpacing.lg) / 2,
                    child: _TimelineCard(
                      icon: Icons.school_outlined,
                      title: 'Bachelor of Computer Applications',
                      organization: 'Govt. Degree College, Sarkaghat',
                      period: '2019 - 2022',
                      bullets: const [
                        'Built fundamentals in programming and databases.',
                        'Studied computer applications and software basics.',
                      ],
                    ),
                  ),
                  SizedBox(
                    width: isMobile
                        ? constraints.maxWidth
                        : (constraints.maxWidth - AppSpacing.lg) / 2,
                    child: _TimelineCard(
                      icon: Icons.workspace_premium_outlined,
                      title: 'Master of Computer Applications',
                      organization: 'Shoolini University, Solan, HP',
                      period: '2023 - 2025',
                      bullets: const [
                        'Studied application development and software engineering.',
                        'Practiced data structures, algorithms, and modern development.',
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _JourneyProjectsSection extends StatelessWidget {
  final List<ProjectModel> projects;

  const _JourneyProjectsSection({required this.projects});

  @override
  Widget build(BuildContext context) {
    return _JourneySection(
      surface: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            slideBegin: Offset(-0.05, 0),
            child: SectionTitle(
              title: 'Projects',
              subtitle: 'Real Flutter project work with features and links.',
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = Responsive.isMobile(context);
              final cols = isMobile
                  ? 1
                  : (Responsive.isTablet(context) ? 2 : 3);
              final width =
                  (constraints.maxWidth - AppSpacing.lg * (cols - 1)) / cols;

              return Wrap(
                spacing: AppSpacing.lg,
                runSpacing: AppSpacing.lg,
                children: projects.asMap().entries.map((entry) {
                  return SizedBox(
                    width: width,
                    child: _JourneyProjectCard(project: entry.value)
                        .animate()
                        .fadeIn(delay: (entry.key * 100).ms, duration: 560.ms)
                        .slideY(begin: 0.08, end: 0),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _JourneyContactSection extends StatelessWidget {
  const _JourneyContactSection();

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _JourneySection(
      child: GradientBorder(
        active: true,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        child: GlassCard(
          padding: EdgeInsets.all(
            Responsive.isSmallPhone(context) ? AppSpacing.lg : AppSpacing.xxl,
          ),
          child: Column(
            children: [
              Text(
                'Let\'s Build Something',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: Responsive.isSmallPhone(context) ? 26 : 38,
                  fontWeight: FontWeight.w900,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Open for internships, junior Flutter roles, and freelance projects.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: Responsive.isSmallPhone(context) ? 14 : 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Wrap(
                spacing: AppSpacing.md,
                runSpacing: AppSpacing.md,
                alignment: WrapAlignment.center,
                children: [
                  PrimaryButton(
                    label: 'Email Me',
                    icon: Icons.mail_outline_rounded,
                    onTap: () => _launch('mailto:${AppStrings.email}'),
                  ),
                  PrimaryButton(
                    label: 'GitHub',
                    icon: Icons.code_rounded,
                    outlined: true,
                    onTap: () => _launch(AppStrings.github),
                  ),
                  PrimaryButton(
                    label: 'LinkedIn',
                    icon: Icons.business_center_outlined,
                    outlined: true,
                    onTap: () => _launch(AppStrings.linkedIn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 680.ms).slideY(begin: 0.08, end: 0),
    );
  }
}

class _JourneySection extends StatelessWidget {
  final Widget child;
  final bool surface;

  const _JourneySection({required this.child, this.surface = false});

  @override
  Widget build(BuildContext context) {
    return PremiumBackground(
      surface: surface,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Responsive.sectionPadding(context),
          horizontal: Responsive.horizontalPadding(context),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxContentWidth,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _TimelineCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String organization;
  final String period;
  final List<String> bullets;

  const _TimelineCard({
    required this.icon,
    required this.title,
    required this.organization,
    required this.period,
    required this.bullets,
  });

  @override
  Widget build(BuildContext context) {
    return PremiumHover(
      lift: 4,
      child: GlassCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: AppColors.accentGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.22),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: Icon(icon, color: AppColors.onAccent, size: 20),
                ),
                Container(
                  width: 2,
                  height: 124,
                  margin: const EdgeInsets.only(top: AppSpacing.sm),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.accentSecondary,
                        AppColors.border.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    organization,
                    style: TextStyle(
                      color: AppColors.accentSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _Pill(label: period, compact: true),
                  const SizedBox(height: AppSpacing.md),
                  ...bullets.map(
                    (bullet) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: AppColors.accentSecondary,
                            size: 16,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              bullet,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 620.ms).slideY(begin: 0.08, end: 0);
  }
}

class _JourneyProjectCard extends StatelessWidget {
  final ProjectModel project;

  const _JourneyProjectCard({required this.project});

  Future<void> _launch(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PremiumHover(
      lift: 5,
      child: GradientBorder(
        active: true,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            gradient: AppColors.cardGradient,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProjectScreenshot(project: project),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      project.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        height: 1.55,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.sm,
                      runSpacing: AppSpacing.sm,
                      children: project.techTags
                          .take(3)
                          .map((tag) => _MiniTag(label: tag))
                          .toList(),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    PrimaryButton(
                      label: 'GitHub',
                      icon: Icons.code_rounded,
                      outlined: true,
                      onTap: () => _launch(project.githubUrl),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectScreenshot extends StatelessWidget {
  final ProjectModel project;

  const _ProjectScreenshot({required this.project});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.65,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppSpacing.radiusLg),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.accent.withValues(alpha: 0.34),
              AppColors.accentSecondary.withValues(alpha: 0.18),
              AppColors.surface,
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.82),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Stack(
            children: [
              Positioned(
                left: AppSpacing.md,
                top: AppSpacing.md,
                right: AppSpacing.md,
                child: Row(
                  children: [
                    _Dot(color: const Color(0xFFEF4444)),
                    const SizedBox(width: 6),
                    _Dot(color: const Color(0xFFF59E0B)),
                    const SizedBox(width: 6),
                    _Dot(color: const Color(0xFF10B981)),
                    const Spacer(),
                    _MiniTag(label: 'Flutter UI'),
                  ],
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 54,
                      height: 54,
                      decoration: BoxDecoration(
                        gradient: AppColors.accentGradient,
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd,
                        ),
                      ),
                      child: Icon(
                        Icons.phone_android_rounded,
                        color: AppColors.onAccent,
                        size: 26,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                      ),
                      child: Text(
                        project.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillBadge extends StatelessWidget {
  final String label;

  const _SkillBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated.withValues(
          alpha: AppColors.isDark ? 0.72 : 0.96,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_rounded, color: AppColors.accentSecondary, size: 17),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniTag extends StatelessWidget {
  final String label;

  const _MiniTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.accentSecondary,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String label;
  final bool compact;

  const _Pill({required this.label, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 10 : 13,
        vertical: compact ? 5 : 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentSecondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: AppColors.accentSecondary.withValues(alpha: 0.24),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.accentSecondary,
          fontSize: compact ? 11 : 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;

  const _Dot({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _StatData {
  final String value;
  final String label;

  const _StatData(this.value, this.label);
}
