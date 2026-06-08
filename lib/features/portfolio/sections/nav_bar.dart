import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../responsive/responsive.dart';

class NavBar extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final int activeIndex;
  final VoidCallback onJourney;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.activeIndex,
    required this.onJourney,
  });

  @override
  ConsumerState<NavBar> createState() => _NavBarState();
}

class _NavBarState extends ConsumerState<NavBar> {
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

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final themeMode = ref.watch(themeModeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: AppSpacing.navHeight,
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.surface.withValues(alpha: 0.92)
            : Colors.transparent,
        border: _scrolled
            ? Border(bottom: BorderSide(color: AppColors.border, width: 1))
            : null,
        boxShadow: _scrolled
            ? [
                BoxShadow(
                  color: AppColors.isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : AppColors.accent.withValues(alpha: 0.08),
                  blurRadius: 20,
                ),
              ]
            : null,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.maxContentWidth,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.horizontalPadding(context),
            ),
            child: Row(
              children: [
                ShaderMask(
                  shaderCallback: (b) =>
                      AppColors.accentGradient.createShader(b),
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
                  _NavLink(
                    'About',
                    active: widget.activeIndex == 1,
                    onTap: () => _scrollTo(widget.sectionKeys[1]),
                  ),
                  _NavLink(
                    'Skills',
                    active: widget.activeIndex == 2,
                    onTap: () => _scrollTo(widget.sectionKeys[2]),
                  ),
                  _NavLink(
                    'Projects',
                    active: widget.activeIndex == 3,
                    onTap: () => _scrollTo(widget.sectionKeys[3]),
                  ),
                  _NavLink(
                    'Experience',
                    active: widget.activeIndex == 4,
                    onTap: () => _scrollTo(widget.sectionKeys[4]),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  PremiumHover(
                    lift: 3,
                    child: PrimaryButton(
                      label: 'My Journey',
                      icon: Icons.route_outlined,
                      outlined: true,
                      onTap: widget.onJourney,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  _ThemeToggle(isDark: isDark, onChanged: _setThemeMode),
                  const SizedBox(width: AppSpacing.md),
                  PremiumHover(
                    lift: 3,
                    child: PrimaryButton(
                      label: 'Contact',
                      onTap: () => _scrollTo(widget.sectionKeys[8]),
                    ),
                  ),
                ] else
                  Row(
                    children: [
                      _ThemeToggle(isDark: isDark, onChanged: _setThemeMode),
                      const SizedBox(width: AppSpacing.sm),
                      IconButton(
                        icon: Icon(
                          Icons.menu_rounded,
                          color: AppColors.textPrimary,
                        ),
                        onPressed: () => _showMobileMenu(context),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _setThemeMode(bool isDark) {
    ref.read(themeModeProvider.notifier).state = isDark
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.radiusXl),
        ),
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
            _MobileMenuTile(
              label: 'About',
              onTap: () => _closeAndScroll(context, widget.sectionKeys[1]),
            ),
            _MobileMenuTile(
              label: 'Skills',
              onTap: () => _closeAndScroll(context, widget.sectionKeys[2]),
            ),
            _MobileMenuTile(
              label: 'Projects',
              onTap: () => _closeAndScroll(context, widget.sectionKeys[3]),
            ),
            _MobileMenuTile(
              label: 'Experience',
              onTap: () => _closeAndScroll(context, widget.sectionKeys[4]),
            ),
            _MobileMenuTile(
              label: 'My Journey',
              icon: Icons.route_outlined,
              onTap: () {
                Navigator.pop(context);
                widget.onJourney();
              },
            ),
            _MobileMenuTile(
              label: 'Contact',
              onTap: () => _closeAndScroll(context, widget.sectionKeys[8]),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  void _closeAndScroll(BuildContext context, GlobalKey key) {
    Navigator.pop(context);
    _scrollTo(key);
  }
}

class _MobileMenuTile extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const _MobileMenuTile({required this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon == null ? null : Icon(icon, color: AppColors.accent),
      title: Text(
        label,
        style: TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const _ThemeToggle({required this.isDark, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: GestureDetector(
        onTap: () => onChanged(!isDark),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeOutCubic,
          width: 58,
          height: 32,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            gradient: AppColors.toggleTrackGradient,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: isDark ? 0.18 : 0.12),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeOutCubic,
            alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? const [Color(0xFF6366F1), Color(0xFF06B6D4)]
                      : const [Color(0xFFFFB703), Color(0xFFFB7185)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                color: AppColors.onAccent,
                size: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavLink(this.label, {required this.active, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.active || _hovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: widget.active
                  ? AppColors.accent.withValues(alpha: 0.08)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              boxShadow: widget.active
                  ? [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.18),
                        blurRadius: 18,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 180),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: widget.active
                        ? FontWeight.w700
                        : FontWeight.w500,
                    color: isActive
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                  ),
                  child: Text(widget.label),
                ),
                const SizedBox(height: 4),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  width: widget.active ? 24 : (_hovered ? 14 : 0),
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: AppColors.accentGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.5),
                        blurRadius: 8,
                      ),
                    ],
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
