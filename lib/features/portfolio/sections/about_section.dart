import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return _SectionWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: AppStrings.aboutTitle,
            subtitle: 'Passionate about building things that matter.',
          ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
          const SizedBox(height: AppSpacing.xxl),
          isMobile
              ? Column(
                  children: [
                    _BioCard(),
                    const SizedBox(height: AppSpacing.lg),
                    const _HighlightsGrid(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: _BioCard()),
                    const SizedBox(width: AppSpacing.xl),
                    const Expanded(flex: 4, child: _HighlightsGrid()),
                  ],
                ),
        ],
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: const Center(
                      child: Text(
                        'AS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppStrings.role,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.accentSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Text(
                AppStrings.aboutBio,
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textSecondary,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              const _SpecializationChips(),
            ],
          ),
        )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideY(begin: 0.1, end: 0);
  }
}

class _SpecializationChips extends StatelessWidget {
  const _SpecializationChips();

  @override
  Widget build(BuildContext context) {
    const specs = [
      'Clean Architecture',
      'State Management',
      'Responsive UI',
      'Performance',
      'Animations',
    ];
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: specs
          .map(
            (s) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.accentSecondary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.accentSecondary.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                s,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.accentSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _HighlightsGrid extends StatelessWidget {
  const _HighlightsGrid();

  @override
  Widget build(BuildContext context) {
    final items = [
      _HighlightData('6 mo', 'Flutter Training', Icons.work_outline_rounded),
      _HighlightData('2+', 'Projects Worked On', Icons.rocket_launch_outlined),
      _HighlightData('5+', 'Tech Mastered', Icons.code_rounded),
      _HighlightData('100%', 'Passion Driven', Icons.favorite_outline_rounded),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.3,
      children: items
          .asMap()
          .entries
          .map(
            (e) =>
                GlassCard(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(e.value.icon, color: AppColors.accent, size: 22),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            e.value.value,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            e.value.label,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textMuted,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                    .animate()
                    .fadeIn(delay: (300 + e.key * 100).ms, duration: 500.ms)
                    .scale(
                      begin: const Offset(0.9, 0.9),
                      end: const Offset(1, 1),
                    ),
          )
          .toList(),
    );
  }
}

class _HighlightData {
  final String value;
  final String label;
  final IconData icon;
  const _HighlightData(this.value, this.label, this.icon);
}

class _SectionWrapper extends StatelessWidget {
  final Widget child;
  const _SectionWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.section,
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
