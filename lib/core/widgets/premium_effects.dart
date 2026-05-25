import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

class PremiumBackground extends StatelessWidget {
  final Widget child;
  final bool surface;

  const PremiumBackground({
    super.key,
    required this.child,
    this.surface = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PremiumBackgroundPainter(surface: surface),
      child: child,
    );
  }
}

class _PremiumBackgroundPainter extends CustomPainter {
  final bool surface;

  _PremiumBackgroundPainter({required this.surface});

  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = surface ? AppColors.surface : AppColors.background;
    canvas.drawRect(Offset.zero & size, base);

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.accent.withValues(alpha: AppColors.isDark ? 0.14 : 0.09),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.12, size.height * 0.12),
        radius: size.width * 0.42,
      ));
    canvas.drawCircle(
      Offset(size.width * 0.12, size.height * 0.12),
      size.width * 0.42,
      glowPaint,
    );

    final secondaryGlow = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.accentSecondary.withValues(alpha: AppColors.isDark ? 0.1 : 0.07),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(
        center: Offset(size.width * 0.9, size.height * 0.82),
        radius: size.width * 0.34,
      ));
    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.82),
      size.width * 0.34,
      secondaryGlow,
    );

    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: AppColors.isDark ? 0.18 : 0.34)
      ..strokeWidth = 0.7;
    const step = 48.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final noisePaint = Paint()
      ..color = AppColors.textPrimary.withValues(alpha: AppColors.isDark ? 0.018 : 0.025);
    for (double x = 6; x < size.width; x += 21) {
      for (double y = 8; y < size.height; y += 23) {
        if (((x + y).round() % 4) == 0) {
          canvas.drawCircle(Offset(x, y), 0.65, noisePaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _PremiumBackgroundPainter oldDelegate) {
    return oldDelegate.surface != surface;
  }
}

class ScrollReveal extends StatelessWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideBegin;
  final bool scale;
  final bool blur;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.slideBegin = const Offset(0, 0.08),
    this.scale = false,
    this.blur = false,
  });

  @override
  Widget build(BuildContext context) {
    var effect = child.animate().fadeIn(delay: delay, duration: duration);
    if (slideBegin != Offset.zero) {
      effect = effect.slide(
        begin: slideBegin,
        end: Offset.zero,
        curve: Curves.easeOutCubic,
      );
    }
    if (scale) {
      effect = effect.scale(
        begin: const Offset(0.94, 0.94),
        end: const Offset(1, 1),
        curve: Curves.easeOutCubic,
      );
    }
    if (blur) {
      effect = effect.blurXY(begin: 10, end: 0, curve: Curves.easeOutCubic);
    }
    return effect;
  }
}

class PremiumHover extends StatefulWidget {
  final Widget child;
  final double lift;
  final double scale;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;

  const PremiumHover({
    super.key,
    required this.child,
    this.lift = 6,
    this.scale = 1.015,
    this.borderRadius,
    this.onTap,
  });

  @override
  State<PremiumHover> createState() => _PremiumHoverState();
}

class _PremiumHoverState extends State<PremiumHover> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap == null ? MouseCursor.defer : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() {
        _hovered = false;
        _pressed = false;
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: Matrix4.identity()
            ..translate(0.0, _hovered ? -widget.lift : 0.0)
            ..scale(_pressed ? 0.985 : (_hovered ? widget.scale : 1.0)),
          child: widget.child,
        ),
      ),
    );
  }
}

class GradientBorder extends StatelessWidget {
  final Widget child;
  final bool active;
  final BorderRadius borderRadius;
  final EdgeInsets padding;

  const GradientBorder({
    super.key,
    required this.child,
    required this.active,
    required this.borderRadius,
    this.padding = const EdgeInsets.all(1.2),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: active
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.accent,
                  AppColors.accentSecondary,
                  AppColors.accent.withValues(alpha: 0.2),
                ],
              )
            : LinearGradient(colors: [AppColors.border, AppColors.border]),
      ),
      child: child,
    );
  }
}

class PremiumCursorLayer extends StatefulWidget {
  final Widget child;

  const PremiumCursorLayer({super.key, required this.child});

  @override
  State<PremiumCursorLayer> createState() => _PremiumCursorLayerState();
}

class _PremiumCursorLayerState extends State<PremiumCursorLayer> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class PremiumLoader extends StatelessWidget {
  final bool visible;

  const PremiumLoader({super.key, required this.visible});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: const Duration(milliseconds: 650),
        curve: Curves.easeOutCubic,
        child: Container(
          color: AppColors.background,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 78,
                  height: 78,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.accentGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.32),
                        blurRadius: 34,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'AS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scale(
                      begin: const Offset(0.96, 0.96),
                      end: const Offset(1.04, 1.04),
                      duration: 900.ms,
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .scale(
                      begin: const Offset(1.04, 1.04),
                      end: const Offset(0.96, 0.96),
                      duration: 900.ms,
                      curve: Curves.easeInOut,
                    ),
                const SizedBox(height: AppSpacing.lg),
                SizedBox(
                  width: 110,
                  child: LinearProgressIndicator(
                    minHeight: 2,
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
