import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../responsive/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      padding: EdgeInsets.symmetric(
        vertical: AppSpacing.xl,
        horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: isMobile
              ? Column(
                  children: [
                    _Logo(),
                    const SizedBox(height: AppSpacing.lg),
                    _SocialRow(onLaunch: _launch),
                    const SizedBox(height: AppSpacing.lg),
                    const _Copyright(),
                  ],
                )
              : Row(
                  children: [
                    _Logo(),
                    const Spacer(),
                    _SocialRow(onLaunch: _launch),
                    const Spacer(),
                    const _Copyright(),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (b) => AppColors.accentGradient.createShader(b),
      blendMode: BlendMode.srcIn,
      child: Text(
        'Abhishek Sharma',
        style: GoogleFonts.sora(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final Future<void> Function(String) onLaunch;
  const _SocialRow({required this.onLaunch});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterIcon(
          icon: FontAwesomeIcons.github,
          onTap: () => onLaunch(AppStrings.github),
        ),
        const SizedBox(width: AppSpacing.md),
        _FooterIcon(
          icon: FontAwesomeIcons.linkedin,
          onTap: () => onLaunch(AppStrings.linkedIn),
        ),
        const SizedBox(width: AppSpacing.md),
        _FooterIcon(
          icon: FontAwesomeIcons.whatsapp,
          onTap: () => onLaunch(AppStrings.whatsapp),
        ),
        const SizedBox(width: AppSpacing.md),
        _FooterIcon(
          icon: Icons.email_outlined,
          onTap: () => onLaunch('mailto:${AppStrings.email}'),
          isMaterial: true,
        ),
      ],
    );
  }
}

class _FooterIcon extends StatefulWidget {
  final dynamic icon;
  final VoidCallback onTap;
  final bool isMaterial;

  const _FooterIcon({
    required this.icon,
    required this.onTap,
    this.isMaterial = false,
  });

  @override
  State<_FooterIcon> createState() => _FooterIconState();
}

class _FooterIconState extends State<_FooterIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: widget.isMaterial
              ? Icon(
                  widget.icon as IconData,
                  size: 18,
                  color: _hovered ? AppColors.accent : AppColors.textMuted,
                )
              : FaIcon(
                  widget.icon as IconData,
                  size: 16,
                  color: _hovered ? AppColors.accent : AppColors.textMuted,
                ),
        ),
      ),
    );
  }
}

class _Copyright extends StatelessWidget {
  const _Copyright();

  @override
  Widget build(BuildContext context) {
    return const Text(
      AppStrings.footerText,
      style: TextStyle(fontSize: 12, color: AppColors.textMuted),
    );
  }
}
