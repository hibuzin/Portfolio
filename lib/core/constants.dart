import 'package:flutter/material.dart';

// ─── Colors ────────────────────────────────────────────────────────
class AppColors {
  AppColors._();

  static const bg = Color(0xFF080B14);
  static const surface = Color(0xFF0F1525);
  static const card = Color(0xFF141B2D);
  static const cardBorder = Color(0xFF1E2A45);

  static const cyan = Color(0xFF00D4FF);
  static const cyanDim = Color(0xFF0099BB);
  static const green = Color(0xFF00FF88);
  static const purple = Color(0xFF7B61FF);

  static const white = Color(0xFFFFFFFF);
  static const white80 = Color(0xCCFFFFFF);
  static const white50 = Color(0x80FFFFFF);
  static const white20 = Color(0x33FFFFFF);
  static const white10 = Color(0x1AFFFFFF);

  static const gradient1 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [cyan, purple],
  );

  static const gradient2 = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF00D4FF), Color(0xFF00FF88)],
  );
}

// ─── Text Styles ───────────────────────────────────────────────────
class AppText {
  AppText._();

  static const display = TextStyle(
    fontFamily: 'Courier',
    fontSize: 54,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    height: 1.0,
    letterSpacing: 1,
  );

  static const displayMobile = TextStyle(
    fontFamily: 'Courier',
    fontSize: 38,
    fontWeight: FontWeight.w900,
    color: AppColors.white,
    height: 1.05,
    letterSpacing: -1,
  );

  static const heading = TextStyle(
    fontFamily: 'Courier',
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.1,
    letterSpacing: 2,
  );

  static const headingMobile = TextStyle(
    fontFamily: 'Courier',
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    height: 1.1,
  );

  static const label = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    color: AppColors.cyan,
    letterSpacing: 3,
  );

  static const body = TextStyle(
    fontSize: 16,
    color: AppColors.white50,
    height: 1.75,
    letterSpacing: 0.1,
  );

  static const bodySmall = TextStyle(
    fontSize: 13,
    color: AppColors.white50,
    height: 1.6,
  );
}

// ─── Spacing ───────────────────────────────────────────────────────
class AppSpacing {
  AppSpacing._();
  static const sectionV = 100.0;
  static const sectionH = 80.0;
  static const sectionHMobile = 24.0;
}