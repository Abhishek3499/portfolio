import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/premium_effects.dart';
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
    final width = Responsive.width(context);
    final crossAxisCount = width < 360 ? 2 : (isMobile ? 3 : (isTablet ? 4 : 5));

    return PremiumBackground(
      surface: true,
      child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionPadding(context),
        horizontal: Responsive.horizontalPadding(context),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScrollReveal(
                slideBegin: Offset(-0.06, 0),
                child: SectionTitle(
                  title: AppStrings.techTitle,
                  subtitle: 'Technologies I work with daily.',
                ),
              ),
              SizedBox(
                height: Responsive.isSmallPhone(context)
                    ? AppSpacing.xl
                    : AppSpacing.xxl,
              ),
              const _OrbitHeader().animate().fadeIn(duration: 650.ms),
              const SizedBox(height: AppSpacing.xl),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: Responsive.isSmallPhone(context)
                      ? AppSpacing.sm
                      : AppSpacing.md,
                  mainAxisSpacing: Responsive.isSmallPhone(context)
                      ? AppSpacing.sm
                      : AppSpacing.md,
                  childAspectRatio: width < 360 ? 0.92 : (isMobile ? 0.82 : 1.0),
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
      ),
    );
  }
}

class _OrbitHeader extends StatelessWidget {
  const _OrbitHeader();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      height: isMobile ? 120 : 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.border),
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.08),
            AppColors.accentSecondary.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (var i = 0; i < 3; i++)
            Container(
              width: 92.0 + i * 42,
              height: 92.0 + i * 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.12),
                ),
              ),
            ),
          ShaderMask(
            shaderCallback: AppColors.accentGradient.createShader,
            blendMode: BlendMode.srcIn,
            child: Icon(
              Icons.hub_outlined,
              size: isMobile ? 32 : 42,
              color: Colors.white,
            ),
          ),
          ...List.generate(6, (i) {
            final icons = [
              Icons.flutter_dash,
              Icons.code,
              Icons.cloud_outlined,
              Icons.storage_outlined,
              Icons.bolt_outlined,
              Icons.auto_awesome,
            ];
            final radius = isMobile ? 48.0 : 62.0;
            final angle = i * 1.047;
            return Transform.translate(
              offset: Offset(
                radius * math.cos(angle),
                radius * math.sin(angle),
              ),
              child: _OrbitChip(icon: icons[i], index: i),
            );
          }),
        ],
      ),
    );
  }
}

class _OrbitChip extends StatelessWidget {
  final IconData icon;
  final int index;

  const _OrbitChip({required this.icon, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.86),
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: AppColors.isDark ? 0.14 : 0.06,
            ),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Icon(icon, color: AppColors.accentSecondary, size: 17),
    )
        .animate(onPlay: (controller) => controller.repeat())
        .moveY(
          begin: 0,
          end: index.isEven ? -5 : 5,
          duration: (1400 + index * 120).ms,
          curve: Curves.easeInOut,
        )
        .then()
        .moveY(
          begin: index.isEven ? -5 : 5,
          end: 0,
          duration: (1400 + index * 120).ms,
          curve: Curves.easeInOut,
        );
  }
}
