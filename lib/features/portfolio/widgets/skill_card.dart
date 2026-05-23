import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../responsive/responsive.dart';
import '../models/skill_model.dart';

class SkillCard extends StatefulWidget {
  final SkillModel skill;

  const SkillCard({super.key, required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallPhone = Responsive.isSmallPhone(context);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: PremiumHover(
        lift: 5,
        scale: 1.02,
        child: GradientBorder(
          active: _hovered,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            padding: EdgeInsets.all(isSmallPhone ? AppSpacing.md : AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: _hovered
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.surfaceElevated,
                        AppColors.accent.withValues(alpha: 0.12),
                      ],
                    )
                  : AppColors.cardGradient,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.18),
                        blurRadius: 22,
                        offset: const Offset(0, 7),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.14),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  padding: EdgeInsets.all(isSmallPhone ? AppSpacing.sm : AppSpacing.md),
                  decoration: BoxDecoration(
                    color: _hovered
                        ? AppColors.accent.withValues(alpha: 0.15)
                        : AppColors.accentGlow,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                    boxShadow: _hovered
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withValues(alpha: 0.22),
                              blurRadius: 18,
                            ),
                          ]
                        : null,
                  ),
                  child: FaIcon(
                    widget.skill.icon,
                    size: isSmallPhone ? 19 : 22,
                    color: _hovered ? AppColors.accent : AppColors.accentSecondary,
                  ),
                )
                    .animate(onPlay: (controller) {
                      if (_hovered) controller.repeat();
                    })
                    .moveY(
                      begin: 0,
                      end: _hovered ? -4 : 0,
                      duration: 700.ms,
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  widget.skill.name,
                  style: TextStyle(
                    fontSize: isSmallPhone ? 12 : 13,
                    fontWeight: FontWeight.w700,
                    color: _hovered
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  widget.skill.category,
                  style: TextStyle(
                    fontSize: isSmallPhone ? 10 : 11,
                    color: AppColors.textMuted,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: _hovered ? 0.92 : 0.72,
                    minHeight: 3,
                    backgroundColor: AppColors.border,
                    color: AppColors.accentSecondary,
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
