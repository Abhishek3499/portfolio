import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../responsive/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isSmallPhone = Responsive.isSmallPhone(context);

    return PremiumBackground(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Responsive.sectionPadding(context),
          horizontal: Responsive.horizontalPadding(context),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              children: [
                Text(
                  AppStrings.contactTitle,
                  style: GoogleFonts.sora(
                    fontSize: isSmallPhone ? 24 : (isMobile ? 28 : 40),
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0),
                const SizedBox(height: AppSpacing.md),
                Text(
                  AppStrings.contactSubtitle,
                  style: TextStyle(
                    fontSize: isSmallPhone ? 14 : 16,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 150.ms, duration: 600.ms),
                const SizedBox(height: AppSpacing.xxl),
                PremiumHover(
                      lift: 5,
                      child: GlassCard(
                        child: isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const _EmailCopy(),
                                  const SizedBox(height: AppSpacing.md),
                                  PrimaryButton(
                                    label: 'Send Email',
                                    onTap: () =>
                                        _launch('mailto:${AppStrings.email}'),
                                  ),
                                  const SizedBox(height: AppSpacing.md),
                                  PrimaryButton(
                                    label: AppStrings.journeyCta,
                                    icon: Icons.route_outlined,
                                    outlined: true,
                                    onTap: () => Navigator.of(
                                      context,
                                    ).pushNamed('/journey'),
                                  ),
                                ],
                              )
                            : Row(
                                children: [
                                  const _EmailCopy(expanded: true),
                                  const SizedBox(width: AppSpacing.md),
                                  Wrap(
                                    spacing: AppSpacing.md,
                                    runSpacing: AppSpacing.md,
                                    children: [
                                      PrimaryButton(
                                        label: 'Send Email',
                                        icon: Icons.mail_outline_rounded,
                                        onTap: () => _launch(
                                          'mailto:${AppStrings.email}',
                                        ),
                                      ),
                                      PrimaryButton(
                                        label: AppStrings.journeyCta,
                                        icon: Icons.route_outlined,
                                        outlined: true,
                                        onTap: () => Navigator.of(
                                          context,
                                        ).pushNamed('/journey'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 250.ms, duration: 600.ms)
                    .slideY(begin: 0.08, end: 0)
                    .blurXY(begin: 8, end: 0),
                const SizedBox(height: AppSpacing.xl),
                Wrap(
                  spacing: AppSpacing.md,
                  runSpacing: AppSpacing.md,
                  alignment: WrapAlignment.center,
                  children: [
                    _SocialButton(
                      icon: FontAwesomeIcons.linkedin,
                      label: 'LinkedIn',
                      color: const Color(0xFF0A66C2),
                      onTap: () => _launch(AppStrings.linkedIn),
                    ),
                    _SocialButton(
                      icon: FontAwesomeIcons.github,
                      label: 'GitHub',
                      color: AppColors.textPrimary,
                      onTap: () => _launch(AppStrings.github),
                    ),
                    _SocialButton(
                      icon: FontAwesomeIcons.whatsapp,
                      label: 'WhatsApp',
                      color: const Color(0xFF25D366),
                      onTap: () => _launch(AppStrings.whatsapp),
                    ),
                  ],
                ).animate().fadeIn(delay: 400.ms, duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailCopy extends StatelessWidget {
  final bool expanded;

  const _EmailCopy({this.expanded = false});

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Icon(Icons.email_outlined, color: AppColors.accent, size: 22),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email me directly',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                AppStrings.email,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: Responsive.isSmallPhone(context) ? 12 : 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return expanded ? Expanded(child: content) : content;
  }
}

class _SocialButton extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _hovered ? 1.04 : 1,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xl,
              vertical: AppSpacing.md,
            ),
            decoration: BoxDecoration(
              color: _hovered
                  ? widget.color.withValues(alpha: 0.12)
                  : AppColors.surfaceElevated,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              border: Border.all(
                color: _hovered
                    ? widget.color.withValues(alpha: 0.42)
                    : AppColors.border,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: widget.color.withValues(alpha: 0.18),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  widget.icon,
                  size: 16,
                  color: _hovered ? widget.color : AppColors.textSecondary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _hovered ? widget.color : AppColors.textSecondary,
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
