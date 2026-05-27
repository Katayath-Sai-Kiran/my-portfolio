import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sai_kiran_portfolio/main.dart';
import 'package:sai_kiran_portfolio/core/constants/app_strings.dart';
import 'package:sai_kiran_portfolio/shared/providers/scroll_provider.dart';

/// Pump the app at a desktop resolution to avoid layout overflows in tests.
Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1920, 1080);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const PortfolioApp());
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('PortfolioApp renders without errors', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Hero section displays name', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.textContaining(AppStrings.heroName), findsWidgets);
  });

  testWidgets('Hero section displays title', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.textContaining('Flutter Developer'), findsWidgets);
  });

  testWidgets('NavBar renders logo via RichText', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.byType(RichText), findsWidgets);
  });

  testWidgets('NavBar shows desktop nav items at 1440px', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    expect(find.text(AppStrings.navHome), findsWidgets);
    expect(find.text(AppStrings.navEngineering), findsWidgets);
    expect(find.text(AppStrings.navContact), findsWidgets);
  });

  testWidgets('ScrollProvider initialises with home section', (
    WidgetTester tester,
  ) async {
    final provider = ScrollProvider();
    expect(provider.activeSection, PortfolioSection.home);
    provider.dispose();
  });

  testWidgets('ScrollProvider setActiveSection notifies listeners', (
    WidgetTester tester,
  ) async {
    final provider = ScrollProvider();
    int notifyCount = 0;
    provider.addListener(() => notifyCount++);

    provider.setActiveSection(PortfolioSection.about);

    expect(provider.activeSection, PortfolioSection.about);
    expect(notifyCount, 1);
    provider.dispose();
  });

  testWidgets('ScrollProvider does not notify if same section set', (
    WidgetTester tester,
  ) async {
    final provider = ScrollProvider();
    int notifyCount = 0;
    provider.addListener(() => notifyCount++);

    provider.setActiveSection(PortfolioSection.home);

    expect(notifyCount, 0);
    provider.dispose();
  });

  testWidgets('AppStrings constants are not empty', (
    WidgetTester tester,
  ) async {
    expect(AppStrings.heroName, isNotEmpty);
    expect(AppStrings.heroTitle, isNotEmpty);
    expect(AppStrings.siteUrl, isNotEmpty);
    expect(AppStrings.emailAddress, isNotEmpty);
  });

  testWidgets('ScrollProvider is accessible from widget tree', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    final context = tester.element(find.byType(MaterialApp));
    final provider = Provider.of<ScrollProvider>(context, listen: false);
    expect(provider, isNotNull);
    expect(provider.activeSection, PortfolioSection.home);
  });
}
