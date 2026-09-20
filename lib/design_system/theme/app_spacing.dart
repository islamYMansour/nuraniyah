import 'package:flutter/widgets.dart';

/// The spacing ramp, in logical pixels.
///
/// Every gap, pad and inset in Noor is one of these steps. The ramp is a 4pt
/// grid — the vertical rhythm measured off the onboarding artboard (20 / 28 /
/// 32pt between the wordmark, subtitle, CTA and footer link) lands on it
/// exactly.
abstract final class AppSpacing {
  static const double none = 0;
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double x4 = 40;
  static const double x5 = 48;
  static const double x6 = 64;

  // ── Named roles ───────────────────────────────────────────────
  // Prefer these in layouts: they say *why* the gap exists, so the value can
  // be retuned once instead of hunted through screens.

  /// Left/right gutter of a full screen.
  static const double screenHorizontal = xxl;

  /// Top/bottom padding inside a screen's safe area.
  static const double screenVertical = xxl;

  /// Between two major blocks of a screen.
  static const double sectionGap = xxxl;

  /// Between related blocks inside a section.
  static const double contentGap = lg;

  /// Between sibling items in a list or grid.
  static const double itemGap = md;

  /// Between an icon and its label, or two inline chips.
  static const double inlineGap = sm;

  /// Padding inside a card or sheet.
  static const double cardPadding = xl;

  /// Horizontal padding inside a button, either side of its label.
  static const double buttonHorizontal = xxxl;

  /// Default screen gutters as an [EdgeInsets].
  static const EdgeInsets screenInsets = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  /// Default card padding as an [EdgeInsets].
  static const EdgeInsets cardInsets = EdgeInsets.all(cardPadding);
}

/// Fixed sizes for recurring shapes, in logical pixels.
///
/// Measured off the design artboard where the design specifies them; the rest
/// follow Material's accessibility minimums.
abstract final class AppSizing {
  /// Smallest tappable square. Noor is used by children, so nothing
  /// interactive may be smaller than this — including icon-only buttons.
  static const double minTouchTarget = 48;

  // ── Buttons ───────────────────────────────────────────────────

  /// Compact button, e.g. inside a dense row.
  static const double buttonHeightSmall = 44;

  /// The default button height.
  static const double buttonHeightMedium = 56;

  /// The hero CTA — 72pt in the design ("هيّا نبدأ").
  static const double buttonHeightLarge = 72;

  /// Vertical offset of the solid slab beneath a button. Measured at 5pt in
  /// the design; see [AppElevation.solid].
  static const double buttonShadowOffset = 5;

  // ── Icons ─────────────────────────────────────────────────────

  static const double iconSmall = 20;
  static const double iconMedium = 24;
  static const double iconLarge = 32;
  static const double iconXLarge = 48;

  // ── Imagery ───────────────────────────────────────────────────

  /// The circular tinted plate the Noor character stands on — 200pt across
  /// in the design.
  static const double medallion = 200;

  /// The smaller decorative confetti dot (the coral one).
  static const double dotSmall = 10;

  /// The larger decorative confetti dot (the yellow one).
  static const double dotMedium = 14;

  static const double avatarSmall = 40;
  static const double avatarMedium = 56;
  static const double avatarLarge = 80;

  // ── Strokes ───────────────────────────────────────────────────

  static const double borderWidth = 1;
  static const double borderWidthThick = 2;
  static const double focusRingWidth = 3;

  /// Content stops widening past this on tablets and desktop, so lines of
  /// Arabic stay a comfortable measure.
  ///
  /// A per-window-size version lives on [AppBreakpoint.contentMaxWidth]; this
  /// is the fixed fallback for places that have no context.
  static const double maxContentWidth = 600;

  /// A full-width button stops growing here.
  ///
  /// `isFullWidth` means "fill the column", not "span the window" — a 1200pt
  /// primary key looks like a mistake, and its label ends up marooned in the
  /// middle of an empty bar.
  static const double maxButtonWidth = 480;

  /// A dialog's ceiling. Below this it tracks the window with its own insets.
  static const double maxDialogWidth = 520;

  /// A modal sheet's ceiling on a wide window, where a full-bleed sheet would
  /// stretch the whole way across.
  static const double maxSheetWidth = 640;

  /// Width of the navigation rail that replaces the bottom bar on a landscape
  /// tablet.
  static const double navigationRailWidth = 88;

  /// Width of the list pane in a two-pane tablet layout.
  static const double sidePaneWidth = 360;

  /// The character plate, enlarged for a tablet.
  static const double medallionLarge = 280;
}
