import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/utils/responsive_helper.dart';
import '../providers/scroll_provider.dart';
import '../providers/theme_provider.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({super.key});

  static const List<(String, PortfolioSection)> _navItems = [
    ('Home', PortfolioSection.home),
    ('Packages', PortfolioSection.openSource),
    ('Projects', PortfolioSection.engineering),
    ('Experience', PortfolioSection.experience),
    ('Skills', PortfolioSection.skills),
    ('Writing', PortfolioSection.writing),
    ('Contact', PortfolioSection.contact),
  ];

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final isDesktop = ResponsiveHelper.isDesktop(context);
    final hPad = ResponsiveHelper.sectionHorizontalPadding(context);

    return Container(
      height: AppDimensions.navBarHeight,
      decoration: BoxDecoration(
        color: c.navBg,
        border: Border(bottom: BorderSide(color: c.border, width: 2)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad),
        child: Row(
          children: [
            _Logo(),
            const Spacer(),
            if (isDesktop) _DesktopNav(navItems: _navItems),
            if (!isDesktop) _MobileMenuButton(navItems: _navItems),
            const SizedBox(width: 12),
            _ThemeToggle(),
          ],
        ),
      ),
    );
  }
}

// ── Logo ──────────────────────────────────────────────────────────────────────

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    // Solid ink block with inverted monogram — a stamp, not a wordmark.
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: c.accent,
      child: Text(
        'SK',
        style: AppTextStyles.titleLarge.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
      ),
    );
  }
}

// ── Theme toggle ──────────────────────────────────────────────────────────────

class _ThemeToggle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    final themeProvider = context.watch<ThemeProvider>();

    return Tooltip(
      message: themeProvider.isDark ? 'Switch to light mode' : 'Switch to dark mode',
      child: InkWell(
        onTap: themeProvider.toggle,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          decoration: BoxDecoration(
            color: c.surface,
            border: Border.all(color: c.border, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                themeProvider.isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 14,
                color: c.textPrimary,
              ),
              const SizedBox(width: 6),
              Text(
                (themeProvider.isDark ? 'Light' : 'Dark').toUpperCase(),
                style: AppTextStyles.monoSmall.copyWith(color: c.textPrimary, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Desktop nav ───────────────────────────────────────────────────────────────

class _DesktopNav extends StatefulWidget {
  const _DesktopNav({required this.navItems});
  final List<(String, PortfolioSection)> navItems;

  @override
  State<_DesktopNav> createState() => _DesktopNavState();
}

class _DesktopNavState extends State<_DesktopNav> {
  final Map<PortfolioSection, GlobalKey> _keys = {};

  @override
  void initState() {
    super.initState();
    for (final (_, s) in widget.navItems) {
      _keys[s] = GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.watch<ScrollProvider>();

    return Row(
      children: widget.navItems.map((item) {
        final (label, section) = item;
        final isActive = scrollProvider.activeSection == section;
        return KeyedSubtree(
          key: _keys[section],
          child: _NavItem(
            label: label,
            isActive: isActive,
            onTap: () => scrollProvider.scrollToSection(section),
          ),
        );
      }).toList(),
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
    final c = PortfolioColors.of(context);
    final highlight = _hovered || widget.isActive;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          // Active item gets a solid underline bar; hover paints the accent.
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive ? c.accent : Colors.transparent,
                width: 2.5,
              ),
            ),
          ),
          child: Text(
            widget.label.toUpperCase(),
            style: AppTextStyles.navItem.copyWith(
              color: widget.isActive
                  ? c.textPrimary
                  : (highlight ? c.accent : c.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Mobile menu ───────────────────────────────────────────────────────────────

class _MobileMenuButton extends StatelessWidget {
  const _MobileMenuButton({required this.navItems});
  final List<(String, PortfolioSection)> navItems;

  @override
  Widget build(BuildContext context) {
    final c = PortfolioColors.of(context);
    return IconButton(
      icon: Icon(Icons.menu_rounded, color: c.textSecondary, size: 22),
      onPressed: () => _showMenu(context),
    );
  }

  void _showMenu(BuildContext context) {
    final c = PortfolioColors.of(context);
    final scrollProvider = context.read<ScrollProvider>();

    showModalBottomSheet(
      context: context,
      backgroundColor: c.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: c.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            ...navItems.map((item) {
              final (label, section) = item;
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                title: Text(
                  label,
                  style: AppTextStyles.titleMedium.copyWith(color: c.textPrimary),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded, size: 14, color: c.textMuted),
                onTap: () {
                  Navigator.pop(context);
                  scrollProvider.scrollToSection(section);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
