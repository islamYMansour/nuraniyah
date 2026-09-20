import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';

/// What a chip is for.
enum AppChipVariant {
  /// A one-shot action. Tappable, never selected.
  assist,

  /// A toggle in a filter row. Carries a selected state.
  filter,

  /// A value the user entered, with a remove affordance.
  input,
}

/// A compact, rounded token.
///
/// [AppChipVariant.filter] chips animate between their unselected and
/// selected treatments; [AppChipVariant.input] chips show a remove button
/// when [onDeleted] is supplied.
///
/// For a chip that is purely a label with no interaction, use `AppTag` — it is
/// lighter and is not announced as a button.
class AppChip extends StatelessWidget {
  const AppChip({
    super.key,
    required this.label,
    this.variant = AppChipVariant.assist,
    this.icon,
    this.onPressed,
    this.onDeleted,
    this.isSelected = false,
    this.enabled = true,
    this.deleteTooltip = 'Remove',
  });

  final String label;
  final AppChipVariant variant;

  /// Shown before the label.
  final IconData? icon;

  final VoidCallback? onPressed;

  /// Shows a remove button. Only meaningful on [AppChipVariant.input].
  final VoidCallback? onDeleted;

  final bool isSelected;
  final bool enabled;

  /// Accessibility label for the remove button.
  final String deleteTooltip;

  bool get _isInteractive =>
      enabled && (onPressed != null || onDeleted != null);

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    final bool showSelected = variant == AppChipVariant.filter && isSelected;

    final Color background = switch (true) {
      _ when !enabled => colors.disabled,
      _ when showSelected => colors.primaryContainer,
      _ => colors.surfaceVariant,
    };

    final Color foreground = switch (true) {
      _ when !enabled => colors.textDisabled,
      _ when showSelected => colors.onPrimaryContainer,
      _ => colors.textSecondary,
    };

    final Color borderColor = switch (true) {
      _ when !enabled => colors.disabled,
      _ when showSelected => colors.primary,
      _ => colors.border,
    };

    final Widget body = AnimatedContainer(
      duration: AppDuration.fast,
      curve: AppCurves.standard,
      constraints: const BoxConstraints(minHeight: AppSizing.iconXLarge),
      padding: EdgeInsetsDirectional.only(
        start: AppSpacing.lg,
        end: onDeleted != null ? AppSpacing.xs : AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: AppRadii.chip,
        border: Border.all(color: borderColor, width: AppSizing.borderWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (showSelected) ...<Widget>[
            Icon(AppIcons.check, size: AppSizing.iconSmall, color: foreground),
            const SizedBox(width: AppSpacing.sm),
          ] else if (icon != null) ...<Widget>[
            Icon(icon, size: AppSizing.iconSmall, color: foreground),
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(
            label,
            style: typography.labelMedium.copyWith(color: foreground),
          ),
          if (onDeleted != null) ...<Widget>[
            const SizedBox(width: AppSpacing.xs),
            IconButton(
              onPressed: enabled ? onDeleted : null,
              icon: Icon(AppIcons.close, color: foreground),
              iconSize: AppSizing.iconSmall,
              tooltip: deleteTooltip,
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints.tightFor(
                width: AppSizing.iconXLarge,
                height: AppSizing.iconXLarge,
              ),
            ),
          ],
        ],
      ),
    );

    if (onPressed == null) {
      return body;
    }

    return Semantics(
      button: true,
      selected: variant == AppChipVariant.filter ? isSelected : null,
      enabled: _isInteractive,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: enabled ? onPressed : null,
        child: body,
      ),
    );
  }
}
