import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const _links = <_Link>[
    _Link(
      icon: Icons.email_outlined,
      label: 'Email',
      value: AppStrings.emailAddress,
      url: 'mailto:${AppStrings.emailAddress}',
    ),
    _Link(
      icon: Icons.work_outline_rounded,
      label: 'LinkedIn',
      value: 'Sai Kiran Katayath',
      url: AppStrings.linkedinUrl,
    ),
    _Link(
      icon: Icons.code_rounded,
      label: 'GitHub',
      value: 'Katayath-Sai-Kiran',
      url: AppStrings.githubUrl,
    ),
    _Link(
      icon: Icons.widgets_outlined,
      label: 'pub.dev',
      value: 'ksaikiran.dev/packages',
      url: AppStrings.pubDevUrl,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            c.surface.withValues(alpha: 0.4),
            c.background,
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Closing chapter marker
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: c.accentBg,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: c.accent.withValues(alpha: 0.25)),
                ),
                child: Text(
                  'FIN — CONTACT',
                  style: AppTextStyles.monoSmall.copyWith(color: c.accent),
                ),
              ).animate().fadeIn(duration: 400.ms),

              const SizedBox(height: 28),

              // Closing headline
              Text(
                'You\'ve seen how I think.',
                style: (isMobile ? AppTextStyles.headlineMedium : AppTextStyles.headlineLarge)
                    .copyWith(
                  color: c.textPrimary,
                  fontWeight: FontWeight.w800,
                  height: 1.15,
                ),
                textAlign: TextAlign.center,
              )
                  .animate()
                  .fadeIn(delay: 100.ms, duration: 500.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Text(
                  'If you\'re building something that needs a Flutter engineer '
                  'who works at the SDK level — packages, rendering, native '
                  'integration, production architecture — I\'d like to talk.',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: c.textSecondary,
                    height: 1.75,
                    fontSize: isMobile ? 16 : 18,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 200.ms, duration: 500.ms),
              ),

              const SizedBox(height: 56),

              // Contact grid
              isMobile
                  ? Column(
                      children: _links.asMap().entries.map((e) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _LinkCard(link: e.value, index: e.key),
                        );
                      }).toList(),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3.2,
                      children: _links.asMap().entries
                          .map((e) => _LinkCard(link: e.value, index: e.key))
                          .toList(),
                    ),

              const SizedBox(height: 48),

              // Accent divider
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 32, height: 1, color: c.border),
                  const SizedBox(width: 12),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: c.accent, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 12),
                  Container(width: 32, height: 1, color: c.border),
                ],
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

              const SizedBox(height: 24),

              Text(
                'Open to engineering conversations and collaboration.',
                style: AppTextStyles.mono.copyWith(
                  fontSize: 12,
                  color: c.textMuted,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Link card ─────────────────────────────────────────────────────────────────

class _LinkCard extends StatefulWidget {
  const _LinkCard({required this.link, required this.index});
  final _Link link;
  final int index;

  @override
  State<_LinkCard> createState() => _LinkCardState();
}

class _LinkCardState extends State<_LinkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.link.url)),
        child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: _hovered ? c.surfaceHover : c.surface,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(
                  color: _hovered ? c.accent : c.border,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    widget.link.icon,
                    size: 18,
                    color: _hovered ? c.orange : c.textMuted,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.link.label,
                          style: AppTextStyles.mono.copyWith(
                            fontSize: 10,
                            color: c.textMuted,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.link.value,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: _hovered ? c.textPrimary : c.textSecondary,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_outward_rounded,
                    size: 14,
                    color: _hovered ? c.accent : c.border,
                  ),
                ],
              ),
            )
            .animate(delay: (widget.index * 80).ms)
            .fadeIn(duration: 400.ms)
            .slideY(begin: 0.05, end: 0),
      ),
    );
  }
}

class _Link {
  const _Link({
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String value;
  final String url;
}
