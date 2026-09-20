import 'package:flutter/widgets.dart';

/// The corner-radius ramp, in logical pixels.
///
/// Noor rounds generously — soft corners are what make the interface read as
/// a children's app rather than a utility. The onboarding CTA is a full
/// stadium ([pill]) and the character plate is a true circle.
abstract final class AppRadius {
  static const double none = 0;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;

  /// Large enough to render as a stadium at any realistic control height.
  static const double pill = 999;
}

/// Ready-made [BorderRadius] values, named by the thing they belong to.
///
/// Layouts should reach for these rather than re-deriving a radius, so a
/// change to Noor's roundness happens in one place.
abstract final class AppRadii {
  static const BorderRadius none = BorderRadius.zero;

  /// Chips, badges, small tags.
  static const BorderRadius chip = BorderRadius.all(Radius.circular(AppRadius.pill));

  /// Buttons — a stadium, as in the design.
  static const BorderRadius button = BorderRadius.all(Radius.circular(AppRadius.pill));

  /// Text fields and selects.
  static const BorderRadius input = BorderRadius.all(Radius.circular(AppRadius.md));

  /// Cards, tiles, lesson entries.
  static const BorderRadius card = BorderRadius.all(Radius.circular(AppRadius.xl));

  /// Dialogs and alerts.
  static const BorderRadius dialog = BorderRadius.all(Radius.circular(AppRadius.xxl));

  /// Bottom sheets — rounded at the top only.
  static const BorderRadius sheet = BorderRadius.vertical(
    top: Radius.circular(AppRadius.xxl),
  );

  /// Images and illustration plates.
  static const BorderRadius image = BorderRadius.all(Radius.circular(AppRadius.lg));

  /// Progress bars and thin indicators.
  static const BorderRadius indicator = BorderRadius.all(Radius.circular(AppRadius.pill));
}

/// The same radii as [ShapeBorder]s, for the Material component themes that
/// ask for a shape instead of a radius.
abstract final class AppShapes {
  static const StadiumBorder button = StadiumBorder();
  static const StadiumBorder chip = StadiumBorder();

  static const RoundedRectangleBorder input =
      RoundedRectangleBorder(borderRadius: AppRadii.input);
  static const RoundedRectangleBorder card =
      RoundedRectangleBorder(borderRadius: AppRadii.card);
  static const RoundedRectangleBorder dialog =
      RoundedRectangleBorder(borderRadius: AppRadii.dialog);
  static const RoundedRectangleBorder sheet =
      RoundedRectangleBorder(borderRadius: AppRadii.sheet);
}
