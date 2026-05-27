import 'package:flutter/material.dart';

enum PortfolioSection {
  home,
  about,
  engineering,
  challenges,
  openSource,
  skills,
  experience,
  writing,
  contact,
}

class ScrollProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  // small debounce to avoid flooding listeners while scrolling
  bool _scheduled = false;

  final Map<PortfolioSection, GlobalKey> sectionKeys = {
    for (final s in PortfolioSection.values) s: GlobalKey(),
  };

  PortfolioSection _activeSection = PortfolioSection.home;
  PortfolioSection get activeSection => _activeSection;

  ScrollProvider() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scheduled) return;
    _scheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scheduled = false;
      _updateActiveSectionFromScroll();
    });
  }

  void _updateActiveSectionFromScroll() {
    try {
      // Find the section whose top is closest to the scroll offset
      final positions = <PortfolioSection, double>{};
      for (final entry in sectionKeys.entries) {
        final ctx = entry.value.currentContext;
        if (ctx == null) continue;
        final box = ctx.findRenderObject() as RenderBox?;
        if (box == null) continue;
        final top = box.localToGlobal(Offset.zero, ancestor: null).dy;
        positions[entry.key] = top;
      }
      if (positions.isEmpty) return;
      // Sort by absolute distance to top (y coordinate)
      final active = positions.entries.reduce((a, b) {
        return (a.value.abs() < b.value.abs()) ? a : b;
      }).key;
      setActiveSection(active);
    } catch (_) {
      // ignore errors during measurement
    }
  }

  void setActiveSection(PortfolioSection section) {
    if (_activeSection == section) return;
    _activeSection = section;
    notifyListeners();
  }

  Future<void> scrollToSection(PortfolioSection section) async {
    final key = sectionKeys[section];
    final ctx = key?.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
    setActiveSection(section);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
