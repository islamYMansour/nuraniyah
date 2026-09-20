import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// The meaning a tag carries, which picks its colour pair.
enum AppTagTone { neutral, primary, secondary, success, warning, error, info }

/// A small, static label.
///
/// Unlike `AppChip` a tag is never interactive and is not announced as a
/// button — use it for a lesson level, a status, a category. Its colour comes
/// from a [AppTagTone] so that every "success" tag in the app matches.
class AppTag extends StatelessWidget {
  const AppTag({
    super.key,
    required this.label,
    this.tone = AppTagTone.neutral,
    this.icon,
  });

  final String label;
  final AppTagTone tone;
  final IconData? icon;

  (Color, Color) _colors(AppColors colors) => switch (tone) {
        AppTagTone.neutral => (colors.surfaceVariant, colors.onSurfaceVariant),
        AppTagTone.primary => (colors.primaryContainer, colors.onPrimaryContainer),
        AppTagTone.secondary => (
            colors.secondaryContainer,
            colors.onSecondaryContainer
          ),
        AppTagTone.success => (colors.successContainer, colors.onSuccessContainer),
        AppTagTone.warning => (colors.warningContainer, colors.onWarningContainer),
        AppTagTone.error => (colors.errorContainer, colors.onErrorContainer),
        AppTagTone.info => (colors.infoContainer, colors.onInfoContainer),
      };

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground) = _colors(context.colors);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.chip,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: AppSizing.iconSmall, color: foreground),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: context.typography.labelSmall.copyWith(color: foreground),
          ),
        ],
      ),
    );
  }
}
