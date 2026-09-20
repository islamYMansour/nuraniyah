import 'package:flutter/material.dart';

import 'app_breakpoints.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
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

  // ── Window size ───────────────────────────────────────────────

  /// The window size class this widget is being laid out in.
  AppBreakpoint get breakpoint => AppBreakpoint.of(this);

  /// True on a phone in portrait.
  bool get isCompact => breakpoint.isCompact;

  /// True on anything wider than a phone.
  bool get isTablet => breakpoint.isTablet;

  /// True on a landscape tablet or larger — where a navigation rail and a
  /// two-pane layout start to pay off.
  bool get isWide => breakpoint.isWide;

  /// The left/right screen gutter for this window size.
  double get screenPadding => breakpoint.screenPadding;

  /// The gap between two major blocks of a screen at this window size.
  double get sectionGap => breakpoint.sectionGap;

  /// Screen gutters as an [EdgeInsets], widening with the window.
  ///
  /// Prefer this over the fixed [AppSpacing.screenInsets] for anything that
  /// fills a screen — it is the difference between a layout that merely fits
  /// on a tablet and one that belongs there.
  EdgeInsets get screenInsets => EdgeInsets.symmetric(
        horizontal: screenPadding,
        vertical: AppSpacing.screenVertical,
      );
}
