import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../buttons/app_icon_button.dart';

/// The back affordance.
///
/// Uses [AppIcons.back], which mirrors under RTL — Material's own
/// `Icons.arrow_back` does not, so in Arabic it would point the wrong way.
///
/// With no [onPressed] it pops the current route, matching Material's
/// [BackButton]. Pass a handler to intercept — to confirm unsaved work, for
/// instance.
class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.tooltip = 'Back',
    this.color,
  });

  final VoidCallback? onPressed;

  /// Accessibility label. Pass a localised string.
  final String tooltip;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      icon: AppIcons.back,
      tooltip: tooltip,
      color: color,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
    );
  }
}
