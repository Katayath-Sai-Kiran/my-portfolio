import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppGradients {
  static LinearGradient forPreface(PortfolioColors c) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c.surface, c.background],
  );

  static LinearGradient forManifesto(PortfolioColors c) => LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [c.surface, c.background],
  );

  static LinearGradient forJourney(PortfolioColors c) => LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [c.surface, c.background],
  );

  static RadialGradient forShipments(PortfolioColors c) => RadialGradient(
    center: Alignment.center,
    radius: 1.2,
    colors: [c.accentBg, c.background],
  );

  static LinearGradient forEcosystem(PortfolioColors c) => LinearGradient(
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
    colors: [c.surface, c.background],
  );

  static LinearGradient forWords(PortfolioColors c) => LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [c.surface, c.background],
  );

  static LinearGradient forNow(PortfolioColors c) => LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [c.accentBg, c.background],
  );

  static RadialGradient forColophon(PortfolioColors c) => RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [c.surface, c.background],
    stops: const [0.3, 1.0],
  );

  static LinearGradient forCraft(PortfolioColors c) => LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [c.surface, c.background],
  );

  static LinearGradient forCard(PortfolioColors c) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c.surface, c.surfaceHover],
  );

  static LinearGradient forQuote(PortfolioColors c) => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [c.background, c.surface],
  );
}
