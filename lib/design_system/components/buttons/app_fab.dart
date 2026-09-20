import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../common/app_pressable.dart';

/// Noor's floating action button.
///
/// Built on [AppPressable] rather than Material's [FloatingActionButton] so it
/// carries the same solid slab and press travel as every other key in the app
/// — a Material FAB's blurred shadow would be the only one of its kind on the
/// screen.
///
/// Pass a [label] for the extended form.
class AppFab extends StatelessWidget {
  const AppFab({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.label,
    this.isEnabled = true,
  });

  final IconData icon;

  /// Read out by screen readers, and shown on long-press when there is no
  /// visible [label].
  final String tooltip;

  final VoidCallback? onPressed;

  /// When set, the FAB extends to show this text beside the icon.
  final String? label;

  final bool isEnabled;

  bool get _isInteractive => isEnabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool isExtended = label != null;
    final Color foreground =
        _isInteractive ? colors.onPrimary : colors.onDisabled;

    return Tooltip
        // An extended FAB already shows its name, so only the icon-only form
        // needs the tooltip surfaced visually.
        (
      message: isExtended ? '' : tooltip,
      child: AppPressable(
        onPressed: _isInteractive ? onPressed : null,
        enabled: _isInteractive,
        semanticLabel: tooltip,
        color: _isInteractive ? colors.primary : colors.disabled,
        shadowColor: _isInteractive ? colors.primaryShadow : null,
        borderRadius: AppRadii.button,
        child: SizedBox(
          height: AppSizing.buttonHeightMedium,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isExtended ? AppSpacing.xxl : AppSpacing.lg,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(icon, size: AppSizing.iconMedium, color: foreground),
                if (isExtended) ...<Widget>[
                  const SizedBox(width: AppSpacing.inlineGap),
                  Text(
                    label!,
                    style: context.typography.labelLarge
                        .copyWith(color: foreground),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
