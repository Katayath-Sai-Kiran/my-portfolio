import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../../shared/widgets/chapter_header.dart';
import '../writings/data/writings_data.dart';
import '../writings/models/writing_model.dart';
import '../writings/views/writing_details_screen.dart';

class WritingSection extends StatelessWidget {
  const WritingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);
    final articles = WritingsData.writings;

    return Container(
      width: double.infinity,
      color: c.surface.withValues(alpha: 0.4),
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: AppDimensions.sectionPaddingVertical,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppDimensions.maxContentWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChapterHeader(
                number: '05',
                title: 'Writing',
                narrative:
                    'I write about the problems that don\'t have a Stack Overflow answer. '
                    'Rendering edge cases, architecture decisions, the kind of thing you '
                    'can only explain after you\'ve already broken it twice.',
              ),
              const SizedBox(height: 64),
              _ArticleList(
                articles: articles,
                onTap: (article) => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => WritingDetailsScreen(article: article),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Article list ──────────────────────────────────────────────────────────────

class _ArticleList extends StatelessWidget {
  const _ArticleList({required this.articles, required this.onTap});
  final List<WritingModel> articles;
  final void Function(WritingModel) onTap;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);

    return Column(
      children: articles.asMap().entries.map((e) {
        final isLast = e.key == articles.length - 1;
        return Column(
          children: [
            _ArticleRow(
              article: e.value,
              ordinal: e.key + 1,
              index: e.key,
              onTap: () => onTap(e.value),
            ),
            if (!isLast)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Container(height: 1, color: c.border),
              ),
          ],
        );
      }).toList(),
    );
  }
}

// ── Article row ───────────────────────────────────────────────────────────────

class _ArticleRow extends StatefulWidget {
  const _ArticleRow({
    required this.article,
    required this.ordinal,
    required this.index,
    required this.onTap,
  });

  final WritingModel article;
  final int ordinal;
  final int index;
  final VoidCallback onTap;

  @override
  State<_ArticleRow> createState() => _ArticleRowState();
}

class _ArticleRowState extends State<_ArticleRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isMobile = ResponsiveHelper.isMobile(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: _hovered ? c.surfaceHover : Colors.transparent,
                borderRadius: BorderRadius.circular(AppDimensions.cardRadius),
                border: Border.all(
                  color: _hovered ? c.border : Colors.transparent,
                ),
              ),
              child: isMobile
                  ? _MobileArticle(article: widget.article, ordinal: widget.ordinal, hovered: _hovered, c: c)
                  : _DesktopArticle(article: widget.article, ordinal: widget.ordinal, hovered: _hovered, c: c),
            )
            .animate(delay: (widget.index * 100).ms)
            .fadeIn(duration: 450.ms)
            .slideY(begin: 0.06, end: 0),
      ),
    );
  }
}

class _DesktopArticle extends StatelessWidget {
  const _DesktopArticle({
    required this.article,
    required this.ordinal,
    required this.hovered,
    required this.c,
  });

  final WritingModel article;
  final int ordinal;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ordinal column
        SizedBox(
          width: 52,
          child: Text(
            ordinal.toString().padLeft(2, '0'),
            style: AppTextStyles.mono.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: hovered ? c.orange : c.border,
              height: 1.1,
            ),
          ),
        ),
        const SizedBox(width: 32),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: AppTextStyles.headlineMedium.copyWith(
                  color: c.textPrimary,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                article.subtitle,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: c.textMuted,
                  height: 1.65,
                  fontStyle: FontStyle.italic,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              _MetaRow(article: article, c: c),
            ],
          ),
        ),

        const SizedBox(width: 40),

        AnimatedOpacity(
          opacity: hovered ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Read',
                  style: AppTextStyles.labelLarge.copyWith(color: c.orange),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_rounded, size: 16, color: c.orange),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileArticle extends StatelessWidget {
  const _MobileArticle({
    required this.article,
    required this.ordinal,
    required this.hovered,
    required this.c,
  });

  final WritingModel article;
  final int ordinal;
  final bool hovered;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ordinal.toString().padLeft(2, '0'),
          style: AppTextStyles.mono.copyWith(
            fontSize: 11,
            color: c.orange,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          article.title,
          style: AppTextStyles.headlineMedium.copyWith(
            color: c.textPrimary,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          article.subtitle,
          style: AppTextStyles.bodyMedium.copyWith(
            color: c.textMuted,
            height: 1.65,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        _MetaRow(article: article, c: c),
      ],
    );
  }
}

// ── Meta row ──────────────────────────────────────────────────────────────────

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.article, required this.c});
  final WritingModel article;
  final PortfolioColors c;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          article.formattedDate,
          style: AppTextStyles.mono.copyWith(fontSize: 11, color: c.textMuted),
        ),
        Container(
          width: 3,
          height: 3,
          decoration: BoxDecoration(color: c.textMuted, shape: BoxShape.circle),
        ),
        Text(
          article.readTime,
          style: AppTextStyles.mono.copyWith(fontSize: 11, color: c.textMuted),
        ),
        ...article.tags.take(2).map(
          (tag) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: c.surface,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: c.border),
            ),
            child: Text(
              tag,
              style: AppTextStyles.mono.copyWith(
                fontSize: 10,
                color: c.textMuted,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
