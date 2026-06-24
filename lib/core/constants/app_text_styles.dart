import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system — brutalist.
/// All styles ship without a color — apply color at the widget level.
/// Display / UI / Body : Archivo    (heavy grotesque, goes to 900)
/// Labels / meta / code : Space Mono (square, mechanical)
abstract final class AppTextStyles {
  // ── Display ───────────────────────────────────────────────────────────────

  /// Hero name, page-defining statements.
  static TextStyle get heroDisplay => GoogleFonts.archivo(
    fontSize: 96,
    fontWeight: FontWeight.w900,
    height: 0.88,
    letterSpacing: -4.0,
  );

  /// Section hero statements.
  static TextStyle get displayLarge => GoogleFonts.archivo(
    fontSize: 64,
    fontWeight: FontWeight.w900,
    height: 0.94,
    letterSpacing: -2.5,
  );

  static TextStyle get displayMedium => GoogleFonts.archivo(
    fontSize: 46,
    fontWeight: FontWeight.w800,
    height: 0.98,
    letterSpacing: -1.6,
  );

  // ── Headlines ─────────────────────────────────────────────────────────────

  static TextStyle get headlineLarge => GoogleFonts.archivo(
    fontSize: 34,
    fontWeight: FontWeight.w800,
    height: 1.05,
    letterSpacing: -1.0,
  );

  static TextStyle get headlineMedium => GoogleFonts.archivo(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.5,
  );

  // ── Titles ────────────────────────────────────────────────────────────────

  static TextStyle get titleLarge => GoogleFonts.archivo(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static TextStyle get titleMedium => GoogleFonts.archivo(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // ── Body ──────────────────────────────────────────────────────────────────

  static TextStyle get bodyLarge => GoogleFonts.archivo(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static TextStyle get bodyMedium => GoogleFonts.archivo(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  static TextStyle get bodySmall => GoogleFonts.archivo(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // ── Labels (Space Mono — usually rendered UPPERCASE at the widget) ──────────

  static TextStyle get labelLarge => GoogleFonts.spaceMono(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.spaceMono(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 1.0,
  );

  // ── Mono ──────────────────────────────────────────────────────────────────

  static TextStyle get mono => GoogleFonts.spaceMono(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle get monoSmall => GoogleFonts.spaceMono(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 1.5,
  );

  // ── Nav ───────────────────────────────────────────────────────────────────

  static TextStyle get navItem => GoogleFonts.spaceMono(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    height: 1.0,
    letterSpacing: 0.5,
  );
}
