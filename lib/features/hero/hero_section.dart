import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/providers/scroll_provider.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      color: AppColors.backgroundDark,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: isMobile
              ? const _MobileHeroContent()
              : const _DesktopHeroContent(),
        ),
      ),
    );
  }
}

class _DesktopHeroContent extends StatelessWidget {
  const _DesktopHeroContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 5, child: _HeroText()),
        const SizedBox(width: 80),
        Expanded(flex: 4, child: _EngineeringVisual()),
      ],
    );
  }
}

class _MobileHeroContent extends StatelessWidget {
  const _MobileHeroContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        _EngineeringVisual(),
        const SizedBox(height: 48),
        const _HeroText(centerAlign: true),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText({this.centerAlign = false});
  final bool centerAlign;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final scrollProvider = context.read<ScrollProvider>();
    final align = centerAlign
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centerAlign ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Mono tag line
        Text(
          'flutter engineer',
          style: AppTextStyles.mono.copyWith(color: AppColors.accentSecondary),
          textAlign: textAlign,
        ).animate().fadeIn(duration: 400.ms),

        const SizedBox(height: 16),

        // Name
        Text(
              AppStrings.heroName,
              style: isMobile
                  ? AppTextStyles.displayMedium
                  : AppTextStyles.displayLarge,
              textAlign: textAlign,
            )
            .animate()
            .fadeIn(delay: 100.ms, duration: 500.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 14),

        // Title
        Text(
          AppStrings.heroTitle,
          style: AppTextStyles.headlineMedium.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          textAlign: textAlign,
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

        const SizedBox(height: 20),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540),
          child: Text(
            AppStrings.heroSubtitle,
            style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textMuted),
            textAlign: textAlign,
          ),
        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

        const SizedBox(height: 44),

        // CTA row
        Wrap(
          alignment: centerAlign ? WrapAlignment.center : WrapAlignment.start,
          spacing: 12,
          runSpacing: 12,
          children: [
            _HeroButton(
              label: AppStrings.heroCta,
              primary: true,
              onTap: () =>
                  scrollProvider.scrollToSection(PortfolioSection.openSource),
            ),
            _HeroButton(
              label: AppStrings.heroCtaGithub,
              onTap: () => launchUrl(Uri.parse(AppStrings.githubUrl)),
            ),
            _HeroButton(
              label: AppStrings.heroCtaContact,
              onTap: () =>
                  scrollProvider.scrollToSection(PortfolioSection.contact),
            ),
            if (AppStrings.resumeUrl.isNotEmpty)
              _HeroButton(
                label: AppStrings.heroCtaResume,
                onTap: () => launchUrl(Uri.parse(AppStrings.resumeUrl)),
              ),
          ],
        ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
      ],
    );
  }
}

class _HeroButton extends StatefulWidget {
  const _HeroButton({
    required this.label,
    required this.onTap,
    this.primary = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool primary;

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: widget.primary
                ? (_hovered
                      ? AppColors.accentSecondary
                      : AppColors.accentSecondary.withValues(alpha: 0.85))
                : (_hovered
                      ? AppColors.backgroundCardLight
                      : AppColors.backgroundCard),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: widget.primary
                  ? AppColors.accentSecondary
                  : (_hovered ? AppColors.primary : AppColors.border),
            ),
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.labelLarge.copyWith(
              color: widget.primary ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

/// Engineering-themed visual — a clean code block representation.
class _EngineeringVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child:
          Container(
                width: 380,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Window chrome dots
                    Row(
                      children: [
                        _Dot(color: const Color(0xFFE74C3C)),
                        const SizedBox(width: 6),
                        _Dot(color: const Color(0xFFF39C12)),
                        const SizedBox(width: 6),
                        _Dot(color: const Color(0xFF27AE60)),
                        const Spacer(),
                        Text(
                          'flutter_engineer.dart',
                          style: AppTextStyles.mono.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const _CodeLine(
                      keyword: 'class ',
                      ident: 'SaiKiran',
                      rest: ' {',
                    ),
                    const SizedBox(height: 6),
                    const _CodeLine(
                      indent: 2,
                      keyword: 'final ',
                      ident: 'focus',
                      rest: " = 'rendering';",
                    ),
                    const SizedBox(height: 6),
                    const _CodeLine(
                      indent: 2,
                      keyword: 'final ',
                      ident: 'tools',
                      rest: " = 'pub.dev';",
                    ),
                    const SizedBox(height: 6),
                    const _CodeLine(
                      indent: 2,
                      keyword: 'final ',
                      ident: 'target',
                      rest: " = 'sdk-level';",
                    ),
                    const SizedBox(height: 12),
                    const _CodeLine(
                      indent: 2,
                      comment: '// open source maintainer',
                    ),
                    const SizedBox(height: 6),
                    const _CodeLine(
                      indent: 2,
                      ident: 'buildPackages',
                      rest: '();',
                    ),
                    const SizedBox(height: 12),
                    const _CodeLine(rest: '}'),
                  ],
                ),
              )
              .animate()
              .fadeIn(delay: 300.ms, duration: 600.ms)
              .slideX(begin: 0.1, end: 0),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine({
    this.indent = 0,
    this.keyword,
    this.ident,
    this.rest,
    this.comment,
  });

  final int indent;
  final String? keyword;
  final String? ident;
  final String? rest;
  final String? comment;

  @override
  Widget build(BuildContext context) {
    final base = AppTextStyles.mono.copyWith(fontSize: 13);
    return Text.rich(
      TextSpan(
        children: [
          if (indent > 0) TextSpan(text: '  ' * indent, style: base),
          if (comment != null)
            TextSpan(
              text: comment,
              style: base.copyWith(
                color: AppColors.textMuted.withValues(alpha: 0.6),
              ),
            )
          else ...[
            if (keyword != null)
              TextSpan(
                text: keyword,
                style: base.copyWith(color: const Color(0xFF9B59B6)),
              ),
            if (ident != null)
              TextSpan(
                text: ident,
                style: base.copyWith(color: AppColors.accentSecondary),
              ),
            if (rest != null)
              TextSpan(
                text: rest,
                style: base.copyWith(color: AppColors.textSecondary),
              ),
          ],
        ],
      ),
    );
  }
}
