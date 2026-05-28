import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/data/portfolio_data.dart';
import '../../shared/models/portfolio_models.dart';
import '../../shared/services/pub_dev_service.dart';
import '../../shared/widgets/section_title.dart';

class OpenSourceSection extends StatelessWidget {
  const OpenSourceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      color: AppColors.backgroundCard.withValues(alpha: 0.25),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppDimensions.maxContentWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SectionTitle(
                title: AppStrings.openSourceTitle,
                subtitle: AppStrings.openSourceSubtitle,
              ),
              const SizedBox(height: 16),
              // Pub.dev publisher link
              _PubDevLink(),
              const SizedBox(height: 44),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? 1.3 : (isTablet ? 1.1 : 1.5),
                children: PortfolioData.packages
                    .asMap()
                    .entries
                    .map((e) => _PackageCard(pkg: e.value, index: e.key))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PubDevLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(AppStrings.pubDevUrl)),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.open_in_new_rounded,
              size: 14,
              color: AppColors.accentSecondary,
            ),
            const SizedBox(width: 8),
            Text(
              'View all packages on pub.dev →',
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.accentSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PackageCard extends StatefulWidget {
  const _PackageCard({required this.pkg, required this.index});
  final OpenSourcePackage pkg;
  final int index;

  @override
  State<_PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<_PackageCard> {
  bool _hovered = false;
  int? _downloads;
  bool _loadingDownloads = false;
  String? _packageVersion;

  @override
  void initState() {
    super.initState();
    _maybeFetchDownloads();
  }

  void _maybeFetchDownloads() async {
    // If the package model already has downloads, use it.
    if (widget.pkg.downloads != null) {
      setState(() => _downloads = widget.pkg.downloads);
      return;
    }

    setState(() => _loadingDownloads = true);
    if (kDebugMode) {
      // ignore: avoid_print
      print('OpenSourceSection: fetching downloads for ${widget.pkg.name}');
    }
    final d = await PubDevService.instance.fetchDownloads(widget.pkg.name);
    if (!mounted) return;
    if (d != null) {
      setState(() {
        _downloads = d;
        _loadingDownloads = false;
      });
      return;
    }

    // No downloads available — try fetching richer package info (version/published)
    final info = await PubDevService.instance.fetchPackageInfo(widget.pkg.name);
    if (!mounted) return;
    setState(() {
      _downloads = info != null ? (info['downloads'] as int?) : null;
      _packageVersion = info != null ? (info['version'] as String?) : null;
      _loadingDownloads = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCard,
                  borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                  border: Border.all(
                    color: _hovered
                        ? AppColors.accentSecondary.withValues(alpha: 0.5)
                        : AppColors.border,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: AppColors.accentSecondary.withValues(
                              alpha: 0.08,
                            ),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Package icon & name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.widgets_rounded,
                          size: 16,
                          color: AppColors.accentSecondary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.pkg.name,
                            maxLines: 2,
                            style: AppTextStyles.mono.copyWith(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: Text(
                        widget.pkg.description,
                        style: AppTextStyles.bodyMedium.copyWith(fontSize: 14),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: widget.pkg.tags
                          .map(
                            (t) => Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.backgroundCardLight,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                t,
                                style: AppTextStyles.mono.copyWith(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _ActionButton(
                            label: 'pub.dev',
                            icon: Icons.open_in_new_rounded,
                            onTap: () =>
                                launchUrl(Uri.parse(widget.pkg.pubUrl)),
                            primary: true,
                          ),
                          if (widget.pkg.githubUrl != null) ...[
                            const SizedBox(width: 8),
                            _ActionButton(
                              label: 'Source',
                              icon: Icons.code_rounded,
                              onTap: () =>
                                  launchUrl(Uri.parse(widget.pkg.githubUrl!)),
                            ),
                          ],

                          const SizedBox(width: 8),
                          const Spacer(),

                          Column(
                            children: [
                              // Display loading, formatted downloads, or version fallback
                              Text(
                                (_downloads != null
                                    ? _formatDownloads(_downloads!)
                                    : '--'),
                                style: AppTextStyles.mono.copyWith(
                                  fontSize: 54,
                                  height: 0.9,
                                  color: AppColors.textMuted.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                              ),
                              Text(
                                'Downloads',
                                style: AppTextStyles.mono.copyWith(
                                  fontSize: 12,
                                  height: 1,
                                  color: AppColors.textMuted.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: (widget.index * 80).ms)
              .fadeIn(duration: 400.ms)
              .slideY(begin: 0.1, end: 0),
    );
  }

  String _formatDownloads(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(1)}M';
    }
    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}k';
    }
    return value.toString();
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.primary = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: primary
              ? AppColors.accentSecondary.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: primary
                ? AppColors.accentSecondary.withValues(alpha: 0.4)
                : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 13,
              color: primary ? AppColors.accentSecondary : AppColors.textMuted,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: AppTextStyles.mono.copyWith(
                fontSize: 11,
                color: primary
                    ? AppColors.accentSecondary
                    : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
