import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../responsive/responsive.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  Offset _mouse = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isSmallPhone = Responsive.isSmallPhone(context);
    final size = MediaQuery.of(context).size;
    final parallax = isMobile
        ? Offset.zero
        : Offset(
            (_mouse.dx - size.width / 2) / size.width,
            (_mouse.dy - size.height / 2) / size.height,
          );

    return MouseRegion(
      onHover: (event) => setState(() => _mouse = event.localPosition),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: size.height),
        decoration: BoxDecoration(gradient: AppColors.heroGradient),
        child: Stack(
          children: [
            Positioned.fill(child: CustomPaint(painter: _ParticlePainter())),
            Positioned(
              top: -120 + parallax.dy * 24,
              left: -110 + parallax.dx * 36,
              child: _GlowBlob(
                color: AppColors.accent.withValues(alpha: 0.15),
                size: 520,
                drift: const Offset(18, 12),
              ),
            ),
            Positioned(
              bottom: -40 - parallax.dy * 18,
              right: -90 - parallax.dx * 32,
              child: _GlowBlob(
                color: AppColors.accentSecondary.withValues(alpha: 0.1),
                size: 430,
                drift: const Offset(-16, 14),
              ),
            ),
            Positioned(
              top: size.height * 0.28 + parallax.dy * 30,
              right: isMobile ? -80 : size.width * 0.12 + parallax.dx * 44,
              child: _OrbitBadge(),
            ),
            Center(
              child: Transform.translate(
                offset: Offset(parallax.dx * -18, parallax.dy * -12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: AppSpacing.maxContentWidth,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.horizontalPadding(context),
                      vertical: Responsive.sectionPadding(context),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: isMobile ? AppSpacing.xxxl : AppSpacing.xxl,
                        ),
                        _Badge()
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 650.ms)
                            .slideY(begin: 0.3, end: 0),
                        const SizedBox(height: AppSpacing.xl),
                        _GlowingName(
                              fontSize: isSmallPhone
                                  ? 30
                                  : (isMobile ? 36 : (isTablet ? 52 : 68)),
                            )
                            .animate()
                            .fadeIn(delay: 340.ms, duration: 850.ms)
                            .slideY(begin: 0.22, end: 0),
                        const SizedBox(height: AppSpacing.md),
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            _gradientTypewriter(context, 'Flutter Developer'),
                            _gradientTypewriter(context, 'Mobile Engineer'),
                            _gradientTypewriter(context, 'UI/UX Craftsman'),
                          ],
                        ).animate().fadeIn(delay: 520.ms, duration: 700.ms),
                        const SizedBox(height: AppSpacing.xl),
                        ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 560),
                              child: Text(
                                AppStrings.tagline,
                                style: TextStyle(
                                  fontSize: isSmallPhone ? 14 : (isMobile ? 15 : 17),
                                  color: AppColors.textSecondary,
                                  height: 1.75,
                                ),
                              ),
                            )
                            .animate()
                            .fadeIn(delay: 700.ms, duration: 800.ms)
                            .slideY(begin: 0.18, end: 0),
                        SizedBox(height: isSmallPhone ? AppSpacing.xl : AppSpacing.xxl),
                        Wrap(
                              spacing: AppSpacing.md,
                              runSpacing: AppSpacing.md,
                              children: [
                                PremiumHover(
                                  lift: 4,
                                  child: PrimaryButton(
                                    label: AppStrings.heroCta,
                                    onTap: widget.onViewWork,
                                    icon: Icons.arrow_downward_rounded,
                                  ),
                                ),
                                PremiumHover(
                                  lift: 4,
                                  child: PrimaryButton(
                                    label: AppStrings.heroCtaSecondary,
                                    onTap: widget.onContact,
                                    outlined: true,
                                  ),
                                ),
                              ],
                            )
                            .animate()
                            .fadeIn(delay: 860.ms, duration: 760.ms)
                            .slideY(begin: 0.18, end: 0),
                        SizedBox(
                          height: isSmallPhone
                              ? AppSpacing.xl
                              : AppSpacing.section,
                        ),
                        if (!Responsive.isTinyPhone(context))
                          _ScrollIndicator()
                            .animate(onPlay: (c) => c.repeat())
                            .fadeIn(delay: 1200.ms)
                            .then()
                            .moveY(
                              begin: 0,
                              end: 8,
                              duration: 900.ms,
                              curve: Curves.easeInOut,
                            )
                            .then()
                            .moveY(
                              begin: 8,
                              end: 0,
                              duration: 900.ms,
                              curve: Curves.easeInOut,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TypewriterAnimatedText _gradientTypewriter(BuildContext context, String text) {
    final fontSize = Responsive.isSmallPhone(context)
        ? 24.0
        : (Responsive.isMobile(context) ? 30.0 : 38.0);
    return TypewriterAnimatedText(
      text,
      textStyle: GoogleFonts.sora(
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        foreground: Paint()
          ..shader = AppColors.accentGradient.createShader(
            const Rect.fromLTWH(0, 0, 300, 50),
          ),
        letterSpacing: -0.5,
      ),
      speed: const Duration(milliseconds: 80),
    );
  }
}

class _Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: AppColors.accentSecondary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Available for opportunities',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.accentSecondary,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Scroll to explore',
          style: TextStyle(
            fontSize: 11,
            color: AppColors.textMuted,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 1,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.accent, Colors.transparent],
            ),
          ),
        ),
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  final Offset drift;

  const _GlowBlob({
    required this.color,
    required this.size,
    this.drift = Offset.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(colors: [color, Colors.transparent]),
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .move(
          begin: Offset.zero,
          end: drift,
          duration: 2600.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .move(
          begin: drift,
          end: Offset.zero,
          duration: 2600.ms,
          curve: Curves.easeInOut,
        );
  }
}

class _GlowingName extends StatelessWidget {
  final double fontSize;

  const _GlowingName({required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          AppStrings.name,
          style: GoogleFonts.sora(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.accent.withValues(alpha: 0.2),
            height: 1.05,
            shadows: [
              Shadow(
                color: AppColors.accent.withValues(alpha: 0.4),
                blurRadius: 34,
              ),
            ],
          ),
        ).animate(onPlay: (controller) => controller.repeat()).shimmer(
              duration: 2400.ms,
              color: AppColors.accentSecondary.withValues(alpha: 0.45),
            ),
        Text(
          AppStrings.name,
          style: GoogleFonts.sora(
            fontSize: fontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.05,
          ),
        ),
      ],
    );
  }
}

class _OrbitBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isMobile(context)) return const SizedBox.shrink();
    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.16),
              ),
            ),
          ),
          ...List.generate(3, (i) {
            final angle = i * math.pi * 2 / 3;
            return Transform.translate(
              offset: Offset(math.cos(angle) * 64, math.sin(angle) * 64),
              child: Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.surface.withValues(alpha: 0.72),
                  border: Border.all(color: AppColors.border),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.16),
                      blurRadius: 18,
                    ),
                  ],
                ),
                child: Icon(
                  [Icons.flutter_dash, Icons.auto_awesome, Icons.speed][i],
                  size: 16,
                  color: AppColors.accentSecondary,
                ),
              ),
            );
          }),
        ],
      ),
    ).animate(onPlay: (controller) => controller.repeat()).rotate(
          duration: 12000.ms,
          curve: Curves.linear,
        );
  }
}

class _ParticlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.accentSecondary.withValues(alpha: AppColors.isDark ? 0.18 : 0.12);
    for (var i = 0; i < 46; i++) {
      final x = (math.sin(i * 12.9898) * 43758.5453).abs() % size.width;
      final y = (math.cos(i * 78.233) * 24634.6345).abs() % size.height;
      final radius = 0.8 + (i % 3) * 0.55;
      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
