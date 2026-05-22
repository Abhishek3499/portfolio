import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool outlined;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.outlined = false,
    this.icon,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final contentColor = widget.outlined
        ? (_hovered ? AppColors.accent : AppColors.interactiveText)
        : AppColors.onAccent;
    final outlinedFill = _hovered
        ? AppColors.interactiveSurface
        : AppColors.surface.withValues(alpha: AppColors.isDark ? 0.04 : 0.72);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: widget.outlined ? outlinedFill : null,
            gradient: widget.outlined
                ? null
                : (_hovered
                    ? const LinearGradient(
                        colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                      )
                    : AppColors.accentGradient),
            border: widget.outlined
                ? Border.all(
                    color: _hovered ? AppColors.accent : AppColors.borderLight,
                    width: 1.5,
                  )
                : null,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: !widget.outlined && _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    )
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 16, color: contentColor),
                const SizedBox(width: AppSpacing.sm),
              ],
              Text(
                widget.label,
                style: TextStyle(
                  color: contentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
