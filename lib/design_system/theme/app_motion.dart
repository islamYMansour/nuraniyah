import 'package:flutter/animation.dart';

/// Motion tokens.
///
/// Noor's motion is quick and springy — a control should feel like a physical
/// key being pressed, not like a fading panel. Components must name a duration
/// and a curve from here rather than inventing one, so the whole app moves
/// with a single rhythm.
abstract final class AppDuration {
  /// State flips that must feel instant: press, hover, focus ring.
  static const Duration instant = Duration(milliseconds: 90);

  /// Colour and opacity crossfades.
  static const Duration fast = Duration(milliseconds: 160);

  /// The default for size, position and reveal changes.
  static const Duration medium = Duration(milliseconds: 240);

  /// Sheets, dialogs and page-level transitions.
  static const Duration slow = Duration(milliseconds: 360);

  /// One sweep of a skeleton's shimmer.
  static const Duration shimmer = Duration(milliseconds: 1400);
}

/// The curve ramp.
abstract final class AppCurves {
  /// Default easing for most transitions.
  static const Curve standard = Curves.easeOutCubic;

  /// Something entering the screen.
  static const Curve enter = Curves.easeOutCubic;

  /// Something leaving the screen.
  static const Curve exit = Curves.easeInCubic;

  /// A control springing back after a press.
  static const Curve springy = Curves.easeOutBack;
}
