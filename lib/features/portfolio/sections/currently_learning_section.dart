import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';

class CurrentlyLearningSection extends StatelessWidget {
  const CurrentlyLearningSection({super.key});

  @override
  Widget build(BuildContext context) {
    const topics = [
      'Clean Architecture',
      'Advanced Riverpod',
      'Flutter Web Optimization',
      'Unit & Widget Testing',
      'Firebase Security Rules',
    ];

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
                    title: 'Currently Learning',
                    subtitle:
                        'Areas I am actively improving for production Flutter work.',
                  ),
                ),
                SizedBox(
                  height: Responsive.isSmallPhone(context)
                      ? AppSpacing.xl
                      : AppSpacing.xxl,
                ),
                Container(
                      padding: EdgeInsets.all(
                        Responsive.isSmallPhone(context)
                            ? AppSpacing.lg
                            : AppSpacing.xl,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppSpacing.radiusXl,
                        ),
                        gradient: AppColors.cardGradient,
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            blurRadius: 32,
                            offset: const Offset(0, 14),
                          ),
                        ],
                      ),
                      child: Wrap(
                        spacing: AppSpacing.md,
                        runSpacing: AppSpacing.md,
                        children: topics.asMap().entries.map((entry) {
                          return _LearningChip(label: entry.value)
                              .animate()
                              .fadeIn(
                                delay: (entry.key * 90).ms,
                                duration: 500.ms,
                              )
                              .scale(
                                begin: const Offset(0.94, 0.94),
                                end: const Offset(1, 1),
                              );
                        }).toList(),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 650.ms)
                    .slideY(begin: 0.08, end: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LearningChip extends StatelessWidget {
  final String label;

  const _LearningChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.trending_up_rounded,
            size: 16,
            color: AppColors.accentSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: Responsive.isSmallPhone(context) ? 12 : 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
