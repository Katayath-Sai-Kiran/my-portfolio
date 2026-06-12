import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Animated code block that types itself out character by character
/// using theme-aware colors.
class TypewriterBlock extends StatefulWidget {
  const TypewriterBlock({super.key});

  @override
  State<TypewriterBlock> createState() => _TypewriterBlockState();
}

class _TypewriterBlockState extends State<TypewriterBlock>
    with SingleTickerProviderStateMixin {
  // Syntax color constants (theme-independent — look good on dark bg)
  static const _purple = Color(0xFF9B59B6);
  static const _green = Color(0xFF1ABC9C);
  static const _muted = Color(0xFF666688);

  static final _segments = <({String text, Color? color})>[
    (text: 'class ', color: _purple),
    (text: 'SaiKiran', color: null), // → textPrimary at build time
    (text: ' {', color: null),
    (text: '\n', color: null),
    (text: '  final ', color: _purple),
    (text: 'experience', color: null), // → accent
    (text: ' = ', color: null),
    (text: "'5 years'", color: _green),
    (text: ';', color: null),
    (text: '\n', color: null),
    (text: '  final ', color: _purple),
    (text: 'focus', color: null),
    (text: ' = ', color: null),
    (text: "'sdk-level'", color: _green),
    (text: ';', color: null),
    (text: '\n', color: null),
    (text: '  final ', color: _purple),
    (text: 'packages', color: null),
    (text: ' = ', color: null),
    (text: '12', color: null), // → orange
    (text: ';', color: null),
    (text: '\n\n', color: null),
    (text: '  // Flutter · Dart · pub.dev', color: _muted),
    (text: '\n', color: null),
    (text: '  ', color: null),
    (text: 'buildPackages', color: null),
    (text: '();', color: null),
    (text: '\n', color: null),
    (text: '}', color: null),
  ];

  // Segment indices that should use accent / orange colors at runtime
  static const Set<int> _accentIdx = {5, 11, 17, 24}; // focus, experience, packages, buildPackages
  static const Set<int> _orangeIdx = {19}; // 12

  static final int _totalChars =
      _segments.fold(0, (sum, s) => sum + s.text.length);

  int _charIndex = 0;
  Timer? _timer;
  late final AnimationController _cursorCtrl;
  late final Animation<double> _cursorBlink;

  @override
  void initState() {
    super.initState();
    _cursorCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
    _cursorBlink = Tween(begin: 0.0, end: 1.0).animate(_cursorCtrl);
    Future.delayed(const Duration(milliseconds: 800), _startTyping);
  }

  void _startTyping() {
    _timer = Timer.periodic(const Duration(milliseconds: 22), (t) {
      if (!mounted) { t.cancel(); return; }
      if (_charIndex >= _totalChars) { t.cancel(); return; }
      setState(() => _charIndex++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _cursorCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.dark.surface, // always dark — code blocks look better
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.dark.border),
        boxShadow: [
          BoxShadow(
            color: c.accent.withValues(alpha: 0.12),
            blurRadius: 60,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _WindowChrome(),
          const SizedBox(height: 20),
          _buildCode(c),
        ],
      ),
    );
  }

  Widget _buildCode(PortfolioColors c) {
    final base = AppTextStyles.mono.copyWith(
      fontSize: 13,
      height: 1.75,
      color: AppColors.dark.textSecondary,
    );
    final spans = <InlineSpan>[];
    int remaining = _charIndex;

    for (int i = 0; i < _segments.length; i++) {
      if (remaining <= 0) break;
      final seg = _segments[i];
      final take = remaining.clamp(0, seg.text.length);
      Color segColor;
      if (seg.color != null) {
        segColor = seg.color!;
      } else if (_accentIdx.contains(i)) {
        segColor = c.accentSubtle;
      } else if (_orangeIdx.contains(i)) {
        segColor = c.orange;
      } else {
        segColor = AppColors.dark.textSecondary;
      }
      spans.add(TextSpan(
        text: seg.text.substring(0, take),
        style: base.copyWith(color: segColor),
      ));
      remaining -= take;
    }

    if (_charIndex < _totalChars) {
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: AnimatedBuilder(
          animation: _cursorBlink,
          builder: (_, __) => Opacity(
            opacity: _cursorBlink.value > 0.5 ? 1.0 : 0.0,
            child: Text('▋', style: base.copyWith(color: c.accent)),
          ),
        ),
      ));
    }

    return Text.rich(TextSpan(children: spans));
  }
}

class _WindowChrome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Dot(color: const Color(0xFFE74C3C)),
        const SizedBox(width: 6),
        _Dot(color: const Color(0xFFF39C12)),
        const SizedBox(width: 6),
        _Dot(color: const Color(0xFF27AE60)),
        const Spacer(),
        Text(
          'sai_kiran.dart',
          style: AppTextStyles.monoSmall.copyWith(
            color: AppColors.dark.textMuted,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 11,
        height: 11,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
