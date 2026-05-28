import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/widgets/section_title.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static const List<_ContactItem> _items = [
    _ContactItem(
      icon: Icons.email_outlined,
      label: 'Email',
      value: AppStrings.emailAddress,
      url: 'mailto:${AppStrings.emailAddress}',
    ),
    _ContactItem(
      icon: Icons.language_rounded,
      label: 'Website',
      value: 'ksaikiran.dev',
      url: AppStrings.websiteUrl,
    ),
    _ContactItem(
      icon: Icons.work_outline_rounded,
      label: 'LinkedIn',
      value: 'Sai Kiran Katayath',
      url: AppStrings.linkedinUrl,
    ),
    _ContactItem(
      icon: Icons.widgets_outlined,
      label: 'pub.dev',
      value: 'ksaikiran.dev/packages',
      url: AppStrings.pubDevUrl,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.backgroundCard.withValues(alpha: 0.25),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(
                title: AppStrings.contactTitle,
                subtitle: AppStrings.contactSubtitle,
                alignment: CrossAxisAlignment.center,
              ),
              const SizedBox(height: 60),
              isMobile
                  ? Column(
                      children: _items
                          .asMap()
                          .entries
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _ContactCard(item: e.value, index: e.key),
                            ),
                          )
                          .toList(),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3.0,
                      children: _items
                          .asMap()
                          .entries
                          .map((e) => _ContactCard(item: e.value, index: e.key))
                          .toList(),
                    ),
              const SizedBox(height: 48),
              Text(
                'Open to engineering conversations and collaboration.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactCard extends StatefulWidget {
  const _ContactCard({required this.item, required this.index});
  final _ContactItem item;
  final int index;

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.item.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
            border: Border.all(
              color: _hovered ? AppColors.primary : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.item.icon,
                size: 20,
                color: _hovered
                    ? AppColors.accentSecondary
                    : AppColors.textMuted,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.item.label,
                      style: AppTextStyles.mono.copyWith(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.item.value,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: _hovered
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
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
                color: _hovered ? AppColors.accentSecondary : AppColors.border,
              ),
            ],
          ),
        ).animate(delay: (widget.index * 80).ms).fadeIn(duration: 400.ms),
      ),
    );
  }
}

class _ContactItem {
  const _ContactItem({
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
