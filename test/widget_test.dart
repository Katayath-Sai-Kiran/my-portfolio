import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sai_kiran_portfolio/app.dart';
import 'package:sai_kiran_portfolio/shared/providers/scroll_provider.dart';
import 'package:sai_kiran_portfolio/shared/providers/theme_provider.dart';
import 'package:sai_kiran_portfolio/shared/widgets/nav_bar.dart';

Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1920, 1080);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScrollProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const PortfolioApp(),
    ),
  );
  await tester.pump(const Duration(milliseconds: 500));
}

void main() {
  testWidgets('renders without errors', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Preface section displays name', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.textContaining('SAI KIRAN'), findsWidgets);
  });

  testWidgets('NavBar renders', (WidgetTester tester) async {
    await pumpApp(tester);
    expect(find.byType(PortfolioNavBar), findsWidgets);
  });

  testWidgets('ScrollProvider initialises with preface section', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);
    final context = tester.element(find.byType(MaterialApp));
    final provider = Provider.of<ScrollProvider>(context, listen: false);
    expect(provider.activeSection, PortfolioSection.hero);
    expect(provider, isNotNull);
  });

  testWidgets('ScrollProvider setActiveSection notifies listeners', (
    WidgetTester tester,
  ) async {
    final provider = ScrollProvider();
    int notifyCount = 0;
    provider.addListener(() => notifyCount++);

    provider.setActiveSection(PortfolioSection.featuredProject);

    expect(provider.activeSection, PortfolioSection.articles);
    expect(notifyCount, 1);
    provider.dispose();
  });

  testWidgets('ScrollProvider does not notify if same section set', (
    WidgetTester tester,
  ) async {
    final provider = ScrollProvider();
    int notifyCount = 0;
    provider.addListener(() => notifyCount++);

    provider.setActiveSection(PortfolioSection.hero);

    expect(notifyCount, 0);
    provider.dispose();
  });
}
