import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sai_kiran_portfolio/core/constants/app_colors.dart';

import '../../features/about/about_section.dart';
import '../../features/challenges/challenges_section.dart';
import '../../features/contact/contact_section.dart';
import '../../features/engineering/engineering_section.dart';
import '../../features/experience/experience_section.dart';
import '../../features/hero/hero_section.dart';
import '../../features/open_source/open_source_section.dart';
import '../../features/skills/skills_section.dart';
import '../../features/writing/writing_section.dart';
import '../../shared/providers/scroll_provider.dart';
import '../../shared/widgets/footer.dart';
import '../../shared/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollProvider = context.read<ScrollProvider>();

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollProvider.scrollController,
            child: Column(
              children: [
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.home],
                  child: const HeroSection(),
                ),

                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.about],
                  child: const AboutSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.engineering],
                  child: const EngineeringSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.challenges],
                  child: const ChallengesSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.openSource],
                  child: const OpenSourceSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.skills],
                  child: const SkillsSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.experience],
                  child: const ExperienceSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.writing],
                  child: const WritingSection(),
                ),
                SizedBox(
                  key: scrollProvider.sectionKeys[PortfolioSection.contact],
                  child: const ContactSection(),
                ),
                const PortfolioFooter(),
              ],
            ),
          ),
          const Positioned(top: 0, left: 0, right: 0, child: PortfolioNavBar()),
          // Floating helpers: Hot reload (web, debug) + Scroll-to-top FAB
          const _FloatingHelpers(),
        ],
      ),
    );
  }
}

class _FloatingHelpers extends StatefulWidget {
  const _FloatingHelpers();

  @override
  State<_FloatingHelpers> createState() => _FloatingHelpersState();
}

class _FloatingHelpersState extends State<_FloatingHelpers> {
  late final ScrollProvider _scrollProvider;
  bool _showFab = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollProvider = context.read<ScrollProvider>();
    _scrollProvider.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final show = _scrollProvider.scrollController.offset > 300;
    if (show != _showFab) setState(() => _showFab = show);
  }

  @override
  void dispose() {
    _scrollProvider.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 36,
      bottom: 32,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Scroll to top FAB
          AnimatedScale(
            duration: const Duration(milliseconds: 250),
            scale: _showFab ? 1 : 0,
            child: FloatingActionButton(
              backgroundColor: AppColors.accentSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              heroTag: 'scroll_to_top',
              onPressed: () {
                _scrollProvider.scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );
                _scrollProvider.setActiveSection(PortfolioSection.home);
              },
              mini: true,
              elevation: 6,
              tooltip: 'Back to top',
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: AppColors.backgroundDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
