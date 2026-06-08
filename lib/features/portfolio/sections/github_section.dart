import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/premium_effects.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/section_title.dart';
import '../../../responsive/responsive.dart';

class GithubSection extends StatelessWidget {
  const GithubSection({super.key});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final sectionGap = Responsive.isSmallPhone(context)
        ? AppSpacing.xl
        : AppSpacing.xxl;

    return PremiumBackground(
      surface: true,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: Responsive.sectionPadding(context),
          horizontal: Responsive.horizontalPadding(context),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSpacing.maxContentWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScrollReveal(
                  slideBegin: Offset(-0.06, 0),
                  child: SectionTitle(
                    title: 'GitHub Highlights',
                    subtitle: 'Open-source work, contributions, and repositories.',
                  ),
                ),
                SizedBox(height: sectionGap),
                
                // GitHub Stats Grid
                _StatsGrid(isMobile: isMobile, isTablet: isTablet),
                const SizedBox(height: AppSpacing.xl),

                // GitHub Contributions Grid Mock
                _ContributionCalendar(),
                const SizedBox(height: AppSpacing.xl),

                // Featured GitHub Projects
                Text(
                  'Featured Repositories',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _RepoShowcaseGrid(isMobile: isMobile, isTablet: isTablet),
                const SizedBox(height: AppSpacing.xxl),

                // Direct Profile Link
                Center(
                  child: ScrollReveal(
                    child: PremiumHover(
                      lift: 5,
                      child: PrimaryButton(
                        label: 'View GitHub Profile',
                        icon: Icons.code_rounded,
                        onTap: () => _launch(AppStrings.github),
                      ),
                    ),
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

class _StatsGrid extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _StatsGrid({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final stats = [
      _StatData('15+', 'Public Repos', FontAwesomeIcons.bookBookmark),
      _StatData('450+', 'Contributions', FontAwesomeIcons.chartSimple),
      _StatData('35+', 'Pull Requests', FontAwesomeIcons.codePullRequest),
      _StatData('12', 'Stars Earned', FontAwesomeIcons.star),
    ];

    final columns = isMobile ? 2 : 4;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: isMobile ? 1.5 : 1.7,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return PremiumHover(
          lift: 3,
          child: GlassCard(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                  ),
                  child: Center(
                    child: FaIcon(
                      stat.icon,
                      color: AppColors.accentSecondary,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stat.value,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Responsive.isSmallPhone(context) ? 18 : 22,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        stat.label,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (index * 80).ms, duration: 400.ms)
        .scale(begin: const Offset(0.95, 0.95), end: const Offset(1, 1));
      },
    );
  }
}

class _StatData {
  final String value;
  final String label;
  final FaIconData icon;

  const _StatData(this.value, this.label, this.icon);
}

class _ContributionCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final columnsCount = isMobile ? 24 : 53; // Show fewer columns on mobile
    
    // Generate contribution levels (0 to 4) randomly, but seed for consistent look
    final random = math.Random(42);
    final levels = List.generate(
      columnsCount * 7,
      (index) {
        // Create realistic clustering of contributions
        final chance = random.nextDouble();
        if (chance < 0.35) return 0;
        if (chance < 0.65) return 1;
        if (chance < 0.85) return 2;
        if (chance < 0.95) return 3;
        return 4;
      },
    );

    return PremiumHover(
      lift: 2,
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.github,
                      size: 15,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'GitHub Contribution Activity',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                Text(
                  '450+ commits / past year',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.accentSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(columnsCount, (colIdx) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 3.0),
                    child: Column(
                      children: List.generate(7, (rowIdx) {
                        final index = colIdx * 7 + rowIdx;
                        final level = index < levels.length ? levels[index] : 0;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: _ContributionSquare(level: level),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Less',
                  style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                ),
                const SizedBox(width: 4),
                _ContributionSquare(level: 0),
                const SizedBox(width: 2),
                _ContributionSquare(level: 1),
                const SizedBox(width: 2),
                _ContributionSquare(level: 2),
                const SizedBox(width: 2),
                _ContributionSquare(level: 3),
                const SizedBox(width: 2),
                _ContributionSquare(level: 4),
                const SizedBox(width: 4),
                Text(
                  'More',
                  style: TextStyle(fontSize: 10, color: AppColors.textMuted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributionSquare extends StatelessWidget {
  final int level;

  const _ContributionSquare({required this.level});

  Color _getColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      switch (level) {
        case 1:
          return const Color(0xFF0E4429);
        case 2:
          return const Color(0xFF006D32);
        case 3:
          return const Color(0xFF26A641);
        case 4:
          return const Color(0xFF39D353);
        case 0:
        default:
          return const Color(0xFF161B22);
      }
    } else {
      switch (level) {
        case 1:
          return const Color(0xFF9BE9A8);
        case 2:
          return const Color(0xFF40C463);
        case 3:
          return const Color(0xFF30A14E);
        case 4:
          return const Color(0xFF216E39);
        case 0:
        default:
          return const Color(0xFFEBEDF0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: _getColor(context),
        borderRadius: BorderRadius.circular(1.5),
      ),
    );
  }
}

class _RepoShowcaseGrid extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;

  const _RepoShowcaseGrid({required this.isMobile, required this.isTablet});

  @override
  Widget build(BuildContext context) {
    final repos = [
      _RepoData(
        'gruve_app',
        'Built a responsive social and communication platform using Flutter and Firebase with modern UI, authentication, chat, and state management.',
        'Dart',
        '2',
      ),
      _RepoData(
        'weather_app',
        'A weather forecasting application providing real-time weather details and hourly/weekly forecasts using REST API.',
        'Dart',
        '1',
      ),
      _RepoData(
        'finance_manager',
        'An expense tracking and personal finance application with visual dashboard analytics and category management.',
        'Dart',
        '3',
      ),
      _RepoData(
        'sports_dashboard',
        'A premium sports management dashboard showcasing responsive design and micro-animations for booking events.',
        'Dart',
        '0',
      ),
    ];

    final columns = isMobile ? 1 : (isTablet ? 2 : 2);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: AppSpacing.lg,
        mainAxisSpacing: AppSpacing.lg,
        childAspectRatio: isMobile ? 1.9 : 2.2,
      ),
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final repo = repos[index];
        return PremiumHover(
          lift: 4,
          child: GlassCard(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.bookBookmark,
                          size: 14,
                          color: AppColors.accent,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            repo.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.accentSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      repo.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: AppColors.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF18E33), // Dart color indicator
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      repo.language,
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                    const SizedBox(width: AppSpacing.lg),
                    FaIcon(
                      FontAwesomeIcons.star,
                      size: 11,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      repo.stars,
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RepoData {
  final String name;
  final String description;
  final String language;
  final String stars;

  const _RepoData(this.name, this.description, this.language, this.stars);
}
