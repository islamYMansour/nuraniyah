import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Short, safe access to Noor's design tokens from any widget.
///
/// ```dart
/// Text(
///   'أهلًا',
///   style: context.typography.headlineMedium
///       .copyWith(color: context.colors.textPrimary),
/// );
/// ```
///
/// Each getter falls back to the light token set if the extension is missing
/// from the ambient theme — a widget rendered outside [AppTheme] (a preview,
/// a bare `WidgetTester` pump) still draws with real tokens instead of
/// throwing.
extension AppThemeContext on BuildContext {
  /// Semantic colour tokens for the active theme.
  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;

  /// Semantic text-style tokens.
  AppTypography get typography =>
      Theme.of(this).extension<AppTypography>() ?? AppTypography.standard;

  /// True when the dark token set is active.
  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  /// The ambient writing direction. Noor is Arabic-first, so layouts should
  /// be built direction-agnostically (`EdgeInsetsDirectional`, `start`/`end`)
  /// and consult this only when a decision genuinely depends on it.
  TextDirection get direction => Directionality.of(this);

  /// True when the ambient direction is right-to-left.
  bool get isRtl => Directionality.of(this) == TextDirection.rtl;
}
