import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';

class WhyHireMeSection extends StatelessWidget {
  const WhyHireMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _HirePoint(Icons.phone_android_rounded, 'Strong Flutter UI Development'),
      _HirePoint(Icons.cloud_done_outlined, 'Firebase Integration'),
      _HirePoint(Icons.account_tree_outlined, 'Riverpod State Management'),
      _HirePoint(Icons.devices_rounded, 'Responsive Design'),
      _HirePoint(Icons.bolt_outlined, 'Fast Learner'),
      _HirePoint(Icons.code_rounded, 'Clean Code Practices'),
      _HirePoint(
        Icons.groups_2_outlined,
        'Open to Feedback & Team Collaboration',
      ),
    ];

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
                    title: 'Why Hire Me?',
                    subtitle:
                        'Practical junior Flutter skills with a growth mindset.',
                  ),
                ),
                SizedBox(
                  height: Responsive.isSmallPhone(context)
                      ? AppSpacing.xl
                      : AppSpacing.xxl,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = Responsive.isMobile(context);
                    final cols = isMobile
                        ? 1
                        : (Responsive.isTablet(context) ? 2 : 3);
                    final width =
                        (constraints.maxWidth - AppSpacing.lg * (cols - 1)) /
                        cols;

                    return Wrap(
                      spacing: AppSpacing.lg,
                      runSpacing: AppSpacing.lg,
                      children: items.asMap().entries.map((entry) {
                        return SizedBox(
                          width: width,
                          child:
                              PremiumHover(
                                    lift: 4,
                                    child: GlassCard(
                                      padding: const EdgeInsets.all(
                                        AppSpacing.lg,
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 42,
                                            height: 42,
                                            decoration: BoxDecoration(
                                              gradient:
                                                  AppColors.accentGradient,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    AppSpacing.radiusMd,
                                                  ),
                                            ),
                                            child: Icon(
                                              entry.value.icon,
                                              color: AppColors.onAccent,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: AppSpacing.md),
                                          Expanded(
                                            child: Text(
                                              entry.value.label,
                                              style: TextStyle(
                                                color: AppColors.textPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                height: 1.35,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(
                                    delay: (entry.key * 80).ms,
                                    duration: 520.ms,
                                  )
                                  .slideY(begin: 0.08, end: 0),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HirePoint {
  final IconData icon;
  final String label;

  const _HirePoint(this.icon, this.label);
}
