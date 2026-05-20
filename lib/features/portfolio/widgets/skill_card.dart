import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
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
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: _hovered
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E2A45), Color(0xFF1A2235)],
                )
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: _hovered
                    ? AppColors.accent.withValues(alpha: 0.15)
                    : AppColors.accentGlow,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: FaIcon(
                widget.skill.icon,
                size: 22,
                color: _hovered ? AppColors.accent : AppColors.accentSecondary,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              widget.skill.name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _hovered ? AppColors.textPrimary : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              widget.skill.category,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textMuted,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
