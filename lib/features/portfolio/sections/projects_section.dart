import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';
import '../controllers/portfolio_controller.dart';
import '../models/project_model.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(portfolioProvider).projects;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final sectionGap = Responsive.isSmallPhone(context)
        ? AppSpacing.xl
        : AppSpacing.xxl;

    return PremiumBackground(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScrollReveal(
                  slideBegin: Offset(-0.06, 0),
                  child: SectionTitle(
                    title: AppStrings.projectsTitle,
                    subtitle: 'A selection of things I\'ve built.',
                  ),
                ),
                SizedBox(height: sectionGap),
                FeaturedProject(project: projects.first),
                SizedBox(height: sectionGap),
                if (isMobile)
                  Column(
                    children: projects
                        .asMap()
                        .entries
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.lg,
                            ),
                            child: ProjectCard(project: e.value)
                                .animate()
                                .fadeIn(
                                  delay: (e.key * 150).ms,
                                  duration: 600.ms,
                                )
                                .slideY(begin: 0.1, end: 0),
                          ),
                        )
                        .toList(),
                  )
                else
                  _DesktopProjectGrid(projects: projects, isTablet: isTablet),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DesktopProjectGrid extends StatelessWidget {
  final List<ProjectModel> projects;
  final bool isTablet;

  const _DesktopProjectGrid({required this.projects, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final cols = isTablet || Responsive.isCompactDesktop(context) ? 2 : 3;
        final itemWidth =
            (constraints.maxWidth - (AppSpacing.lg * (cols - 1))) / cols;
        return Wrap(
          spacing: AppSpacing.lg,
          runSpacing: AppSpacing.lg,
          children: projects
              .asMap()
              .entries
              .map(
                (e) => SizedBox(
                  width: itemWidth,
                  child: ProjectCard(project: e.value)
                      .animate()
                      .fadeIn(delay: (e.key * 150).ms, duration: 600.ms)
                      .slideY(begin: 0.1, end: 0),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class FeaturedProject extends StatelessWidget {
  final ProjectModel project;

  const FeaturedProject({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isSmallPhone = Responsive.isSmallPhone(context);
    return GradientBorder(
      active: true,
      borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
      child: Container(
        padding: EdgeInsets.all(
          isSmallPhone
              ? AppSpacing.md
              : (isMobile ? AppSpacing.lg : AppSpacing.xl),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surfaceElevated.withValues(
                alpha: AppColors.isDark ? 0.78 : 0.96,
              ),
              AppColors.surface.withValues(
                alpha: AppColors.isDark ? 0.62 : 0.86,
              ),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.18),
              blurRadius: 46,
              offset: const Offset(0, 22),
            ),
          ],
        ),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FeaturedCopy(project: project),
                  SizedBox(
                    height: isSmallPhone ? AppSpacing.lg : AppSpacing.xl,
                  ),
                  _DeviceMockup(project: project),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _FeaturedCopy(project: project)),
                  const SizedBox(width: AppSpacing.xxl),
                  Expanded(child: _DeviceMockup(project: project)),
                ],
              ),
      ),
    ).animate().fadeIn(duration: 700.ms).slideY(begin: 0.08, end: 0);
  }
}

class _FeaturedCopy extends StatelessWidget {
  final ProjectModel project;

  const _FeaturedCopy({required this.project});

  Future<void> _launch(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Project Case Study',
          style: TextStyle(
            color: AppColors.accentSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          project.title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: Responsive.isSmallPhone(context)
                ? 24
                : (Responsive.isMobile(context) ? 28 : 38),
            fontWeight: FontWeight.w800,
            height: 1.12,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _CaseStudyRow(
          label: 'Role',
          value: project.role ?? 'Flutter Developer',
        ),
        const SizedBox(height: AppSpacing.lg),
        _CaseStudyBlock(
          label: 'Problem',
          value: project.problem ?? project.description,
        ),
        const SizedBox(height: AppSpacing.md),
        _CaseStudyBlock(
          label: 'Solution',
          value: project.solution ?? project.description,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Tech',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: project.techTags
              .map(
                (tag) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.22),
                    ),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(
                      color: AppColors.accentSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Key Features',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: project.features
              .map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_rounded,
                        color: AppColors.accentSecondary,
                        size: 17,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppSpacing.xl),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            PrimaryButton(
              label: 'GitHub',
              icon: Icons.code_rounded,
              onTap: () => _launch(project.githubUrl),
            ),
            PrimaryButton(
              label: 'Live Demo',
              icon: Icons.arrow_outward_rounded,
              outlined: true,
              onTap: () => _launch(project.liveUrl ?? project.githubUrl),
            ),
          ],
        ),
      ],
    );
  }
}

class _CaseStudyRow extends StatelessWidget {
  final String label;
  final String value;

  const _CaseStudyRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.accentSecondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(
          color: AppColors.accentSecondary.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              color: AppColors.accentSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            value,
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

class _CaseStudyBlock extends StatelessWidget {
  final String label;
  final String value;

  const _CaseStudyBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          value,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            height: 1.65,
          ),
        ),
      ],
    );
  }
}

class _DeviceMockup extends StatelessWidget {
  final ProjectModel project;

  const _DeviceMockup({required this.project});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: Responsive.isSmallPhone(context) ? 0.92 : 1.15,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.accent.withValues(alpha: 0.24),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          Container(
                width: Responsive.isSmallPhone(context)
                    ? 190
                    : (Responsive.isMobile(context) ? 220 : 260),
                height: Responsive.isSmallPhone(context)
                    ? 285
                    : (Responsive.isMobile(context) ? 330 : 380),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(color: AppColors.borderLight),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: AppColors.isDark ? 0.32 : 0.12,
                      ),
                      blurRadius: 36,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF111827),
                        AppColors.accent.withValues(alpha: 0.64),
                        const Color(0xFF020617),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(
                                      0xFFEF4444,
                                    ).withValues(alpha: 0.62),
                                    const Color(
                                      0xFF7C3AED,
                                    ).withValues(alpha: 0.3),
                                    const Color(0xFF020617),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          left: 12,
                          right: 12,
                          child: Row(
                            children: [
                              _MockupPill(label: 'Following'),
                              const SizedBox(width: AppSpacing.sm),
                              _MockupPill(label: 'For You', active: true),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 10,
                          bottom: 70,
                          child: Column(
                            children: const [
                              _MockupAction(
                                icon: Icons.favorite_rounded,
                                label: '12.8K',
                              ),
                              SizedBox(height: AppSpacing.md),
                              _MockupAction(
                                icon: Icons.mode_comment_rounded,
                                label: '842',
                              ),
                              SizedBox(height: AppSpacing.md),
                              _MockupAction(
                                icon: Icons.share_rounded,
                                label: 'Share',
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 14,
                          right: 58,
                          bottom: 18,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: AppColors.accentGradient,
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  const Expanded(
                                    child: Text(
                                      '@Gruve.app',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Text(
                                'Short videos, smooth swipes, social moments.',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              Container(
                                height: 4,
                                width: 118,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: AppColors.accentGradient,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: 58,
                            height: 58,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.14),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.28),
                              ),
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .animate(onPlay: (controller) => controller.repeat())
              .moveY(
                begin: 0,
                end: -8,
                duration: 1800.ms,
                curve: Curves.easeInOut,
              )
              .then()
              .moveY(
                begin: -8,
                end: 0,
                duration: 1800.ms,
                curve: Curves.easeInOut,
              ),
        ],
      ),
    );
  }
}

class _MockupPill extends StatelessWidget {
  final String label;
  final bool active;

  const _MockupPill({required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: active ? 0.18 : 0.08),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white.withValues(alpha: active ? 1 : 0.72),
          fontSize: 11,
          fontWeight: active ? FontWeight.w800 : FontWeight.w600,
        ),
      ),
    );
  }
}

class _MockupAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MockupAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.86),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
