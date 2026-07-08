import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/design/app_theme.dart';
import 'core/router/app_router.dart';
import 'shared/providers/theme_provider.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeProvider, __) => MaterialApp.router(
        title: 'Sai Kiran Katayath — Flutter Developer',
        debugShowCheckedModeBanner: false,
        themeMode: themeProvider.mode,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
