import 'package:flutter/material.dart';
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

class _PackageCard extends StatefulWidget {
  const _PackageCard({required this.pkg, required this.index});
  final OpenSourcePackage pkg;
  final int index;

  @override
  State<_PackageCard> createState() => _PackageCardState();
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
              ? AppColors.accentSecondary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: primary
                ? AppColors.accentSecondary.withOpacity(0.4)
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

/// Open Source section: shows cards for each package with downloads and hover details.
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
      // const _PubDevLink();
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
              const _PubDevLink(),
              const SizedBox(height: 44),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? 1.3 : (isTablet ? 1.1 : 1.5),
                children: PortfolioData.packages
                    .map(
                      (p) => _PackageCard(
                        pkg: p,
                        index: PortfolioData.packages.indexOf(p),
                      ),
                    )
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
  const _PubDevLink();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(AppStrings.pubDevUrl)),
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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

class _PackageCardState extends State<_PackageCard> {
  bool _hovered = false;
  int? _downloads;
  bool _loadingDownloads = false;
  String? _packageVersion;
  String? _published;

  @override
  void initState() {
    super.initState();
    _maybeFetchDownloads();
  }

  Future<void> _maybeFetchDownloads() async {
    if (widget.pkg.downloads != null) {
      setState(() => _downloads = widget.pkg.downloads);
      return;
    }

    setState(() => _loadingDownloads = true);
    try {
      final d = await PubDevService.instance.fetchDownloads(widget.pkg.name);
      if (!mounted) return;
      if (d != null) {
        setState(() {
          _downloads = d;
          _loadingDownloads = false;
        });
        return;
      }

      final info = await PubDevService.instance.fetchPackageInfo(
        widget.pkg.name,
      );
      if (!mounted) return;
      setState(() {
        _downloads = info != null ? (info['downloads'] as int?) : null;
        _packageVersion = info != null ? (info['version'] as String?) : null;
        if (info != null && info['published'] != null) {
          final raw = info['published'] as String?;
          final dt = raw != null ? DateTime.tryParse(raw) : null;
          _published = dt != null
              ? dt.toLocal().toIso8601String().split('T').first
              : raw;
        } else {
          _published = null;
        }
        _loadingDownloads = false;
      });
    } catch (err) {
      if (kDebugMode)
        debugPrint('PubDev fetch error for ${widget.pkg.name}: $err');
      if (!mounted) return;
      setState(() => _loadingDownloads = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: SizedBox(
        height: 240,
        child: Stack(
          clipBehavior: Clip.none,
          children: [_buildCard(), _buildOverlay()],
        ),
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
        border: Border.all(
          color: _hovered
              ? AppColors.accentSecondary.withOpacity(0.5)
              : AppColors.border,
        ),
        boxShadow: _hovered
            ? [
                BoxShadow(
                  color: AppColors.accentSecondary.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
            children: widget.pkg.tags.map<Widget>((t) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.backgroundCardLight,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  t,
                  style: AppTextStyles.mono.copyWith(fontSize: 10),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _ActionButton(
                  label: 'pub.dev',
                  icon: Icons.open_in_new_rounded,
                  onTap: () => launchUrl(Uri.parse(widget.pkg.pubUrl)),
                  primary: true,
                ),
                if (widget.pkg.githubUrl != null) ...[
                  const SizedBox(width: 8),
                  _ActionButton(
                    label: 'Source',
                    icon: Icons.code_rounded,
                    onTap: () => launchUrl(Uri.parse(widget.pkg.githubUrl!)),
                  ),
                ],
                const SizedBox(width: 8),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      _loadingDownloads
                          ? '…'
                          : (_downloads != null
                                ? _formatDownloads(_downloads!)
                                : (_packageVersion != null
                                      ? 'v$_packageVersion'
                                      : '--')),
                      style: AppTextStyles.mono.copyWith(
                        fontSize: 54,
                        height: 0.9,
                        color: AppColors.textMuted.withOpacity(0.4),
                      ),
                    ),
                    Text(
                      'Downloads',
                      style: AppTextStyles.mono.copyWith(
                        fontSize: 12,
                        height: 1,
                        color: AppColors.textMuted.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlay() {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      top: 12,
      bottom: 12,
      right: _hovered ? 12 : -220,
      width: 150,
      child: IgnorePointer(
        ignoring: !_hovered,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: _hovered ? 1.0 : 0.0,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundDark.withOpacity(0.92),
              borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(-6, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Version:',
                      style: AppTextStyles.mono.copyWith(fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.pkg.version != null
                            ? 'v${widget.pkg.version}'
                            : '--',
                        style: AppTextStyles.mono.copyWith(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      'Published:',
                      style: AppTextStyles.mono.copyWith(fontSize: 11),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _published ?? '--',
                        style: AppTextStyles.mono.copyWith(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: _ActionButton(
                        label: 'Open',
                        icon: Icons.open_in_new_rounded,
                        onTap: () => launchUrl(Uri.parse(widget.pkg.pubUrl)),
                        primary: true,
                      ),
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

  String _formatDownloads(int value) {
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}k';
    return value.toString();
  }
}
