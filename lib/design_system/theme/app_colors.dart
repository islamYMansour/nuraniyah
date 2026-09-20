import 'package:flutter/material.dart';

/// Noor's raw brand ramps, sampled from the Claude Design onboarding artboard.
///
/// Deliberately private: UI code must never reach a raw hex. Screens read
/// semantic tokens off [AppColors] (via `context.colors`), so a brand change
/// happens here and nowhere else. The full ramp is documented in
/// `lib/design_system/README.md`.
abstract final class _Palette {
  // Teal — the primary brand ramp. `teal500` is the onboarding CTA fill,
  // `teal700` is the solid drop shadow beneath it.
  static const teal900 = Color(0xFF14544F);
  static const teal800 = Color(0xFF1A6560);
  static const teal700 = Color(0xFF217A75);
  static const teal500 = Color(0xFF2E9A93);
  static const teal400 = Color(0xFF5CC4BC);
  static const teal300 = Color(0xFF86D5CE);
  static const teal200 = Color(0xFF9FE3DC);
  static const teal100 = Color(0xFFE2F3F1);
  static const tealDark = Color(0xFF1E3B39);

  // Purple — the secondary brand ramp. `purple700` is the "نُور" wordmark,
  // `purple500` is the "تسجيل الدخول" link.
  static const purple900 = Color(0xFF2A1F47);
  static const purple800 = Color(0xFF3B2F5C);
  static const purple700 = Color(0xFF5C4A8A);
  static const purple600 = Color(0xFF4A3B73);
  static const purple500 = Color(0xFF7661A8);
  static const purple400 = Color(0xFFAD9BDC);
  static const purple300 = Color(0xFFB9A6E8);
  static const purple200 = Color(0xFFC4B6E8);
  static const purple150 = Color(0xFFCFC2F0);
  static const purple100 = Color(0xFFEDE9F5);
  static const purpleDark = Color(0xFF2E2748);

  // Sun — the yellow confetti dot.
  static const sun900 = Color(0xFF382703);
  static const sun800 = Color(0xFF4A3608);
  static const sun700 = Color(0xFF6B4A06);
  static const sun600 = Color(0xFF966406);
  static const sun500 = Color(0xFFF6C94A);
  static const sun400 = Color(0xFFF0C05A);
  static const sun300 = Color(0xFFF7D28C);
  static const sun100 = Color(0xFFFDF3D8);
  static const sunDark = Color(0xFF3A2C10);

  // Coral — the salmon confetti dot, and the root of the error ramp.
  static const coral900 = Color(0xFF3A100C);
  static const coral800 = Color(0xFF5C1F1A);
  static const coral700 = Color(0xFF7A2A23);
  static const coral600 = Color(0xFFBC4038);
  static const coral500 = Color(0xFFF28C82);
  static const coral400 = Color(0xFFF0938A);
  static const coral300 = Color(0xFFF7B8B0);
  static const coral100 = Color(0xFFFDE7E4);
  static const coralDark = Color(0xFF3A1F1C);

  // Sky — the pale medallion behind the character, and the info ramp.
  static const sky900 = Color(0xFF08243A);
  static const sky800 = Color(0xFF1B4D75);
  static const sky600 = Color(0xFF2A6FA5);
  static const sky400 = Color(0xFF7FB8E6);
  static const sky300 = Color(0xFFB5D9F5);
  static const sky250 = Color(0xFFCDE6F7);
  static const sky200 = Color(0xFFDCECF7);
  static const sky100 = Color(0xFFEFF6FC);
  static const skyDark = Color(0xFF2A4A5E);
  static const skyDeep = Color(0xFF16344A);

  // Leaf — success. Kept distinct from the teal brand ramp on purpose.
  static const leaf800 = Color(0xFF1E5E38);
  static const leaf700 = Color(0xFF2C7A4B);
  static const leaf600 = Color(0xFF06301A);
  static const leaf400 = Color(0xFF5FC98A);
  static const leaf300 = Color(0xFFA8E8C0);
  static const leaf100 = Color(0xFFE7F5EC);
  static const leafDark = Color(0xFF1B3A28);

  // Ink — cool, faintly violet text neutrals, sampled from the design's
  // subtitle grey (#6B6978).
  static const ink900 = Color(0xFF16151B);
  static const ink800 = Color(0xFF201F27);
  static const ink700 = Color(0xFF2A2933);
  static const ink600 = Color(0xFF2F2D3A);
  static const ink500 = Color(0xFF514F5E);
  static const ink400 = Color(0xFF6B6978);
  static const ink300 = Color(0xFF74717F);
  static const ink200 = Color(0xFFA8A6B2);
  static const ink150 = Color(0xFFB8B5C4);
  static const ink100 = Color(0xFFC9C6D4);
  static const ink50 = Color(0xFFF2F0F5);
  static const inkBorder = Color(0xFF393845);
  static const inkBorderStrong = Color(0xFF4D4B5C);
  static const inkDivider = Color(0xFF2E2D38);

  // Sand — warm surface neutrals, sampled from the design's cream ground
  // (#FAF8F5). Warm grounds + cool text is what gives Noor its soft feel.
  static const sand50 = Color(0xFFFFFFFF);
  static const sand100 = Color(0xFFFAF8F5);
  static const sand200 = Color(0xFFF4F1EB);
  static const sand300 = Color(0xFFF0ECE4);
  static const sand400 = Color(0xFFE9E4DC);
  static const sand500 = Color(0xFFE5E1DA);
  static const sand600 = Color(0xFFDAD4C9);

  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
}

/// Semantic colour tokens for the Noor design system.
///
/// Registered as a [ThemeExtension] by [AppTheme], so every token animates
/// across a light/dark switch and is reachable from any widget:
///
/// ```dart
/// Container(color: context.colors.surface);
/// ```
///
/// Every `onX` token is the content colour for the `X` ground it names, and
/// every foreground/ground pair here meets WCAG AA (4.5:1) unless its doc
/// comment says otherwise.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.onPrimary,
    required this.primaryPressed,
    required this.primaryStrong,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryPressed,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.surfaceInverse,
    required this.onSurfaceInverse,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.textLink,
    required this.textInverse,
    required this.border,
    required this.borderStrong,
    required this.borderFocus,
    required this.divider,
    required this.success,
    required this.onSuccess,
    required this.successContainer,
    required this.onSuccessContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.info,
    required this.onInfo,
    required this.infoContainer,
    required this.onInfoContainer,
    required this.accentSky,
    required this.onAccentSky,
    required this.accentSun,
    required this.onAccentSun,
    required this.accentCoral,
    required this.onAccentCoral,
    required this.shadow,
    required this.primaryShadow,
    required this.secondaryShadow,
    required this.scrim,
    required this.disabled,
    required this.onDisabled,
  });

  // ── Brand — primary (teal) ────────────────────────────────────

  /// Main brand fill: the onboarding CTA, active states, progress.
  final Color primary;

  /// Content drawn on top of [primary].
  final Color onPrimary;

  /// Pressed/active state of a [primary] surface.
  final Color primaryPressed;

  /// Teal that meets AA as *small* text or icons on a light ground.
  /// Use this instead of [primary] for anything below 24sp.
  final Color primaryStrong;

  /// Tinted teal ground: selected chips, soft badges, info tiles.
  final Color primaryContainer;

  /// Content drawn on top of [primaryContainer].
  final Color onPrimaryContainer;

  // ── Brand — secondary (purple) ────────────────────────────────

  /// The "نُور" wordmark purple. Headings, brand accents.
  final Color secondary;

  /// Content drawn on top of [secondary].
  final Color onSecondary;

  /// Pressed/active state of a [secondary] surface.
  final Color secondaryPressed;

  /// Tinted purple ground.
  final Color secondaryContainer;

  /// Content drawn on top of [secondaryContainer].
  final Color onSecondaryContainer;

  // ── Surfaces ──────────────────────────────────────────────────

  /// The app's cream ground (#FAF8F5 in the design).
  final Color background;

  /// Default content colour on [background].
  final Color onBackground;

  /// Raised sheets: cards, dialogs, bottom sheets.
  final Color surface;

  /// Default content colour on [surface].
  final Color onSurface;

  /// Recessed / muted ground: list rows, input fills, skeletons.
  final Color surfaceVariant;

  /// Content drawn on top of [surfaceVariant].
  final Color onSurfaceVariant;

  /// Inverted ground: tooltips, snack bars.
  final Color surfaceInverse;

  /// Content drawn on top of [surfaceInverse].
  final Color onSurfaceInverse;

  // ── Text ──────────────────────────────────────────────────────

  /// Headings and body copy.
  final Color textPrimary;

  /// Supporting copy — the onboarding subtitle grey (#6B6978).
  final Color textSecondary;

  /// Text in a disabled control. Exempt from WCAG contrast minimums.
  final Color textDisabled;

  /// Inline links — "تسجيل الدخول" in the design.
  final Color textLink;

  /// Text on a dark/inverted ground.
  final Color textInverse;

  // ── Lines ─────────────────────────────────────────────────────

  /// Default 1dp outline on cards, inputs and tiles.
  final Color border;

  /// Emphasised outline: selected or focused containers.
  final Color borderStrong;

  /// Focus ring colour.
  final Color borderFocus;

  /// Hairline separators inside a list or sheet.
  final Color divider;

  // ── Status ────────────────────────────────────────────────────

  /// Correct answer, completed lesson.
  final Color success;

  /// Content drawn on top of [success].
  final Color onSuccess;

  /// Tinted success ground.
  final Color successContainer;

  /// Content drawn on top of [successContainer].
  final Color onSuccessContainer;

  /// Wrong answer, validation failure.
  final Color error;

  /// Content drawn on top of [error].
  final Color onError;

  /// Tinted error ground.
  final Color errorContainer;

  /// Content drawn on top of [errorContainer].
  final Color onErrorContainer;

  /// Caution. The readable amber — not the bright [accentSun] dot.
  final Color warning;

  /// Content drawn on top of [warning].
  final Color onWarning;

  /// Tinted warning ground.
  final Color warningContainer;

  /// Content drawn on top of [warningContainer].
  final Color onWarningContainer;

  /// Neutral information, hints.
  final Color info;

  /// Content drawn on top of [info].
  final Color onInfo;

  /// Tinted info ground.
  final Color infoContainer;

  /// Content drawn on top of [infoContainer].
  final Color onInfoContainer;

  // ── Playful accents ───────────────────────────────────────────
  /////
  ///// The three decorative colours lifted straight off the onboarding
  ///// screen: the sky medallion behind the character and the two
  ///// confetti dots. Decoration only — never the sole carrier of meaning.

  /// The pale medallion behind Noor (#DCECF7).
  final Color accentSky;

  /// Content drawn on top of [accentSky].
  final Color onAccentSky;

  /// The yellow confetti dot (#F6C94A).
  final Color accentSun;

  /// Content drawn on top of [accentSun].
  final Color onAccentSun;

  /// The salmon confetti dot (#F28C82).
  final Color accentCoral;

  /// Content drawn on top of [accentCoral].
  final Color onAccentCoral;

  // ── Effects ───────────────────────────────────────────────────

  /// Base colour for soft, blurred shadows. Always used with alpha.
  final Color shadow;

  /// The solid, un-blurred slab under a primary button (#217A75).
  /// See [AppElevation.solid].
  final Color primaryShadow;

  /// The solid, un-blurred slab under a secondary button.
  final Color secondaryShadow;

  /// Modal barrier. Always used with alpha.
  final Color scrim;

  /// Fill of a disabled button or input.
  final Color disabled;

  /// Content drawn on top of [disabled].
  final Color onDisabled;

  /// Light theme tokens.
  static const light = AppColors(
    primary: _Palette.teal500,
    onPrimary: _Palette.white,
    primaryPressed: _Palette.teal700,
    primaryStrong: _Palette.teal700,
    primaryContainer: _Palette.teal100,
    onPrimaryContainer: _Palette.teal900,
    secondary: _Palette.purple700,
    onSecondary: _Palette.white,
    secondaryPressed: _Palette.purple600,
    secondaryContainer: _Palette.purple100,
    onSecondaryContainer: _Palette.purple800,
    background: _Palette.sand100,
    onBackground: _Palette.ink600,
    surface: _Palette.sand50,
    onSurface: _Palette.ink600,
    surfaceVariant: _Palette.sand200,
    onSurfaceVariant: _Palette.ink500,
    surfaceInverse: _Palette.ink600,
    onSurfaceInverse: _Palette.sand100,
    textPrimary: _Palette.ink600,
    textSecondary: _Palette.ink400,
    textDisabled: _Palette.ink200,
    textLink: _Palette.purple500,
    textInverse: _Palette.sand100,
    border: _Palette.sand400,
    borderStrong: _Palette.sand600,
    borderFocus: _Palette.teal500,
    divider: _Palette.sand300,
    success: _Palette.leaf700,
    onSuccess: _Palette.white,
    successContainer: _Palette.leaf100,
    onSuccessContainer: _Palette.leaf800,
    error: _Palette.coral600,
    onError: _Palette.white,
    errorContainer: _Palette.coral100,
    onErrorContainer: _Palette.coral700,
    warning: _Palette.sun600,
    onWarning: _Palette.white,
    warningContainer: _Palette.sun100,
    onWarningContainer: _Palette.sun700,
    info: _Palette.sky600,
    onInfo: _Palette.white,
    infoContainer: _Palette.sky100,
    onInfoContainer: _Palette.sky800,
    accentSky: _Palette.sky200,
    onAccentSky: _Palette.sky800,
    accentSun: _Palette.sun500,
    onAccentSun: _Palette.sun800,
    accentCoral: _Palette.coral500,
    onAccentCoral: _Palette.coral800,
    shadow: _Palette.ink600,
    primaryShadow: _Palette.teal700,
    secondaryShadow: _Palette.purple600,
    scrim: _Palette.ink600,
    disabled: _Palette.sand500,
    onDisabled: _Palette.ink200,
  );

  /// Dark theme tokens.
  ///
  /// The design only specifies a light theme; this is a faithful
  /// inversion of it — same hues, re-tuned for a dark ground.
  static const dark = AppColors(
    primary: _Palette.teal400,
    onPrimary: _Palette.teal900,
    primaryPressed: _Palette.teal300,
    primaryStrong: _Palette.teal300,
    primaryContainer: _Palette.tealDark,
    onPrimaryContainer: _Palette.teal200,
    secondary: _Palette.purple400,
    onSecondary: _Palette.purple900,
    secondaryPressed: _Palette.purple200,
    secondaryContainer: _Palette.purpleDark,
    onSecondaryContainer: _Palette.purple150,
    background: _Palette.ink900,
    onBackground: _Palette.ink50,
    surface: _Palette.ink800,
    onSurface: _Palette.ink50,
    surfaceVariant: _Palette.ink700,
    onSurfaceVariant: _Palette.ink100,
    surfaceInverse: _Palette.ink50,
    onSurfaceInverse: _Palette.ink800,
    textPrimary: _Palette.ink50,
    textSecondary: _Palette.ink150,
    textDisabled: _Palette.ink300,
    textLink: _Palette.purple300,
    textInverse: _Palette.ink800,
    border: _Palette.inkBorder,
    borderStrong: _Palette.inkBorderStrong,
    borderFocus: _Palette.teal400,
    divider: _Palette.inkDivider,
    success: _Palette.leaf400,
    onSuccess: _Palette.leaf600,
    successContainer: _Palette.leafDark,
    onSuccessContainer: _Palette.leaf300,
    error: _Palette.coral400,
    onError: _Palette.coral900,
    errorContainer: _Palette.coralDark,
    onErrorContainer: _Palette.coral300,
    warning: _Palette.sun400,
    onWarning: _Palette.sun900,
    warningContainer: _Palette.sunDark,
    onWarningContainer: _Palette.sun300,
    info: _Palette.sky400,
    onInfo: _Palette.sky900,
    infoContainer: _Palette.skyDeep,
    onInfoContainer: _Palette.sky300,
    accentSky: _Palette.skyDark,
    onAccentSky: _Palette.sky250,
    accentSun: _Palette.sun400,
    onAccentSun: _Palette.sun900,
    accentCoral: _Palette.coral400,
    onAccentCoral: _Palette.coral900,
    shadow: _Palette.black,
    primaryShadow: _Palette.teal800,
    secondaryShadow: _Palette.purple800,
    scrim: _Palette.black,
    disabled: _Palette.ink700,
    onDisabled: _Palette.ink300,
  );

  @override
  AppColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryPressed,
    Color? primaryStrong,
    Color? primaryContainer,
    Color? onPrimaryContainer,
    Color? secondary,
    Color? onSecondary,
    Color? secondaryPressed,
    Color? secondaryContainer,
    Color? onSecondaryContainer,
    Color? background,
    Color? onBackground,
    Color? surface,
    Color? onSurface,
    Color? surfaceVariant,
    Color? onSurfaceVariant,
    Color? surfaceInverse,
    Color? onSurfaceInverse,
    Color? textPrimary,
    Color? textSecondary,
    Color? textDisabled,
    Color? textLink,
    Color? textInverse,
    Color? border,
    Color? borderStrong,
    Color? borderFocus,
    Color? divider,
    Color? success,
    Color? onSuccess,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? error,
    Color? onError,
    Color? errorContainer,
    Color? onErrorContainer,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? info,
    Color? onInfo,
    Color? infoContainer,
    Color? onInfoContainer,
    Color? accentSky,
    Color? onAccentSky,
    Color? accentSun,
    Color? onAccentSun,
    Color? accentCoral,
    Color? onAccentCoral,
    Color? shadow,
    Color? primaryShadow,
    Color? secondaryShadow,
    Color? scrim,
    Color? disabled,
    Color? onDisabled,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryPressed: primaryPressed ?? this.primaryPressed,
      primaryStrong: primaryStrong ?? this.primaryStrong,
      primaryContainer: primaryContainer ?? this.primaryContainer,
      onPrimaryContainer: onPrimaryContainer ?? this.onPrimaryContainer,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      secondaryPressed: secondaryPressed ?? this.secondaryPressed,
      secondaryContainer: secondaryContainer ?? this.secondaryContainer,
      onSecondaryContainer: onSecondaryContainer ?? this.onSecondaryContainer,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
      surface: surface ?? this.surface,
      onSurface: onSurface ?? this.onSurface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      onSurfaceVariant: onSurfaceVariant ?? this.onSurfaceVariant,
      surfaceInverse: surfaceInverse ?? this.surfaceInverse,
      onSurfaceInverse: onSurfaceInverse ?? this.onSurfaceInverse,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textDisabled: textDisabled ?? this.textDisabled,
      textLink: textLink ?? this.textLink,
      textInverse: textInverse ?? this.textInverse,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      borderFocus: borderFocus ?? this.borderFocus,
      divider: divider ?? this.divider,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      errorContainer: errorContainer ?? this.errorContainer,
      onErrorContainer: onErrorContainer ?? this.onErrorContainer,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
      accentSky: accentSky ?? this.accentSky,
      onAccentSky: onAccentSky ?? this.onAccentSky,
      accentSun: accentSun ?? this.accentSun,
      onAccentSun: onAccentSun ?? this.onAccentSun,
      accentCoral: accentCoral ?? this.accentCoral,
      onAccentCoral: onAccentCoral ?? this.onAccentCoral,
      shadow: shadow ?? this.shadow,
      primaryShadow: primaryShadow ?? this.primaryShadow,
      secondaryShadow: secondaryShadow ?? this.secondaryShadow,
      scrim: scrim ?? this.scrim,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      primaryPressed:
          Color.lerp(primaryPressed, other.primaryPressed, t) ?? primaryPressed,
      primaryStrong:
          Color.lerp(primaryStrong, other.primaryStrong, t) ?? primaryStrong,
      primaryContainer:
          Color.lerp(primaryContainer, other.primaryContainer, t) ??
          primaryContainer,
      onPrimaryContainer:
          Color.lerp(onPrimaryContainer, other.onPrimaryContainer, t) ??
          onPrimaryContainer,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t) ?? onSecondary,
      secondaryPressed:
          Color.lerp(secondaryPressed, other.secondaryPressed, t) ??
          secondaryPressed,
      secondaryContainer:
          Color.lerp(secondaryContainer, other.secondaryContainer, t) ??
          secondaryContainer,
      onSecondaryContainer:
          Color.lerp(onSecondaryContainer, other.onSecondaryContainer, t) ??
          onSecondaryContainer,
      background: Color.lerp(background, other.background, t) ?? background,
      onBackground:
          Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
      surface: Color.lerp(surface, other.surface, t) ?? surface,
      onSurface: Color.lerp(onSurface, other.onSurface, t) ?? onSurface,
      surfaceVariant:
          Color.lerp(surfaceVariant, other.surfaceVariant, t) ?? surfaceVariant,
      onSurfaceVariant:
          Color.lerp(onSurfaceVariant, other.onSurfaceVariant, t) ??
          onSurfaceVariant,
      surfaceInverse:
          Color.lerp(surfaceInverse, other.surfaceInverse, t) ?? surfaceInverse,
      onSurfaceInverse:
          Color.lerp(onSurfaceInverse, other.onSurfaceInverse, t) ??
          onSurfaceInverse,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t) ?? textPrimary,
      textSecondary:
          Color.lerp(textSecondary, other.textSecondary, t) ?? textSecondary,
      textDisabled:
          Color.lerp(textDisabled, other.textDisabled, t) ?? textDisabled,
      textLink: Color.lerp(textLink, other.textLink, t) ?? textLink,
      textInverse: Color.lerp(textInverse, other.textInverse, t) ?? textInverse,
      border: Color.lerp(border, other.border, t) ?? border,
      borderStrong:
          Color.lerp(borderStrong, other.borderStrong, t) ?? borderStrong,
      borderFocus: Color.lerp(borderFocus, other.borderFocus, t) ?? borderFocus,
      divider: Color.lerp(divider, other.divider, t) ?? divider,
      success: Color.lerp(success, other.success, t) ?? success,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t) ?? onSuccess,
      successContainer:
          Color.lerp(successContainer, other.successContainer, t) ??
          successContainer,
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t) ??
          onSuccessContainer,
      error: Color.lerp(error, other.error, t) ?? error,
      onError: Color.lerp(onError, other.onError, t) ?? onError,
      errorContainer:
          Color.lerp(errorContainer, other.errorContainer, t) ?? errorContainer,
      onErrorContainer:
          Color.lerp(onErrorContainer, other.onErrorContainer, t) ??
          onErrorContainer,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      onWarning: Color.lerp(onWarning, other.onWarning, t) ?? onWarning,
      warningContainer:
          Color.lerp(warningContainer, other.warningContainer, t) ??
          warningContainer,
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t) ??
          onWarningContainer,
      info: Color.lerp(info, other.info, t) ?? info,
      onInfo: Color.lerp(onInfo, other.onInfo, t) ?? onInfo,
      infoContainer:
          Color.lerp(infoContainer, other.infoContainer, t) ?? infoContainer,
      onInfoContainer:
          Color.lerp(onInfoContainer, other.onInfoContainer, t) ??
          onInfoContainer,
      accentSky: Color.lerp(accentSky, other.accentSky, t) ?? accentSky,
      onAccentSky: Color.lerp(onAccentSky, other.onAccentSky, t) ?? onAccentSky,
      accentSun: Color.lerp(accentSun, other.accentSun, t) ?? accentSun,
      onAccentSun: Color.lerp(onAccentSun, other.onAccentSun, t) ?? onAccentSun,
      accentCoral: Color.lerp(accentCoral, other.accentCoral, t) ?? accentCoral,
      onAccentCoral:
          Color.lerp(onAccentCoral, other.onAccentCoral, t) ?? onAccentCoral,
      shadow: Color.lerp(shadow, other.shadow, t) ?? shadow,
      primaryShadow:
          Color.lerp(primaryShadow, other.primaryShadow, t) ?? primaryShadow,
      secondaryShadow:
          Color.lerp(secondaryShadow, other.secondaryShadow, t) ??
          secondaryShadow,
      scrim: Color.lerp(scrim, other.scrim, t) ?? scrim,
      disabled: Color.lerp(disabled, other.disabled, t) ?? disabled,
      onDisabled: Color.lerp(onDisabled, other.onDisabled, t) ?? onDisabled,
    );
  }
}
