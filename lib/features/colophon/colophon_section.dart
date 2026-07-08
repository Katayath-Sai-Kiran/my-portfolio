import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

class ColophonSection extends StatelessWidget {
  const ColophonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forColophon(c)),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: ResponsiveHelper.sectionV(context),
      ),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Header(c: c, isMobile: isMobile),
              SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
              if (isMobile) _MobileLayout(c: c) else _DesktopLayout(c: c),
              SizedBox(height: isMobile ? AppSpacing.xxl : AppSpacing.huge),
              _Closing(c: c, isMobile: isMobile),
            ],
          ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('COLOPHON', style: AppTypography.monoSmall.copyWith(color: c.accent))
            .animate().fadeIn(duration: 400.ms),
        const SizedBox(height: AppSpacing.sm),
        RichText(
          text: TextSpan(
            style: isMobile ? AppTypography.headlineMedium : AppTypography.displayLarge,
            children: [
              TextSpan(text: 'Built with '),
              TextSpan(text: 'intention', style: TextStyle(fontStyle: FontStyle.italic, color: c.accent)),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms, duration: 500.ms),
        const SizedBox(height: AppSpacing.md),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Text(
            'The tools, fonts, and philosophy behind this page.',
            style: AppTypography.bodyLarge.copyWith(color: c.textSecondary),
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
      ],
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  const _DesktopLayout({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _TechStack(c: c)),
        const SizedBox(width: AppSpacing.xxxl),
        Expanded(flex: 4, child: _Contact(c: c)),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  const _MobileLayout({required this.c});
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TechStack(c: c),
        const SizedBox(height: AppSpacing.xxl),
        _Contact(c: c),
      ],
    );
  }
}

class _TechStack extends StatelessWidget {
  const _TechStack({required this.c});
  final PortfolioColors c;

  static const _techItems = [
    ('Flutter 3.x', 'UI framework across 6 platforms'),
    ('Dart 3.x', 'Type-safe, sound null safety'),
    ('Google Fonts', 'Playfair Display + Inter + JetBrains Mono'),
    ('flutter_animate', 'Micro-animations and motion design'),
    ('GoRouter', 'Declarative routing with transitions'),
    ('Provider', 'Lightweight state management'),
    ('GitHub Pages', 'Static deployment via GitHub Actions'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tech Stack',
          style: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        ...List.generate(_techItems.length, (i) {
          final item = _techItems[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i < _techItems.length - 1 ? AppSpacing.sm : 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('— ', style: AppTypography.monoSmall.copyWith(color: c.accent, fontSize: 10)),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: AppTypography.bodyMedium.copyWith(color: c.textSecondary, height: 1.5),
                      children: [
                        TextSpan(
                          text: item.$1,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' — ${item.$2}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }
}

class _Contact extends StatelessWidget {
  const _Contact({required this.c});
  final PortfolioColors c;

  static const _links = [
    ('GitHub', 'github.com/Katayath-Sai-Kiran', 'https://github.com/Katayath-Sai-Kiran'),
    ('LinkedIn', 'linkedin.com/in/sai-kiran-katayath', 'https://linkedin.com/in/sai-kiran-katayath'),
    ('pub.dev', 'pub.dev/publishers/ksaikiran.dev', 'https://pub.dev/publishers/ksaikiran.dev/packages'),
    ('Medium', 'medium.com/@ksaikiran0407', 'https://medium.com/@ksaikiran0407'),
    ('Email', 'ksaikiran0407@gmail.com', 'mailto:ksaikiran0407@gmail.com'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect',
          style: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        ...List.generate(_links.length, (i) {
          final link = _links[i];
          return Padding(
            padding: EdgeInsets.only(bottom: i < _links.length - 1 ? AppSpacing.sm : 0),
            child: GestureDetector(
              onTap: () => launchUrl(Uri.parse(link.$3)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  gradient: AppGradients.forQuote(c),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: c.borderSubtle),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      link.$1,
                      style: AppTypography.labelLarge.copyWith(
                        color: c.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      link.$2,
                      style: AppTypography.bodySmall.copyWith(color: c.textMuted),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Icon(Icons.open_in_new, size: 10, color: c.textMuted),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    ).animate().fadeIn(delay: 400.ms, duration: 500.ms);
  }
}

class _Closing extends StatelessWidget {
  const _Closing({required this.c, required this.isMobile});
  final PortfolioColors c;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 1),
        SizedBox(height: isMobile ? AppSpacing.xl : AppSpacing.xxl),
        Row(
          children: [
            Expanded(
              child: Text(
                'Designed and built by Sai Kiran Katayath. '
                '© ${DateTime.now().year} — all rights reserved.',
                style: AppTypography.bodySmall.copyWith(color: c.textMuted),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
      ],
    );
  }
}
