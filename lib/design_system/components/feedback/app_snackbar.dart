import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';
import 'app_message.dart';

/// Transient messages shown over the page.
///
/// A set of static helpers rather than a widget, because a snack bar is shown
/// imperatively. They build a [SnackBar] styled from the tokens and hand it to
/// the ambient [ScaffoldMessenger]:
///
/// ```dart
/// AppSnackbar.showSuccess(context, message: 'أحسنت!');
/// ```
///
/// Any snack bar already on screen is replaced, so a burst of events cannot
/// queue up behind the user.
abstract final class AppSnackbar {
  /// The neutral form.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String message,
    AppMessageTone? tone,
    String? actionLabel,
    VoidCallback? onActionPressed,
    Duration duration = const Duration(seconds: 4),
  }) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);

    final (Color background, Color foreground, IconData? icon) = switch (tone) {
      AppMessageTone.success => (
        colors.success,
        colors.onSuccess,
        AppIcons.success,
      ),
      AppMessageTone.warning => (
        colors.warning,
        colors.onWarning,
        AppIcons.warning,
      ),
      AppMessageTone.error => (colors.error, colors.onError, AppIcons.error),
      AppMessageTone.info => (colors.info, colors.onInfo, AppIcons.info),
      null => (colors.surfaceInverse, colors.onSurfaceInverse, null),
    };

    messenger.hideCurrentSnackBar();

    return messenger.showSnackBar(
      SnackBar(
        backgroundColor: background,
        behavior: SnackBarBehavior.floating,
        duration: duration,
        elevation: AppElevation.level2,
        margin: const EdgeInsets.all(AppSpacing.lg),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppRadii.input),
        content: Row(
          children: <Widget>[
            if (icon != null) ...<Widget>[
              Icon(icon, size: AppSizing.iconMedium, color: foreground),
              const SizedBox(width: AppSpacing.md),
            ],
            Expanded(
              child: Text(
                message,
                style: typography.bodySmall.copyWith(color: foreground),
              ),
            ),
          ],
        ),
        action: actionLabel == null
            ? null
            : SnackBarAction(
                label: actionLabel,
                textColor: foreground,
                onPressed: onActionPressed ?? () {},
              ),
      ),
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSuccess(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) => show(
    context,
    message: message,
    tone: AppMessageTone.success,
    actionLabel: actionLabel,
    onActionPressed: onActionPressed,
  );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showError(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) => show(
    context,
    message: message,
    tone: AppMessageTone.error,
    actionLabel: actionLabel,
    onActionPressed: onActionPressed,
  );

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showWarning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) => show(
    context,
    message: message,
    tone: AppMessageTone.warning,
    actionLabel: actionLabel,
    onActionPressed: onActionPressed,
  );

  /// Dismisses whatever is on screen.
  static void hide(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
