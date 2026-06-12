import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography system.
/// All styles ship without a color — apply color at the widget level.
/// Heading family : Space Grotesk  (geometric, modern)
/// Body family    : Inter          (readable, clean)
/// Code family    : JetBrains Mono (developer-standard)
abstract final class AppTextStyles {
  // ── Display ───────────────────────────────────────────────────────────────

  /// 80 px / w800 — Hero name, page-defining statements.
  static TextStyle get heroDisplay => GoogleFonts.spaceGrotesk(
    fontSize: 80,
    fontWeight: FontWeight.w800,
    height: 0.92,
    letterSpacing: -3.0,
  );

  /// 56 px / w800 — Section hero statements.
  static TextStyle get displayLarge => GoogleFonts.spaceGrotesk(
    fontSize: 56,
    fontWeight: FontWeight.w800,
    height: 1.0,
    letterSpacing: -2.0,
  );

  /// 44 px / w700
  static TextStyle get displayMedium => GoogleFonts.spaceGrotesk(
    fontSize: 44,
    fontWeight: FontWeight.w700,
    height: 1.05,
    letterSpacing: -1.5,
  );

  // ── Headlines ─────────────────────────────────────────────────────────────

  /// 36 px / w700
  static TextStyle get headlineLarge => GoogleFonts.spaceGrotesk(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -0.8,
  );

  /// 28 px / w600
  static TextStyle get headlineMedium => GoogleFonts.spaceGrotesk(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.5,
  );

  // ── Titles ────────────────────────────────────────────────────────────────

  /// 20 px / w600
  static TextStyle get titleLarge => GoogleFonts.spaceGrotesk(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.35,
    letterSpacing: -0.2,
  );

  /// 17 px / w500
  static TextStyle get titleMedium => GoogleFonts.spaceGrotesk(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  // ── Body ──────────────────────────────────────────────────────────────────

  /// 18 px / w400 / Inter — Long-form reading.
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.75,
  );

  /// 15 px / w400 / Inter
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.65,
  );

  /// 13 px / w400 / Inter
  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.55,
  );

  // ── Labels ────────────────────────────────────────────────────────────────

  /// 13 px / w500 / Inter — Buttons, chips, nav items.
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.1,
  );

  /// 11 px / w500 / Inter — Captions, tags.
  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.3,
  );

  // ── Mono ──────────────────────────────────────────────────────────────────

  /// 13 px / w400 / JetBrains Mono — Code, ordinals, tech labels.
  static TextStyle get mono => GoogleFonts.jetBrainsMono(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.6,
    fontFeatures: [const FontFeature.tabularFigures()],
  );

  /// 11 px / w500 / JetBrains Mono — Small labels, chapter markers.
  static TextStyle get monoSmall => GoogleFonts.jetBrainsMono(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 1.5,
  );

  // ── Nav ───────────────────────────────────────────────────────────────────

  static TextStyle get navItem => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.0,
    letterSpacing: 0.1,
  );
}
