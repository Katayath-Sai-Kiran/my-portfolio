import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';
import '../providers/theme_provider.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final themeProvider = context.watch<ThemeProvider>();

    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: c.navBg,
        border: Border(bottom: BorderSide(color: c.borderSubtle)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            Text(
              'Sai Kiran Katayath',
              style: AppTypography.titleMedium.copyWith(
                color: c.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            _GhostLink(
              label: 'GitHub',
              url: 'https://github.com/ksaikiran0407',
              c: c,
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: themeProvider.toggle,
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  themeProvider.isDark
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  size: 16,
                  color: c.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GhostLink extends StatelessWidget {
  const _GhostLink({required this.label, required this.url, required this.c});
  final String label;
  final String url;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrl(Uri.parse(url)),
      child: Text(
        label,
        style: AppTypography.labelLarge.copyWith(color: c.textSecondary),
      ),
    );
  }
}
