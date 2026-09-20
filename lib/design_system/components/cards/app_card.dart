import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../common/app_pressable.dart';

/// How a card separates itself from the page.
enum AppCardVariant {
  /// A plain white face, no shadow, no border. The quietest option, and the
  /// right default on Noor's cream ground — the ground alone already
  /// separates it.
  filled,

  /// A soft shadow lifts the card off the page.
  elevated,

  /// A 1dp border and no shadow.
  outlined,
}

/// A rounded container for a self-contained piece of content.
///
/// Supplying [onTap] makes the card a real button: it gains Noor's press
/// travel, a focus ring, hover, and a semantics node. Leave it null for a
/// passive container.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.variant = AppCardVariant.filled,
    this.onTap,
    this.onLongPress,
    this.padding = AppSpacing.cardInsets,
    this.borderRadius = AppRadii.card,
    this.backgroundColor,
    this.isSelected = false,
    this.enabled = true,
    this.semanticLabel,
  });

  final Widget child;
  final AppCardVariant variant;

  /// Makes the whole card pressable.
  final VoidCallback? onTap;

  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  /// Overrides the variant's fill.
  final Color? backgroundColor;

  /// Draws the selected treatment — a primary-coloured border.
  final bool isSelected;

  final bool enabled;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool isInteractive = enabled && onTap != null;

    final Color background = backgroundColor ??
        (enabled ? colors.surface : colors.surfaceVariant);

    final BoxBorder? border = switch (true) {
      _ when isSelected => Border.all(
          color: colors.primary,
          width: AppSizing.borderWidthThick,
        ),
      _ when variant == AppCardVariant.outlined => Border.all(
          color: colors.border,
          width: AppSizing.borderWidth,
        ),
      _ => null,
    };

    final List<BoxShadow>? shadow = variant == AppCardVariant.elevated
        ? AppElevation.card(colors.shadow)
        : null;

    final Widget content = Padding(padding: padding, child: child);

    if (isInteractive) {
      return AppPressable(
        onPressed: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
        semanticLabel: semanticLabel,
        isSelected: isSelected,
        color: background,
        // Cards press with a shallower travel than buttons — they are
        // surfaces first and controls second.
        shadowColor: variant == AppCardVariant.elevated ? null : colors.border,
        shadowOffset: variant == AppCardVariant.elevated ? 0 : AppSpacing.xs,
        borderRadius: borderRadius,
        border: border,
        child: content,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius,
        border: border,
        boxShadow: shadow,
      ),
      child: content,
    );
  }
}
