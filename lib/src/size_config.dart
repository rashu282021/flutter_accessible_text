import 'package:flutter/widgets.dart';


//////////////////////////////////////////////
// Text Scaling Guidelines (WCAG + Material)

//////////////////////////////////////////////

// Use sp() (full scaling) for:
// - Body text / paragraphs
// - List tiles / descriptions
// - Inline content / values
// Reason: These are informational and should respect user text size fully.

// Use spCapped() for:
// - AppBar titles        (maxFactor: 1.25–1.3)
// - TabBar labels        (maxFactor: 1.25–1.3)
// - Button labels        (maxFactor: 1.25)
// - Chip labels / badges (maxFactor: 1.2)
// - Form labels / helper text (maxFactor: 1.25)
// - Navigation drawer items (maxFactor: 1.25)
// Reason: These are UI chrome; capping prevents layout breakage at XXL.

// Rule of thumb:
// Chrome/UI → spCapped()
// Content → sp()
//////////////////////////////////////////////

//or use this helper/////////////////////////
// enum TextRole {
//   chrome, // Navigation, buttons, tabs
//   content, // Paragraphs, values, descriptions
// }

// class TextScalerHelper {
//   static double scaledFont(
//     double baseSize,
//     TextRole role, {
//     double chromeMaxFactor = 1.3,
//   }) {
//     switch (role) {
//       case TextRole.chrome:
//         return SizeConfig.spCapped(baseSize, maxFactor: chromeMaxFactor);
//       case TextRole.content:
//         return SizeConfig.sp(baseSize);
//     }
//   }
// }



// // Content (weight, name, values)
// fontSize: SizeConfig.font(context, 14)

// // Chrome (buttons, tabs, labels)
// fontSize: SizeConfig.font(context, 16, isChrome: true)

//WidgetsBinding.instance.platformDispatcher.textScaleFactor → works if user changes accessibility font size at runtime.

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double textScaleFactor;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late TextScaler textScaler;
  static double _currentScale = 1.0;

  static void init(BuildContext context) {
    final media = MediaQuery.of(context);
    textScaler = media.textScaler; // Full 200%+ support
    screenWidth = media.size.width;
    screenHeight = media.size.height;
    // _currentScale = textScaler.scale(1.0);
    // _currentScale = 1.0; // optional, can adjust based on device if needed
    _currentScale = textScaler.scale(1.0);

    // if (SizeConfig.isExtremeText) {
    //   textScaler = media.textScaler; // Full scaling
    // } else if (SizeConfig.isLargeText) {
    //   textScaler = media.textScaler.clamp(
    //     minScaleFactor: 1.0,
    //     maxScaleFactor: 1.3,
    //   );
    // } else {
    //   textScaler = media.textScaler;
    // }
    final padding = media.padding;
    safeBlockHorizontal = (screenWidth - padding.left - padding.right) / 100;
    safeBlockVertical = (screenHeight - padding.top - padding.bottom) / 100;

  }



  /// Global flag for large text

  static double get textScale => textScaler.scale(1.0);
  static bool get isLargeText => textScale >= 1.3; // Material “Large”
  static bool get isXLText => textScale >= 2.0; // Accessibility Large
  static bool get isExtremeText => textScale >= 2.5; // 300%+  support
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide >= 600;
  // Fonts: Full WCAG scaling
  //Content Text: full scaling (Flutter applies system textScaleFactor automatically)
  static double sp(double fontSize) => fontSize;

  //Fonts: Capped scaling for navigation/chrome
  /// Chrome/UI Text: capped scaling to prevent layout breakage
  // static double spCapped(double fontSize, {double maxFactor = 1.3}) {
  //   final systemScale =
  //       WidgetsBinding.instance.platformDispatcher.textScaleFactor;
  //
  //   final clamped = systemScale.clamp(1.0, maxFactor);
  //   return fontSize * clamped;
  // }
  static double spCapped(BuildContext context, double fontSize,
      {double maxFactor = 1.3}) {
    final systemScale = MediaQuery.textScalerOf(context).scale(1.0);
    final clamped = systemScale.clamp(1.0, maxFactor);
    return fontSize * clamped;
  }

  /// GLOBAL: Auto-selects sp/spCapped based on content type
  static double font(
      BuildContext context,
      double baseSize, {
        bool isChrome = false,
      }) {
    final adaptedSize = adaptiveBaseSize(context, baseSize);
    if (isChrome) {
      return spCapped(context,adaptedSize, maxFactor: isLargeText ? 1.25 : 1.3);
    }
    return sp(adaptedSize); // Content = full scaling
  }


  /// Adjust base size for tablets
  /// /// GLOBAL: Auto-adjusts baseSize based on device/text scale
  // static double adaptiveBaseSize(double baseSize, {bool isTablet = false}) {
  //   if (isTablet && isLargeText) return baseSize;
  //   if (isTablet) return baseSize * 1.1;
  //   return baseSize; // Mobile = full
  // }
  static double adaptiveBaseSize( BuildContext context,double baseSize) {
    if (isTablet(context)) {
      return baseSize * 1.1; // slightly larger for tablets
    }
    return baseSize; // mobile stays same
  }

//////////////This prevents layout explosion at 200%–300%.//////////////////
  // Layout: Minimal cap (Material 1.3-1.4x recommended)
  static double h(double size) => size * _currentScale.clamp(1.0, 1.4);
  static double w(double size) => size * _currentScale.clamp(1.0, 1.25);



  /// UI elements - Layout scaling
  static double scale(double size) => size * _currentScale.clamp(1.0, 1.4);

  /// Icons - WCAG 2.5.8
  // static double icon(double baseSize) {
  //   final systemScale =
  //       WidgetsBinding.instance.platformDispatcher.textScaleFactor;
  //   return (baseSize * systemScale)
  //       .clamp(baseSize, baseSize * 1.4)
  //       .clamp(24.0, 48.0);
  // }
  static double icon(double baseSize) {
    final scaled = baseSize * _currentScale;

    return scaled
        .clamp(baseSize, baseSize * 1.4) // mild growth
        .clamp(24.0, 48.0);              // WCAG-safe bounds
  }

  /// Touch targets - 44dp min (AAA)
  // static double touchTarget(double baseSize) {
  //   final systemScale =
  //       WidgetsBinding.instance.platformDispatcher.textScaleFactor;
  //   return (baseSize * systemScale).clamp(44.0, 56.0);
  // }
  static double touchTarget(double baseSize) {
    final scaled = baseSize * _currentScale;

    return scaled.clamp(44.0, 56.0);
  }


  static void debugSize({
    double sampleFont = 13,
    double sampleH = 40,
    double sampleW = 30,
  }) {
    final scale = textScaler.scale(1.0);
    final effectiveFont = sp(sampleFont);
    final effectiveH = h(sampleH);
    final effectiveW = w(sampleW);
    final effectiveIcon24 = icon(24);
    final effectiveTouch44 = touchTarget(44);

    debugPrint(
      '[SizeConfig] textScale=$scale '
          '| sp($sampleFont)=$effectiveFont '
          '| h($sampleH)=$effectiveH '
          '| w($sampleW)=$effectiveW '
          '| icon(24)=$effectiveIcon24 '
          '| touchTarget(44)=$effectiveTouch44',
    );
  }
}
