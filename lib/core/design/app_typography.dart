import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTypography {
  // ── Display (Playfair Display) ────────────────────────────────────────────
  static TextStyle get displayHero => GoogleFonts.playfairDisplay(
    fontSize: 86,
    fontWeight: FontWeight.w900,
    height: 0.88,
    letterSpacing: -2.0,
  );

  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
    fontSize: 64,
    fontWeight: FontWeight.w800,
    height: 0.94,
    letterSpacing: -1.0,
  );

  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 0.98,
    letterSpacing: -0.5,
  );

  // ── Headlines (Playfair Display) ─────────────────────────────────────────
  static TextStyle get headlineLarge => GoogleFonts.playfairDisplay(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.05,
  );

  static TextStyle get headlineMedium => GoogleFonts.playfairDisplay(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.15,
  );

  // ── Titles (Inter) ────────────────────────────────────────────────────────
  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, height: 1.3);

  static TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w500, height: 1.4);

  // ── Body (Inter) ──────────────────────────────────────────────────────────
  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400, height: 1.7);

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.65,
  );

  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, height: 1.5);

  // ── Mono (JetBrains Mono) ────────────────────────────────────────────────
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // ── Labels (Inter, uppercase) ─────────────────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.3,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.5,
  );

  // ── Nav (Inter mono-ish) ──────────────────────────────────────────────────
  static TextStyle get navItem => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.3,
  );
}
