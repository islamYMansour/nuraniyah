import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../buttons/app_button.dart';

/// Noor's modal dialog.
///
/// [AppDialog] is the widget; the static helpers on [AppDialogs] show it and
/// return the user's answer. Actions stack vertically so that long Arabic
/// labels are never squeezed or ellipsised, with the confirming action on
/// top.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.message,
    this.content,
    this.actions = const <Widget>[],
    this.icon,
    this.iconColor,
  });

  final String title;

  /// A line of body text. Ignored when [content] is supplied.
  final String? message;

  /// Arbitrary body content, for anything richer than [message].
  final Widget? content;

  /// Buttons, laid out in a column in the order given.
  final List<Widget> actions;

  /// An icon in a tinted plate above the title.
  final IconData? icon;

  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    return Dialog(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: AppElevation.level3,
      shape: AppShapes.dialog,
      insetPadding: const EdgeInsets.all(AppSpacing.xxl),
      // Without a ceiling a dialog tracks the window, and on a landscape
      // tablet a two-line confirmation ends up a metre wide.
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizing.maxDialogWidth),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Center(
                  child: Container(
                    width: AppSizing.avatarMedium,
                    height: AppSizing.avatarMedium,
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: AppSizing.iconLarge,
                      color: iconColor ?? colors.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
              ],
              Text(
                title,
                textAlign: TextAlign.center,
                style: typography.headlineSmall.copyWith(
                  color: colors.textPrimary,
                ),
              ),
              if (content != null) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                content!,
              ] else if (message != null) ...<Widget>[
                const SizedBox(height: AppSpacing.md),
                Text(
                  message!,
                  textAlign: TextAlign.center,
                  style: typography.bodyMedium.copyWith(
                    color: colors.textSecondary,
                  ),
                ),
              ],
              if (actions.isNotEmpty) ...<Widget>[
                const SizedBox(height: AppSpacing.sectionGap),
                for (int i = 0; i < actions.length; i++) ...<Widget>[
                  if (i > 0) const SizedBox(height: AppSpacing.md),
                  actions[i],
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Imperative helpers for showing an [AppDialog].
abstract final class AppDialogs {
  /// A dialog with a single dismissing action.
  ///
  /// Returns once it is closed.
  static Future<void> alert(
    BuildContext context, {
    required String title,
    String? message,
    String confirmLabel = 'OK',
    IconData? icon,
    bool isDismissible = true,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: isDismissible,
      barrierColor: context.colors.scrim.withValues(
        alpha: AppElevation.scrimOpacity,
      ),
      builder: (BuildContext dialogContext) => AppDialog(
        title: title,
        message: message,
        icon: icon,
        actions: <Widget>[
          AppButton.primary(
            label: confirmLabel,
            isFullWidth: true,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      ),
    );
  }

  /// A two-action dialog.
  ///
  /// Resolves to true if the user confirmed, false if they cancelled, and
  /// null if they dismissed it another way. Set [isDestructive] for an action
  /// that cannot be undone — the confirming button turns red.
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    IconData? icon,
    bool isDestructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: context.colors.scrim.withValues(
        alpha: AppElevation.scrimOpacity,
      ),
      builder: (BuildContext dialogContext) => AppDialog(
        title: title,
        message: message,
        icon: icon,
        iconColor: isDestructive ? dialogContext.colors.error : null,
        actions: <Widget>[
          if (isDestructive)
            AppButton.danger(
              label: confirmLabel,
              isFullWidth: true,
              onPressed: () => Navigator.of(dialogContext).pop(true),
            )
          else
            AppButton.primary(
              label: confirmLabel,
              isFullWidth: true,
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          AppButton.text(
            label: cancelLabel,
            isFullWidth: true,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
        ],
      ),
    );
  }

  /// Shows any widget as a modal, with Noor's scrim and shape.
  static Future<T?> custom<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool isDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: isDismissible,
      barrierColor: context.colors.scrim.withValues(
        alpha: AppElevation.scrimOpacity,
      ),
      builder: builder,
    );
  }
}
