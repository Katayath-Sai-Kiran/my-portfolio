import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../providers/scroll_provider.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({super.key});

  static const List<(String, PortfolioSection)> _navItems = [
    (AppStrings.navHome, PortfolioSection.home),
    (AppStrings.navAbout, PortfolioSection.about),
    (AppStrings.navEngineering, PortfolioSection.engineering),
    (AppStrings.navChallenges, PortfolioSection.challenges),
    (AppStrings.navOpenSource, PortfolioSection.openSource),
    (AppStrings.navSkills, PortfolioSection.skills),
    (AppStrings.navExperience, PortfolioSection.experience),
    (AppStrings.navWriting, PortfolioSection.writing),
    (AppStrings.navContact, PortfolioSection.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Container(
      height: AppDimensions.navBarHeight,
      decoration: BoxDecoration(
        color: AppColors.backgroundDark.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveHelper.sectionHorizontalPadding(context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Logo(),
            if (isDesktop) _DesktopNav(navItems: _navItems),
            if (!isDesktop) _MobileMenuButton(navItems: _navItems),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'SK',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: '.',
            style: AppTextStyles.titleLarge.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _DesktopNav extends StatefulWidget {
  const _DesktopNav({required this.navItems});
  final List<(String, PortfolioSection)> navItems;

  @override
  State<_DesktopNav> createState() => _DesktopNavState();
}

class _DesktopNavState extends State<_DesktopNav> {
  final Map<PortfolioSection, GlobalKey> _itemKeys = {};
  double _indicatorLeft = 0;
  double _indicatorWidth = 0;

  @override
  void initState() {
    super.initState();
    for (final item in widget.navItems) {
      final (_, section) = item;
      _itemKeys[section] = GlobalKey();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  @override
  void didUpdateWidget(covariant _DesktopNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());
  }

  void _updateIndicator() {
    final scrollProvider = context.read<ScrollProvider>();
    final active = scrollProvider.activeSection;
    final key = _itemKeys[active];
    if (key == null) return;
    final ctx = key.currentContext;
    if (ctx == null) return;
    final box = ctx.findRenderObject() as RenderBox?;
    final navBarBox = context.findRenderObject() as RenderBox?;
    if (box == null || navBarBox == null) return;
    final left = box.localToGlobal(Offset.zero, ancestor: navBarBox).dx;
    setState(() {
      _indicatorLeft = left;
      _indicatorWidth = box.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.watch<ScrollProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) => _updateIndicator());

    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Row(
          children: widget.navItems.map((item) {
            final (label, section) = item;
            final isActive = scrollProvider.activeSection == section;
            return KeyedSubtree(
              key: _itemKeys[section],
              child: _NavItem(
                label: label,
                isActive: isActive,
                onTap: () => scrollProvider.scrollToSection(section),
              ),
            );
          }).toList(),
        ),
        // Animated single indicator
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: _indicatorLeft,
          bottom: 8,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _indicatorWidth > 0 ? _indicatorWidth : 24,
            height: 2,
            decoration: BoxDecoration(
              color: AppColors.accentSecondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isHighlighted = _hovered || widget.isActive;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: AppTextStyles.navItem.copyWith(
                  color: isHighlighted
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isHighlighted ? 24 : 0,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.navItems});
  final List<(String, PortfolioSection)> navItems;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.textPrimary),
      onPressed: () => _showMobileMenu(context),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final scrollProvider = context.read<ScrollProvider>();
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backgroundCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: navItems.map((item) {
              final (label, section) = item;
              return ListTile(
                title: Text(label, style: AppTextStyles.titleLarge),
                onTap: () {
                  Navigator.pop(context);
                  scrollProvider.scrollToSection(section);
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
