import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';
import '../controllers/portfolio_controller.dart';
import '../models/experience_model.dart';

class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiences = ref.watch(portfolioProvider).experiences;

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
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ScrollReveal(
                slideBegin: Offset(-0.06, 0),
                child: SectionTitle(
                  title: AppStrings.experienceTitle,
                  subtitle: 'My journey and credentials.',
                ),
              ),
              SizedBox(
                height: Responsive.isSmallPhone(context)
                    ? AppSpacing.xl
                    : AppSpacing.xxl,
              ),
              ...experiences.asMap().entries.map(
                (e) =>
                    ScrollReveal(
                      delay: (e.key * 120).ms,
                      slideBegin: const Offset(-0.04, 0.04),
                      child: _ExperienceItem(
                          experience: e.value,
                          isLast: e.key == experiences.length - 1,
                        ),
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

class _ExperienceItem extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;

  const _ExperienceItem({required this.experience, required this.isLast});

  IconData get _icon {
    switch (experience.type) {
      case 'education':
        return Icons.school_outlined;
      case 'cert':
        return Icons.verified_outlined;
      default:
        return Icons.work_outline_rounded;
    }
  }

  Color get _color {
    switch (experience.type) {
      case 'education':
        return AppColors.accentSecondary;
      case 'cert':
        return const Color(0xFF10B981);
      default:
        return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isSmallPhone = Responsive.isSmallPhone(context);
    final iconSize = isSmallPhone ? 30.0 : (isMobile ? 34.0 : 40.0);
    final gap = isSmallPhone
        ? AppSpacing.sm
        : (isMobile ? AppSpacing.md : AppSpacing.lg);

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.lg),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: iconSize,
            child: Column(
              children: [
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color: _color.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                    border: Border.all(color: _color.withValues(alpha: 0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: _color.withValues(alpha: 0.22),
                        blurRadius: 18,
                      ),
                    ],
                  ),
                  child: Icon(_icon, color: _color, size: isMobile ? 16 : 18),
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: isSmallPhone ? 230 : (isMobile ? 210 : 170),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          _color.withValues(alpha: 0.7),
                          AppColors.border.withValues(alpha: 0.2),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: gap),
          Expanded(
            child: PremiumHover(
              lift: 4,
              child: GlassCard(
              padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ExperienceHeader(
                    experience: experience,
                    color: _color,
                    isMobile: isMobile,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    experience.organization,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 13,
                      color: _color,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: isMobile ? AppSpacing.sm : AppSpacing.md),
                  Text(
                    experience.description,
                    style: TextStyle(
                      fontSize: isMobile ? 13 : 14,
                      color: AppColors.textSecondary,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExperienceHeader extends StatelessWidget {
  final ExperienceModel experience;
  final Color color;
  final bool isMobile;

  const _ExperienceHeader({
    required this.experience,
    required this.color,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final title = Text(
      experience.title,
      softWrap: true,
      style: TextStyle(
        fontSize: isMobile ? 15 : 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );

    final period = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        experience.period,
        style: TextStyle(
          fontSize: 11,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SizedBox(height: AppSpacing.xs),
          period,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: title),
        const SizedBox(width: AppSpacing.sm),
        period,
      ],
    );
  }
}
