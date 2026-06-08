import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../responsive/responsive.dart';

class AvailabilityCtaSection extends StatelessWidget {
  final VoidCallback onContact;
  final VoidCallback onJourney;

  const AvailabilityCtaSection({
    super.key,
    required this.onContact,
    required this.onJourney,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isSmallPhone = Responsive.isSmallPhone(context);

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
            child: GradientBorder(
              active: true,
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              child: Container(
                padding: EdgeInsets.all(
                  isSmallPhone ? AppSpacing.lg : AppSpacing.xxl,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.surfaceElevated.withValues(
                        alpha: AppColors.isDark ? 0.84 : 0.96,
                      ),
                      AppColors.surface.withValues(
                        alpha: AppColors.isDark ? 0.68 : 0.9,
                      ),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.18),
                      blurRadius: 40,
                      offset: const Offset(0, 18),
                    ),
                  ],
                ),
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _CtaCopy(isSmallPhone: isSmallPhone),
                          const SizedBox(height: AppSpacing.xl),
                          _CtaButtons(
                            onContact: onContact,
                            onJourney: onJourney,
                            stretch: true,
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(child: _CtaCopy(isSmallPhone: isSmallPhone)),
                          const SizedBox(width: AppSpacing.xxl),
                          _CtaButtons(
                            onContact: onContact,
                            onJourney: onJourney,
                          ),
                        ],
                      ),
              ),
            ).animate().fadeIn(duration: 680.ms).slideY(begin: 0.08, end: 0),
          ),
        ),
      ),
    );
  }
}

class _CtaCopy extends StatelessWidget {
  final bool isSmallPhone;

  const _CtaCopy({required this.isSmallPhone});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.accentSecondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.accentSecondary.withValues(alpha: 0.24),
            ),
          ),
          child: Text(
            'Available Now',
            style: TextStyle(
              color: AppColors.accentSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Looking for a Junior Flutter Developer?',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isSmallPhone ? 25 : 36,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'I am currently open for internships, junior Flutter roles, and freelance projects.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: isSmallPhone ? 14 : 16,
            height: 1.65,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: const [
            _OpportunityChip(label: 'Internships'),
            _OpportunityChip(label: 'Junior Flutter Roles'),
            _OpportunityChip(label: 'Freelance Projects'),
          ],
        ),
      ],
    );
  }
}

class _OpportunityChip extends StatelessWidget {
  final String label;

  const _OpportunityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.interactiveText,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CtaButtons extends StatelessWidget {
  final VoidCallback onContact;
  final VoidCallback onJourney;
  final bool stretch;

  const _CtaButtons({
    required this.onContact,
    required this.onJourney,
    this.stretch = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      PrimaryButton(
        label: AppStrings.heroCtaSecondary,
        icon: Icons.mail_outline_rounded,
        onTap: onContact,
      ),
      PrimaryButton(
        label: AppStrings.journeyCta,
        icon: Icons.route_outlined,
        outlined: true,
        onTap: onJourney,
      ),
    ];

    if (stretch) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buttons[0],
          const SizedBox(height: AppSpacing.md),
          buttons[1],
        ],
      );
    }

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      alignment: WrapAlignment.end,
      children: buttons,
    );
  }
}
