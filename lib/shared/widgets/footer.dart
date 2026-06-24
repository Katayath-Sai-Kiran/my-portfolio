import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28, horizontal: hPad),
      decoration: BoxDecoration(
        color: c.textPrimary,
        border: Border(top: BorderSide(color: c.borderStrong, width: 2)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 16,
        spacing: 24,
        children: [
          Text(
            'SAI KIRAN KATAYATH © ${DateTime.now().year}',
            style: AppTextStyles.monoSmall.copyWith(color: c.background, fontSize: 11),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FootLink(label: 'GITHUB', url: AppStrings.githubUrl, c: c),
              _FootLink(label: 'LINKEDIN', url: AppStrings.linkedinUrl, c: c),
              _FootLink(label: 'PUB.DEV', url: AppStrings.pubDevUrl, c: c),
              _FootLink(
                label: 'EMAIL',
                url: 'mailto:${AppStrings.emailAddress}',
                c: c,
                last: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FootLink extends StatefulWidget {
  const _FootLink({
    required this.label,
    required this.url,
    required this.c,
    this.last = false,
  });
  final String label;
  final String url;
  final PortfolioColors c;
  final bool last;

  @override
  State<_FootLink> createState() => _FootLinkState();
}

class _FootLinkState extends State<_FootLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Padding(
          padding: EdgeInsets.only(right: widget.last ? 0 : 18),
          child: Text(
            widget.label,
            style: AppTextStyles.monoSmall.copyWith(
              fontSize: 11,
              color: _hover ? c.accent : c.background,
              decoration: _hover ? TextDecoration.underline : null,
              decorationColor: c.accent,
            ),
          ),
        ),
      ),
    );
  }
}
