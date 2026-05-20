import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../responsive/responsive.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 20;
    if (scrolled != _scrolled) setState(() => _scrolled = scrolled);
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppSpacing.navHeight,
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.surface.withValues(alpha: 0.92)
            : Colors.transparent,
        border: _scrolled
            ? const Border(bottom: BorderSide(color: AppColors.border, width: 1))
            : null,
        boxShadow: _scrolled
            ? [BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20)]
            : null,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.maxContentWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? AppSpacing.lg : AppSpacing.xl,
            ),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (b) => AppColors.accentGradient.createShader(b),
                  blendMode: BlendMode.srcIn,
                  child: Text(
                    'AS.',
                    style: GoogleFonts.sora(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Spacer(),
                if (!isMobile) ...[
                  _NavLink('About', () => _scrollTo(widget.sectionKeys[0])),
                  _NavLink('Skills', () => _scrollTo(widget.sectionKeys[1])),
                  _NavLink('Projects', () => _scrollTo(widget.sectionKeys[2])),
                  _NavLink('Experience', () => _scrollTo(widget.sectionKeys[3])),
                  const SizedBox(width: AppSpacing.md),
                  PrimaryButton(
                    label: 'Contact',
                    onTap: () => _scrollTo(widget.sectionKeys[4]),
                  ),
                ] else
                  IconButton(
                    icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
                    onPressed: () => _showMobileMenu(context),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.radiusXl)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ...['About', 'Skills', 'Projects', 'Experience', 'Contact']
                .asMap()
                .entries
                .map(
                  (e) => ListTile(
                    title: Text(
                      e.value,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _scrollTo(widget.sectionKeys[e.key]);
                    },
                  ),
                ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink(this.label, this.onTap);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _hovered ? AppColors.textPrimary : AppColors.textSecondary,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
