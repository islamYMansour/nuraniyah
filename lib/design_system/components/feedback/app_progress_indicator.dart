import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A spinner.
///
/// Sized from the icon ramp so it lines up wherever an icon would sit. Leave
/// [value] null for indeterminate, or pass 0–1 for a known proportion.
class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    this.value,
    this.size = AppSizing.iconLarge,
    this.color,
    this.semanticLabel,
  });

  final double? value;
  final double size;
  final Color? color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return SizedBox.square(
      dimension: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: AppSizing.focusRingWidth,
        color: color ?? colors.primary,
        backgroundColor: colors.surfaceVariant,
        semanticsLabel: semanticLabel,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}

/// A horizontal progress bar.
///
/// Rounded to the pill radius and thick enough for a child to read at a
/// glance — this is how lesson progress is shown.
class AppProgressBar extends StatelessWidget {
  const AppProgressBar({
    super.key,
    required this.value,
    this.height = AppSpacing.md,
    this.color,
    this.trackColor,
    this.semanticLabel,
  });

  /// 0–1, or null for indeterminate.
  final double? value;

  final double height;
  final Color? color;
  final Color? trackColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return ClipRRect(
      borderRadius: AppRadii.indicator,
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        color: color ?? colors.primary,
        backgroundColor: trackColor ?? colors.surfaceVariant,
        semanticsLabel: semanticLabel,
      ),
    );
  }
}

/// A full-area loading placeholder: a spinner with an optional line of text.
///
/// Use it where a whole screen area is waiting. For a control that is busy,
/// use the button's own `isLoading` instead — it keeps the layout still.
class AppLoadingState extends StatelessWidget {
  const AppLoadingState({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const AppProgressIndicator(),
          if (message != null) ...<Widget>[
            const SizedBox(height: AppSpacing.lg),
            Text(
              message!,
              textAlign: TextAlign.center,
              style: context.typography.bodySmall.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
