import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_controller.dart';
import 'features/journey/journey_page.dart';
import 'features/portfolio/portfolio_screen.dart';

void main() {
  runApp(const ProviderScope(child: PortfolioApp()));
}

class PortfolioApp extends ConsumerWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    AppColors.setMode(themeMode);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abhishek Sharma - Flutter Developer',
      color: AppColors.background,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      home: PortfolioScreen(key: ValueKey(themeMode)),
      routes: {
        JourneyPage.routeName: (_) => JourneyPage(key: ValueKey(themeMode)),
      },
    );
  }
}
