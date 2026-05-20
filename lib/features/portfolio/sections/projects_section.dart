import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projects = ref.watch(portfolioProvider).projects;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.section,
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                title: AppStrings.projectsTitle,
                subtitle: 'A selection of things I\'ve built.',
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: -0.1, end: 0),
              const SizedBox(height: AppSpacing.xxl),
              if (isMobile)
                Column(
                  children: projects
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                          child: ProjectCard(project: e.value)
                              .animate()
                              .fadeIn(delay: (e.key * 150).ms, duration: 600.ms)
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
    );
  }
}

class _DesktopProjectGrid extends StatelessWidget {
  final List projects;
  final bool isTablet;

  const _DesktopProjectGrid({required this.projects, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final cols = isTablet ? 2 : 3;
        final itemWidth = (constraints.maxWidth - (AppSpacing.lg * (cols - 1))) / cols;
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
