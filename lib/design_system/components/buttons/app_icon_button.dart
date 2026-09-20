import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../common/app_pressable.dart';

/// How an icon button is weighted.
enum AppIconButtonVariant {
  /// No fill — an icon on the page.
  plain,

  /// A soft tinted circle behind the icon.
  tonal,

  /// The teal key, with the solid slab.
  filled,
}

/// A square, icon-only button.
///
/// Never smaller than [AppSizing.minTouchTarget] regardless of icon size —
/// Noor is used by children, whose taps are less precise than an adult's.
/// [tooltip] doubles as the accessibility label, and is required for that
/// reason: an icon with no text needs a name.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.tooltip,
    this.onPressed,
    this.variant = AppIconButtonVariant.plain,
    this.size = AppSizing.iconMedium,
    this.color,
    this.isEnabled = true,
    this.isSelected = false,
    this.focusNode,
  });

  final IconData icon;

  /// Shown on long-press and read out by screen readers.
  final String tooltip;

  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;

  /// Size of the glyph. The tappable box stays at least 48pt square.
  final double size;

  /// Overrides the variant's foreground colour.
  final Color? color;

  final bool isEnabled;

  /// Renders the selected treatment and reports it to assistive technology.
  final bool isSelected;

  final FocusNode? focusNode;

  bool get _isInteractive => isEnabled && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double box = size + AppSpacing.xxl > AppSizing.minTouchTarget
        ? size + AppSpacing.xxl
        : AppSizing.minTouchTarget;

    final Color foreground;
    final Color? background;
    final Color? slab;

    if (!_isInteractive) {
      foreground = colors.textDisabled;
      background =
          variant == AppIconButtonVariant.plain ? null : colors.disabled;
      slab = null;
    } else {
      switch (variant) {
        case AppIconButtonVariant.plain:
          foreground = color ??
              (isSelected ? colors.primaryStrong : colors.textSecondary);
          background = isSelected ? colors.primaryContainer : null;
          slab = null;
        case AppIconButtonVariant.tonal:
          foreground = color ?? colors.onPrimaryContainer;
          background = colors.primaryContainer;
          slab = null;
        case AppIconButtonVariant.filled:
          foreground = color ?? colors.onPrimary;
          background = colors.primary;
          slab = colors.primaryShadow;
      }
    }

    return Tooltip(
      message: tooltip,
      child: AppPressable(
        onPressed: _isInteractive ? onPressed : null,
        enabled: _isInteractive,
        focusNode: focusNode,
        semanticLabel: tooltip,
        isSelected: isSelected,
        color: background,
        shadowColor: slab,
        borderRadius: AppRadii.chip,
        child: SizedBox.square(
          dimension: box,
          child: Center(
            child: Icon(icon, size: size, color: foreground),
          ),
        ),
      ),
    );
  }
}
