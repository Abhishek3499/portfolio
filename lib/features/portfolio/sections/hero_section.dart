import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../responsive/responsive.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(gradient: AppColors.heroGradient),
      child: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: _GlowBlob(
              color: AppColors.accent.withValues(alpha: 0.12),
              size: 500,
            ),
          ),
          Positioned(
            bottom: 0,
            right: -80,
            child: _GlowBlob(
              color: AppColors.accentSecondary.withValues(alpha: 0.08),
              size: 400,
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSpacing.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
                  vertical: AppSpacing.section,
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
                        .fadeIn(delay: 200.ms, duration: 600.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                          AppStrings.name,
                          style: GoogleFonts.sora(
                            fontSize: isMobile ? 36 : (isTablet ? 52 : 68),
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            height: 1.05,
                            letterSpacing: -2,
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 350.ms, duration: 700.ms)
                        .slideY(begin: 0.3, end: 0),
                    const SizedBox(height: AppSpacing.md),
                    AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        _gradientTypewriter('Flutter Developer'),
                        _gradientTypewriter('Mobile Engineer'),
                        _gradientTypewriter('UI/UX Craftsman'),
                      ],
                    ).animate().fadeIn(delay: 500.ms, duration: 700.ms),
                    const SizedBox(height: AppSpacing.xl),
                    ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 560),
                          child: Text(
                            AppStrings.tagline,
                            style: TextStyle(
                              fontSize: isMobile ? 15 : 17,
                              color: AppColors.textSecondary,
                              height: 1.75,
                            ),
                          ),
                        )
                        .animate()
                        .fadeIn(delay: 650.ms, duration: 700.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: AppSpacing.xxl),
                    Wrap(
                          spacing: AppSpacing.md,
                          runSpacing: AppSpacing.md,
                          children: [
                            PrimaryButton(
                              label: AppStrings.heroCta,
                              onTap: onViewWork,
                              icon: Icons.arrow_downward_rounded,
                            ),
                            PrimaryButton(
                              label: AppStrings.heroCtaSecondary,
                              onTap: onContact,
                              outlined: true,
                            ),
                          ],
                        )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 700.ms)
                        .slideY(begin: 0.2, end: 0),
                    const SizedBox(height: AppSpacing.section),
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
        ],
      ),
    );
  }

  TypewriterAnimatedText _gradientTypewriter(String text) {
    return TypewriterAnimatedText(
      text,
      textStyle: GoogleFonts.sora(
        fontSize: 38,
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
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, Colors.transparent]),
      ),
    );
  }
}
