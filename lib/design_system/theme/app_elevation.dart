import 'package:flutter/widgets.dart';

import 'app_spacing.dart';

/// Depth tokens for the Noor design system.
///
/// Noor uses two distinct kinds of depth, and they are not interchangeable:
///
///  * **Solid depth** — an un-blurred slab of a darker shade sitting directly
///    beneath a control, as under the design's "هيّا نبدأ" button. This is the
///    house style for anything pressable: it reads as a physical, chunky,
///    child-friendly key. See [solid].
///  * **Soft depth** — a diffuse shadow that lifts a passive surface off the
///    cream ground. Used for cards, sheets and dialogs. See [card], [raised]
///    and [overlay].
///
/// The shadow colour is always passed in from `context.colors`
/// ([AppColors.shadow] or [AppColors.primaryShadow]) rather than hard-coded,
/// so depth inverts correctly in dark mode.
abstract final class AppElevation {
  // ── Material elevation steps ──────────────────────────────────
  // For the Material widgets that take a `double elevation`.

  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 3;
  static const double level3 = 6;
  static const double level4 = 12;

  /// The signature solid slab: a copy of the control offset straight down,
  /// with no blur and no spread.
  ///
  /// Pass the *darker* shade of the control's own colour — e.g.
  /// `AppElevation.solid(context.colors.primaryShadow)` under a primary
  /// button. Shrink [offset] to zero while the control is pressed to make it
  /// travel into the page.
  static List<BoxShadow> solid(
    Color color, {
    double offset = AppSizing.buttonShadowOffset,
  }) {
    return <BoxShadow>[
      BoxShadow(color: color, offset: Offset(0, offset)),
    ];
  }

  /// Resting depth for a card or tile.
  static List<BoxShadow> card(Color shadowColor) {
    return <BoxShadow>[
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.05),
        offset: const Offset(0, 2),
        blurRadius: 8,
      ),
    ];
  }

  /// A card that has been lifted — dragged, selected or hovered.
  static List<BoxShadow> raised(Color shadowColor) {
    return <BoxShadow>[
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.08),
        offset: const Offset(0, 6),
        blurRadius: 20,
      ),
    ];
  }

  /// Anything floating over the page: dialogs, sheets, popovers.
  static List<BoxShadow> overlay(Color shadowColor) {
    return <BoxShadow>[
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.12),
        offset: const Offset(0, 12),
        blurRadius: 32,
      ),
    ];
  }

  /// Opacity of the modal barrier behind a dialog or sheet. Combine with
  /// `AppColors.scrim`.
  static const double scrimOpacity = 0.45;
}
