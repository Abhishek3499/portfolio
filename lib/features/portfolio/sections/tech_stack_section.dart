import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';
import '../controllers/portfolio_controller.dart';
import '../widgets/skill_card.dart';

class TechStackSection extends ConsumerWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final skills = ref.watch(portfolioProvider).skills;
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final crossAxisCount = isMobile ? 3 : (isTablet ? 4 : 5);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
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
                title: AppStrings.techTitle,
                subtitle: 'Technologies I work with daily.',
              )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideX(begin: -0.1, end: 0),
              const SizedBox(height: AppSpacing.xxl),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: isMobile ? 0.85 : 1.0,
                ),
                itemCount: skills.length,
                itemBuilder: (_, i) => SkillCard(skill: skills[i])
                    .animate()
                    .fadeIn(delay: (i * 80).ms, duration: 500.ms)
                    .scale(
                      begin: const Offset(0.85, 0.85),
                      end: const Offset(1, 1),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
