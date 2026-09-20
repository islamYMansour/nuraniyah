import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';

/// What a message is telling the user.
enum AppMessageTone { success, warning, error, info }

/// An inline status message.
///
/// One component covers the success, warning, error and info cases the design
/// system needs, so those four never drift apart. Each tone picks its own
/// icon and container colours from the tokens.
///
/// The icon is decorative — the text carries the meaning — so colour is never
/// the only signal.
class AppMessage extends StatelessWidget {
  const AppMessage({
    super.key,
    required this.message,
    this.tone = AppMessageTone.info,
    this.title,
    this.action,
    this.onDismissed,
    this.dismissTooltip = 'Dismiss',
  });

  const AppMessage.success({
    super.key,
    required this.message,
    this.title,
    this.action,
    this.onDismissed,
    this.dismissTooltip = 'Dismiss',
  }) : tone = AppMessageTone.success;

  const AppMessage.warning({
    super.key,
    required this.message,
    this.title,
    this.action,
    this.onDismissed,
    this.dismissTooltip = 'Dismiss',
  }) : tone = AppMessageTone.warning;

  const AppMessage.error({
    super.key,
    required this.message,
    this.title,
    this.action,
    this.onDismissed,
    this.dismissTooltip = 'Dismiss',
  }) : tone = AppMessageTone.error;

  final String message;
  final AppMessageTone tone;

  /// An optional bold line above the message.
  final String? title;

  /// A trailing control — typically an `AppButton.text` such as "Retry".
  final Widget? action;

  /// Shows a close button.
  final VoidCallback? onDismissed;

  final String dismissTooltip;

  (Color, Color, IconData) _style(AppColors colors) => switch (tone) {
    AppMessageTone.success => (
      colors.successContainer,
      colors.onSuccessContainer,
      AppIcons.success,
    ),
    AppMessageTone.warning => (
      colors.warningContainer,
      colors.onWarningContainer,
      AppIcons.warning,
    ),
    AppMessageTone.error => (
      colors.errorContainer,
      colors.onErrorContainer,
      AppIcons.error,
    ),
    AppMessageTone.info => (
      colors.infoContainer,
      colors.onInfoContainer,
      AppIcons.info,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final (Color background, Color foreground, IconData icon) = _style(colors);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.input,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: AppSizing.iconMedium, color: foreground),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (title != null) ...<Widget>[
                  Text(
                    title!,
                    style: typography.labelLarge.copyWith(color: foreground),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                ],
                Text(
                  message,
                  style: typography.bodySmall.copyWith(color: foreground),
                ),
                if (action != null) ...<Widget>[
                  const SizedBox(height: AppSpacing.sm),
                  action!,
                ],
              ],
            ),
          ),
          if (onDismissed != null)
            IconButton(
              onPressed: onDismissed,
              icon: Icon(AppIcons.close, color: foreground),
              iconSize: AppSizing.iconSmall,
              tooltip: dismissTooltip,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints.tightFor(
                width: AppSizing.iconXLarge,
                height: AppSizing.iconXLarge,
              ),
            ),
        ],
      ),
    );
  }
}
