import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

class WordsSection extends StatelessWidget {
  const WordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return _WordsView(c: c);
  }
}

const _items = <_Item>[
  _Item(date: 'Apr 14, 2026', title: 'The Accidental Ecosystem', summary: 'How fixing personal frustrations led to 15 packages on pub.dev.', url: 'https://medium.com/@ksaikiran0407/the-accidental-ecosystem', tag: 'Open Source'),
  _Item(date: 'May 2, 2026', title: 'Future-Proofing Flutter', summary: 'What happens when AI can generate UI code? A case for what makes engineers irreplaceable.', url: 'https://medium.com/@ksaikiran0407/future-proofing-flutter', tag: 'AI'),
  _Item(date: 'May 28, 2026', title: 'Dependency Management at Scale', summary: 'Lessons from maintaining a 15-package ecosystem.', url: 'https://medium.com/@ksaikiran0407/dependency-management', tag: 'Engineering'),
  _Item(date: 'Jun 15, 2026', title: 'The AI Shift and pub.dev', summary: 'How AI-assisted development changes the package ecosystem.', url: 'https://medium.com/@ksaikiran0407/ai-shift-pubdev', tag: 'Ecosystem'),
];

class _WordsView extends StatefulWidget {
  const _WordsView({required this.c});
  final PortfolioColors c;
  @override
  State<_WordsView> createState() => _WordsViewState();
}

class _WordsViewState extends State<_WordsView> {
  late PageController _ctrl;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController();
    _ctrl.addListener(() {
      final p = _ctrl.page ?? 0;
      setState(() => _page = p.round());
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _goTo(int i) {
    if (i < 0 || i >= _items.length) return;
    _ctrl.animateToPage(i, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final hPad = ResponsiveHelper.sectionH(context);
    final vPad = ResponsiveHelper.sectionV(context);
    final c = widget.c;
    final csHeight = isMobile ? 320.0 : 380.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forWords(c)),
      padding: EdgeInsets.symmetric(vertical: vPad * 0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: hPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('WORDS', style: AppTypography.monoSmall.copyWith(color: c.accent, fontSize: 11)),
                const SizedBox(height: AppSpacing.sm),
                RichText(
                  text: TextSpan(
                    style: isMobile ? AppTypography.headlineMedium : AppTypography.displayMedium,
                    children: [
                      TextSpan(text: 'Thoughts on software, AI, and the '),
                      TextSpan(text: 'ecosystem', style: TextStyle(fontStyle: FontStyle.italic, color: c.accent)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? csHeight * 0.08 : csHeight * 0.1),
          SizedBox(
            height: csHeight,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _ctrl,
                  itemCount: _items.length,
                  itemBuilder: (_, i) {
                    final d = (_page - i).abs().clamp(0.0, 1.0);
                    final item = _items[i];
                    return Padding(
                      padding: EdgeInsets.only(
                        left: i == 0 ? hPad : hPad * 0.5,
                        right: hPad * 0.5,
                        top: vPad * 0.2,
                        bottom: vPad * 0.2,
                      ),
                      child: Transform.translate(
                        offset: Offset(0, -d * 20),
                        child: Opacity(
                          opacity: 1 - d * 0.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(color: c.accentBg, borderRadius: BorderRadius.circular(4)),
                                    child: Text('${i + 1}/${_items.length}', style: AppTypography.monoSmall.copyWith(color: c.accent, fontSize: 9)),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(item.date, style: AppTypography.monoSmall.copyWith(color: c.textMuted, fontSize: 11)),
                              const SizedBox(height: AppSpacing.sm),
                              Text(item.title, style: (isMobile ? AppTypography.headlineLarge : AppTypography.displayMedium).copyWith(color: c.textPrimary)),
                              const SizedBox(height: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: c.background, borderRadius: BorderRadius.circular(4)),
                                child: Text(item.tag, style: AppTypography.monoSmall.copyWith(color: c.accent, fontSize: 9)),
                              ),
                              const SizedBox(height: AppSpacing.xl),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 540),
                                child: Text(item.summary, style: AppTypography.bodyLarge.copyWith(color: c.textSecondary, height: 1.7)),
                              ),
                              const SizedBox(height: AppSpacing.xxl),
                              GestureDetector(
                                onTap: () => launchUrl(Uri.parse(item.url)),
                                child: Row(
                                  children: [
                                    Text('Read on Medium', style: AppTypography.labelLarge.copyWith(color: c.accent, fontWeight: FontWeight.w600)),
                                    const SizedBox(width: AppSpacing.sm),
                                    Icon(Icons.arrow_outward_rounded, size: 14, color: c.accent),
                                  ],
                                ),
                              ),
                              const Spacer(flex: 2),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (_page < _items.length - 1)
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    width: 140,
                    child: IgnorePointer(
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    c.surface.withValues(alpha: 0),
                                    c.surface.withValues(alpha: 0.85),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 12,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text('next', style: AppTypography.monoSmall.copyWith(fontSize: 8, color: c.textMuted.withValues(alpha: 0.5))),
                                  const SizedBox(height: 4),
                                  ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [c.accent, c.accentSubtle],
                                      stops: const [0.4, 0.6],
                                    ).createShader(bounds),
                                    child: Text(
                                      _items[_page + 1].title,
                                      style: AppTypography.labelLarge.copyWith(
                                        color: Colors.white,
                                        fontSize: 11,
                                        height: 1.3,
                                      ),
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: isMobile ? 12 : 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: hPad),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _page > 0 ? () => _goTo(_page - 1) : null,
                  child: Opacity(
                    opacity: _page > 0 ? 1 : 0.3,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: c.border),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.arrow_back_rounded, size: 16, color: c.textSecondary),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                GestureDetector(
                  onTap: _page < _items.length - 1 ? () => _goTo(_page + 1) : null,
                  child: Opacity(
                    opacity: _page < _items.length - 1 ? 1 : 0.3,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: c.border),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(Icons.arrow_forward_rounded, size: 16, color: c.textSecondary),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  '${_page + 1} / ${_items.length}',
                  style: AppTypography.monoSmall.copyWith(color: c.textMuted, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Item {
  const _Item({required this.date, required this.title, required this.summary, required this.url, required this.tag});
  final String date;
  final String title;
  final String summary;
  final String url;
  final String tag;
}
