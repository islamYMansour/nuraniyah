/// Noor's design system: design tokens, the Material theme built from them,
/// the icon set, and the reusable component library.
///
/// Import this one file and nothing else from `design_system/`:
///
/// ```dart
/// import 'package:nuraniyah_app/design_system/design_system.dart';
/// ```
///
/// Screens must not hard-code a colour, font size, radius, gap or duration.
/// Read tokens through `context.colors` and `context.typography`, and off the
/// `AppSpacing`, `AppSizing`, `AppRadii`, `AppElevation` and `AppDuration`
/// ramps. Components live under `components/` and carry no business logic.
library;

export 'components/components.dart';
export 'icons/app_icons.dart';
export 'theme/theme.dart';
