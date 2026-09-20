import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A tooltip styled from the tokens.
///
/// Thin wrapper over Material's [Tooltip]; it exists so components never
/// repeat the decoration, and so the whole app's tooltips change together.
class AppTooltip extends StatelessWidget {
  const AppTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow = true,
  });

  final String message;
  final Widget child;
  final bool preferBelow;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      waitDuration: AppDuration.slow,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surfaceInverse,
        borderRadius: AppRadii.input,
      ),
      textStyle: context.typography.caption
          .copyWith(color: colors.onSurfaceInverse),
      child: child,
    );
  }
}
