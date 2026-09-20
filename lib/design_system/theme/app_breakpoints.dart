import 'package:flutter/widgets.dart';

/// The window size classes Noor lays out against.
///
/// The boundaries follow Material 3's window size classes, which map cleanly
/// onto the devices this app actually runs on:
///
/// | Class | Width | Typical device |
/// | --- | --- | --- |
/// | [compact] | < 600 | phones, portrait |
/// | [medium] | 600–839 | tablets in portrait, phones in landscape |
/// | [expanded] | 840–1199 | tablets in landscape |
/// | [large] | ≥ 1200 | 12.9" tablets in landscape, desktop |
///
/// Layouts should branch on the *class*, never on a raw pixel width — a
/// device-specific number written into a screen is a bug waiting for the next
/// device.
enum AppBreakpoint {
  compact,
  medium,
  expanded,
  large;

  /// The class for a given window width.
  static AppBreakpoint fromWidth(double width) => switch (width) {
        < 600 => AppBreakpoint.compact,
        < 840 => AppBreakpoint.medium,
        < 1200 => AppBreakpoint.expanded,
        _ => AppBreakpoint.large,
      };

  /// The class for the nearest window.
  static AppBreakpoint of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  /// True for everything wider than a phone.
  ///
  /// Use it for the coarse "is there room for a second pane" question; use the
  /// specific classes when the answer is finer than that.
  bool get isTablet => index >= AppBreakpoint.medium.index;

  bool get isCompact => this == AppBreakpoint.compact;

  /// True at [expanded] and above — a landscape tablet or larger, where a
  /// navigation rail and a two-pane layout start to pay off.
  bool get isWide => index >= AppBreakpoint.expanded.index;

  /// Multiplier applied to every font size at this class.
  ///
  /// Deliberately gentle. Noor's type is already large for a reading app, and
  /// a tablet is usually held further from the eye or flat on a table rather
  /// than at phone distance — so text grows a little, while the real
  /// adaptation happens in [screenPadding], [contentMaxWidth] and the column
  /// count.
  double get typeScale => switch (this) {
        AppBreakpoint.compact => 1.0,
        AppBreakpoint.medium => 1.05,
        AppBreakpoint.expanded => 1.1,
        AppBreakpoint.large => 1.1,
      };

  /// Left/right gutter of a screen at this class.
  double get screenPadding => switch (this) {
        AppBreakpoint.compact => 24,
        AppBreakpoint.medium => 32,
        AppBreakpoint.expanded => 48,
        AppBreakpoint.large => 64,
      };

  /// Space between two major blocks of a screen at this class.
  double get sectionGap => switch (this) {
        AppBreakpoint.compact => 32,
        AppBreakpoint.medium => 40,
        AppBreakpoint.expanded => 48,
        AppBreakpoint.large => 48,
      };

  /// How wide a column of running text or a form may get before it stops
  /// growing.
  ///
  /// Line length is the whole point: a paragraph of Arabic stretched across a
  /// 1366pt window is unreadable no matter how good the type is.
  double get contentMaxWidth => switch (this) {
        AppBreakpoint.compact => double.infinity,
        AppBreakpoint.medium => 640,
        AppBreakpoint.expanded => 720,
        AppBreakpoint.large => 760,
      };

  /// How wide mixed content — cards, media, a dashboard — may get.
  double get wideContentMaxWidth => switch (this) {
        AppBreakpoint.compact => double.infinity,
        AppBreakpoint.medium => 840,
        AppBreakpoint.expanded => 1080,
        AppBreakpoint.large => 1280,
      };

  /// A sensible default column count for a grid of equally weighted tiles —
  /// letter cards, lesson tiles.
  int get gridColumns => switch (this) {
        AppBreakpoint.compact => 2,
        AppBreakpoint.medium => 3,
        AppBreakpoint.expanded => 4,
        AppBreakpoint.large => 5,
      };
}

/// Picks a value per window size class.
///
/// The escape hatch for the cases the tokens do not already cover:
///
/// ```dart
/// final double size = AppResponsive.value<double>(
///   context,
///   compact: AppSizing.medallion,
///   expanded: AppSizing.medallionLarge,
/// );
/// ```
///
/// Only [compact] is required. A class with no value of its own falls back to
/// the nearest narrower one, so you specify only where the design actually
/// changes.
abstract final class AppResponsive {
  static T value<T>(
    BuildContext context, {
    required T compact,
    T? medium,
    T? expanded,
    T? large,
  }) {
    return valueFor<T>(
      AppBreakpoint.of(context),
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
    );
  }

  /// [value] against a class you already have.
  static T valueFor<T>(
    AppBreakpoint breakpoint, {
    required T compact,
    T? medium,
    T? expanded,
    T? large,
  }) {
    return switch (breakpoint) {
      AppBreakpoint.compact => compact,
      AppBreakpoint.medium => medium ?? compact,
      AppBreakpoint.expanded => expanded ?? medium ?? compact,
      AppBreakpoint.large => large ?? expanded ?? medium ?? compact,
    };
  }
}
