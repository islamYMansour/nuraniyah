import 'package:flutter/material.dart';

/// Type families for the Noor design system.
///
/// Noor is Arabic-first, so [primary] must be a face with a complete Arabic
/// character set and well-drawn harakat. Tajawal is the intended face; until
/// its `.ttf` files are bundled (see `lib/design_system/README.md`) Flutter
/// falls back through [fallback] to the platform's Arabic system font, which
/// renders correctly on every target.
abstract final class AppFontFamily {
  /// The one family the whole app uses, Arabic and Latin alike.
  static const String primary = 'Tajawal';

  /// Resolved in order when a glyph is missing from [primary].
  ///
  /// `Noto Sans Arabic` covers Android, `Geeza Pro` covers iOS/macOS.
  static const List<String> fallback = <String>[
    'Cairo',
    'Noto Sans Arabic',
    'Geeza Pro',
    'Segoe UI',
  ];
}

/// The weight ramp. Five steps — anything outside this set is off-system.
abstract final class AppFontWeight {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}

/// The size ramp, in logical pixels, measured off the design artboard
/// (804×1748 @2x → 402×874pt).
abstract final class AppFontSize {
  static const double caption = 12;
  static const double small = 14;
  static const double base = 16;
  static const double medium = 18;
  static const double large = 20;
  static const double xLarge = 22;
  static const double xxLarge = 24;
  static const double h3 = 28;
  static const double h2 = 32;
  static const double h1 = 36;
  static const double display2 = 44;
  static const double display1 = 56;
}

/// Line-height multipliers (Flutter's `TextStyle.height`).
///
/// Arabic sits taller than Latin: harakat rise above the letter body and
/// several letters descend well below the baseline. [arabic] and [loose] give
/// that ink room, which is why Noor's body copy is looser than a Latin app's.
abstract final class AppLineHeight {
  static const double tight = 1.30;
  static const double snug = 1.35;
  static const double normal = 1.45;
  static const double relaxed = 1.50;
  static const double loose = 1.70;
  static const double arabic = 1.75;
}

/// Letter spacing, in logical pixels.
///
/// Arabic is cursive: its letters join. Positive tracking forces gaps into
/// those joins and makes a word look broken, so every Noor text style ships
/// with [none]. [latinWide] exists only for Latin-only strings — version
/// numbers, locale switchers — and must never be applied to Arabic.
abstract final class AppLetterSpacing {
  static const double none = 0;
  static const double latinWide = 0.4;
}

/// Semantic text-style tokens for the Noor design system.
///
/// Registered as a [ThemeExtension] by [AppTheme] and reachable anywhere via
/// `context.typography`. Colour is *not* baked in: every style here carries
/// size, weight, height and tracking only, and inherits its colour from the
/// surrounding [DefaultTextStyle] or an explicit `context.colors` token.
///
/// ```dart
/// Text(title, style: context.typography.headlineMedium
///     .copyWith(color: context.colors.textPrimary));
/// ```
@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.wordmark,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
    required this.caption,
    required this.button,
  });

  /// The "نُور" logo lockup. One use only — the brand mark itself.
  final TextStyle wordmark;

  /// Splash / celebration headlines.
  final TextStyle displayLarge;

  /// Large hero numbers and letters.
  final TextStyle displayMedium;

  /// Section hero text.
  final TextStyle displaySmall;

  /// Screen titles.
  final TextStyle headlineLarge;

  /// Card and dialog titles.
  final TextStyle headlineMedium;

  /// Sub-section titles.
  final TextStyle headlineSmall;

  /// App bar title, prominent list headers.
  final TextStyle titleLarge;

  /// List tile titles.
  final TextStyle titleMedium;

  /// Dense list titles, tab labels.
  final TextStyle titleSmall;

  /// Lead paragraph — the onboarding subtitle.
  final TextStyle bodyLarge;

  /// Default body copy.
  final TextStyle bodyMedium;

  /// Secondary body copy, helper text.
  final TextStyle bodySmall;

  /// Form labels, chips, prominent metadata.
  final TextStyle labelLarge;

  /// Compact labels — the "تسجيل الدخول" link.
  final TextStyle labelMedium;

  /// Badges, counters, overlines.
  final TextStyle labelSmall;

  /// Timestamps, footnotes, image captions.
  final TextStyle caption;

  /// Primary button label — "هيّا نبدأ" in the design.
  final TextStyle button;

  /// Builds one on-system style. Private so that no caller can invent a
  /// size, weight or tracking that is not on the ramp above.
  static TextStyle _style({
    required double size,
    required FontWeight weight,
    required double height,
  }) {
    return TextStyle(
      fontFamily: AppFontFamily.primary,
      fontFamilyFallback: AppFontFamily.fallback,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: AppLetterSpacing.none,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  /// The Noor type scale.
  ///
  /// Type does not change between light and dark, so there is a single
  /// set — only colour flips.
  static final AppTypography standard = AppTypography(
    wordmark: _style(
      size: AppFontSize.display1,
      weight: AppFontWeight.extraBold,
      height: AppLineHeight.tight,
    ),
    displayLarge: _style(
      size: AppFontSize.display1,
      weight: AppFontWeight.bold,
      height: AppLineHeight.tight,
    ),
    displayMedium: _style(
      size: AppFontSize.display2,
      weight: AppFontWeight.bold,
      height: AppLineHeight.tight,
    ),
    displaySmall: _style(
      size: AppFontSize.h1,
      weight: AppFontWeight.bold,
      height: AppLineHeight.snug,
    ),
    headlineLarge: _style(
      size: AppFontSize.h2,
      weight: AppFontWeight.bold,
      height: AppLineHeight.snug,
    ),
    headlineMedium: _style(
      size: AppFontSize.h3,
      weight: AppFontWeight.bold,
      height: AppLineHeight.snug,
    ),
    headlineSmall: _style(
      size: AppFontSize.xxLarge,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.normal,
    ),
    titleLarge: _style(
      size: AppFontSize.xLarge,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.normal,
    ),
    titleMedium: _style(
      size: AppFontSize.large,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.normal,
    ),
    titleSmall: _style(
      size: AppFontSize.medium,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.relaxed,
    ),
    bodyLarge: _style(
      size: AppFontSize.medium,
      weight: AppFontWeight.regular,
      height: AppLineHeight.arabic,
    ),
    bodyMedium: _style(
      size: AppFontSize.base,
      weight: AppFontWeight.regular,
      height: AppLineHeight.arabic,
    ),
    bodySmall: _style(
      size: AppFontSize.small,
      weight: AppFontWeight.regular,
      height: AppLineHeight.loose,
    ),
    labelLarge: _style(
      size: AppFontSize.base,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.normal,
    ),
    labelMedium: _style(
      size: AppFontSize.small,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.normal,
    ),
    labelSmall: _style(
      size: AppFontSize.caption,
      weight: AppFontWeight.semiBold,
      height: AppLineHeight.snug,
    ),
    caption: _style(
      size: AppFontSize.caption,
      weight: AppFontWeight.regular,
      height: AppLineHeight.relaxed,
    ),
    button: _style(
      size: AppFontSize.xLarge,
      weight: AppFontWeight.bold,
      height: AppLineHeight.tight,
    ),
  );

  /// Projects these tokens onto Material's [TextTheme], so widgets that
  /// read `Theme.of(context).textTheme` stay on-system too.
  TextTheme toTextTheme() {
    return TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
      labelSmall: labelSmall,
    );
  }

  /// Returns a copy with every font size multiplied by [factor].
  ///
  /// Used by [AppTheme.responsiveBuilder] to apply
  /// [AppBreakpoint.typeScale]. Heights are multipliers, not absolute values,
  /// so they scale with the size automatically and are left alone.
  AppTypography scaledBy(double factor) {
    if (factor == 1) {
      return this;
    }
    TextStyle scale(TextStyle style) =>
        style.copyWith(fontSize: (style.fontSize ?? 0) * factor);

    return AppTypography(
      wordmark: scale(wordmark),
      displayLarge: scale(displayLarge),
      displayMedium: scale(displayMedium),
      displaySmall: scale(displaySmall),
      headlineLarge: scale(headlineLarge),
      headlineMedium: scale(headlineMedium),
      headlineSmall: scale(headlineSmall),
      titleLarge: scale(titleLarge),
      titleMedium: scale(titleMedium),
      titleSmall: scale(titleSmall),
      bodyLarge: scale(bodyLarge),
      bodyMedium: scale(bodyMedium),
      bodySmall: scale(bodySmall),
      labelLarge: scale(labelLarge),
      labelMedium: scale(labelMedium),
      labelSmall: scale(labelSmall),
      caption: scale(caption),
      button: scale(button),
    );
  }

  @override
  AppTypography copyWith({
    TextStyle? wordmark,
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
    TextStyle? caption,
    TextStyle? button,
  }) {
    return AppTypography(
      wordmark: wordmark ?? this.wordmark,
      displayLarge: displayLarge ?? this.displayLarge,
      displayMedium: displayMedium ?? this.displayMedium,
      displaySmall: displaySmall ?? this.displaySmall,
      headlineLarge: headlineLarge ?? this.headlineLarge,
      headlineMedium: headlineMedium ?? this.headlineMedium,
      headlineSmall: headlineSmall ?? this.headlineSmall,
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,
      caption: caption ?? this.caption,
      button: button ?? this.button,
    );
  }

  @override
  AppTypography lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;
    return AppTypography(
      wordmark: TextStyle.lerp(wordmark, other.wordmark, t) ?? wordmark,
      displayLarge:
          TextStyle.lerp(displayLarge, other.displayLarge, t) ?? displayLarge,
      displayMedium:
          TextStyle.lerp(displayMedium, other.displayMedium, t) ??
          displayMedium,
      displaySmall:
          TextStyle.lerp(displaySmall, other.displaySmall, t) ?? displaySmall,
      headlineLarge:
          TextStyle.lerp(headlineLarge, other.headlineLarge, t) ??
          headlineLarge,
      headlineMedium:
          TextStyle.lerp(headlineMedium, other.headlineMedium, t) ??
          headlineMedium,
      headlineSmall:
          TextStyle.lerp(headlineSmall, other.headlineSmall, t) ??
          headlineSmall,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t) ?? titleLarge,
      titleMedium:
          TextStyle.lerp(titleMedium, other.titleMedium, t) ?? titleMedium,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t) ?? titleSmall,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t) ?? bodyLarge,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t) ?? bodyMedium,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t) ?? bodySmall,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t) ?? labelLarge,
      labelMedium:
          TextStyle.lerp(labelMedium, other.labelMedium, t) ?? labelMedium,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t) ?? labelSmall,
      caption: TextStyle.lerp(caption, other.caption, t) ?? caption,
      button: TextStyle.lerp(button, other.button, t) ?? button,
    );
  }
}
