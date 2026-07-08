import 'package:flutter/material.dart';
import '../../core/design/app_colors.dart';
import '../../core/design/app_gradients.dart';
import '../../core/design/app_spacing.dart';
import '../../core/design/app_typography.dart';
import '../../core/utils/responsive_helper.dart';

class ShipmentsSection extends StatelessWidget {
  const ShipmentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return _ShipmentsView(c: c);
  }
}

const _items = <_Item>[
  _Item(year: '2026', title: 'AI Engine Ecosystem', tag: 'On-device intelligence', body: 'Three packages that bring offline ML to Flutter. A 23MB MiniLM model powers semantic understanding without a server.'),
  _Item(year: '2025', title: 'Semantic Search', tag: 'Meaning-aware queries', body: 'Query-driven search that understands intent, not just keywords. Debounced input, MMR diversity ranking, typed results.'),
  _Item(year: '2025', title: 'Smart Suggestions', tag: 'Anchor-based recommendations', body: 'MMR diverse suggestions, multi-anchor centroid matching, and a pluggable widget layer — all on-device.'),
  _Item(year: '2024', title: 'Resumable Upload', tag: 'Chunked, fault-tolerant', body: 'Production upload engine with chunked transfer, retry logic, and progress tracking for unreliable mobile networks.'),
  _Item(year: '2024', title: 'Custom Media Player', tag: 'ExoPlayer + Flutter UI', body: 'Full-featured video player with custom controls, playlist management, and native Kotlin bridge for platform-level playback.'),
  _Item(year: '2023', title: 'Text Rendering', tag: 'Rich text, custom layouts', body: 'Multi-package text ecosystem covering styling, formatting, and layout. Custom painter-based rendering beyond Text.rich.'),
];

class _ShipmentsView extends StatefulWidget {
  const _ShipmentsView({required this.c});
  final PortfolioColors c;
  @override
  State<_ShipmentsView> createState() => _ShipmentsViewState();
}

class _ShipmentsViewState extends State<_ShipmentsView> {
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
    final csHeight = isMobile ? 340.0 : 400.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(gradient: AppGradients.forShipments(c)),
      padding: EdgeInsets.symmetric(vertical: vPad * 0.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: hPad),
            child: Text('SHIPMENTS', style: AppTypography.monoSmall.copyWith(color: c.accent, fontSize: 11)),
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
                              Text(item.year, style: AppTypography.monoSmall.copyWith(color: c.accent, fontSize: 12)),
                              const SizedBox(height: AppSpacing.sm),
                              Text(item.title, style: (isMobile ? AppTypography.headlineLarge : AppTypography.displayMedium).copyWith(color: c.textPrimary)),
                              const SizedBox(height: AppSpacing.sm),
                              Text(item.tag, style: AppTypography.titleMedium.copyWith(color: c.accentSubtle)),
                              const SizedBox(height: AppSpacing.xl),
                              ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 540),
                                child: Text(item.body, style: AppTypography.bodyLarge.copyWith(color: c.textSecondary, height: 1.7)),
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
                                    c.background.withValues(alpha: 0),
                                    c.background.withValues(alpha: 0.85),
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
  const _Item({required this.year, required this.title, required this.tag, required this.body});
  final String year;
  final String title;
  final String tag;
  final String body;
}
