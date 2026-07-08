import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_typography.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: c.textPrimary,
        border: Border(top: BorderSide(color: c.textPrimary)),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 16,
        spacing: 24,
        children: [
          Text(
            'SAI KIRAN KATAYATH © ${DateTime.now().year}',
            style: AppTypography.monoSmall.copyWith(
              color: c.background,
              fontSize: 11,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _FootLink(
                label: 'GITHUB',
                url: 'https://github.com/Katayath-Sai-Kiran',
                c: c,
              ),
              _FootLink(
                label: 'LINKEDIN',
                url: 'https://www.linkedin.com/in/sai-kiran-katayath-6687941a5/',
                c: c,
              ),
              _FootLink(
                label: 'PUB.DEV',
                url: 'https://pub.dev/publishers/ksaikiran.dev/packages',
                c: c,
              ),
              _FootLink(
                label: 'EMAIL',
                url: 'mailto:ksaikiran0407@gmail.com',
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
            style: AppTypography.monoSmall.copyWith(
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
