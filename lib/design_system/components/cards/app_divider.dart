import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A hairline separator.
///
/// Defaults to no surrounding space so the caller controls rhythm with
/// [AppSpacing]; pass [spacing] to add symmetric room instead of wrapping it
/// in a Padding.
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.spacing = AppSpacing.none,
    this.indent = AppSpacing.none,
    this.color,
  }) : axis = Axis.horizontal;

  /// A vertical rule, for separating items in a row.
  const AppDivider.vertical({
    super.key,
    this.spacing = AppSpacing.none,
    this.indent = AppSpacing.none,
    this.color,
  }) : axis = Axis.vertical;

  final Axis axis;

  /// Space added on both sides of the rule.
  final double spacing;

  /// Inset from both ends, in reading direction.
  final double indent;

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color lineColor = color ?? context.colors.divider;

    if (axis == Axis.vertical) {
      return VerticalDivider(
        width: AppSizing.borderWidth + spacing * 2,
        thickness: AppSizing.borderWidth,
        indent: indent,
        endIndent: indent,
        color: lineColor,
      );
    }

    return Divider(
      height: AppSizing.borderWidth + spacing * 2,
      thickness: AppSizing.borderWidth,
      indent: indent,
      endIndent: indent,
      color: lineColor,
    );
  }
}
