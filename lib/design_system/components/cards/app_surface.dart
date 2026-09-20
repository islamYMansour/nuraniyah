import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A bare themed surface.
///
/// The lowest-level container in the system: a background, a radius and
/// optional padding, with none of a card's variants or interaction. Reach for
/// it when you need a tinted block — a banner strip, a letter tile, an
/// illustration plate — and [AppCard] would imply more than you mean.
class AppSurface extends StatelessWidget {
  const AppSurface({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.borderRadius = AppRadii.card,
    this.border,
    this.width,
    this.height,
    this.alignment,
  });

  /// Defaults to a circle.
  const AppSurface.circle({
    super.key,
    required this.child,
    required double size,
    this.color,
    this.padding,
    this.border,
    this.alignment = Alignment.center,
  }) : borderRadius = AppRadii.chip,
       width = size,
       height = size;

  final Widget child;

  /// Defaults to [AppColors.surfaceVariant].
  final Color? color;

  final EdgeInsetsGeometry? padding;
  final BorderRadius borderRadius;
  final BoxBorder? border;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: color ?? context.colors.surfaceVariant,
        borderRadius: borderRadius,
        border: border,
      ),
      child: child,
    );
  }
}
