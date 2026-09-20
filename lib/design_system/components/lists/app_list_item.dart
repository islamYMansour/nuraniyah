import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';
import '../common/app_pressable.dart';

/// A row in a list.
///
/// Composes [AppPressable] when [onTap] is given, so a tappable row presses
/// with the same travel as every other control and is announced correctly.
///
/// [leading] and [trailing] take any widget — an `AppAvatar`, an `AppTag`, an
/// `AppCheckbox`. When [showChevron] is true a direction-aware chevron is
/// appended, which flips in Arabic.
class AppListItem extends StatelessWidget {
  const AppListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.enabled = true,
    this.showChevron = false,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.md,
    ),
    this.backgroundColor,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  /// Draws the selected treatment and reports it to assistive technology.
  final bool isSelected;

  final bool enabled;

  /// Appends a direction-aware chevron after [trailing].
  final bool showChevron;

  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final bool isInteractive = enabled && onTap != null;

    final Color titleColor =
        enabled ? colors.textPrimary : colors.textDisabled;

    final Widget content = Row(
      children: <Widget>[
        if (leading != null) ...<Widget>[
          leading!,
          const SizedBox(width: AppSpacing.lg),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: typography.titleSmall.copyWith(color: titleColor),
              ),
              if (subtitle != null) ...<Widget>[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  subtitle!,
                  style: typography.bodySmall
                      .copyWith(color: colors.textSecondary),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...<Widget>[
          const SizedBox(width: AppSpacing.md),
          trailing!,
        ],
        if (showChevron) ...<Widget>[
          const SizedBox(width: AppSpacing.sm),
          Icon(
            AppIcons.chevronForward,
            size: AppSizing.iconMedium,
            color: colors.textDisabled,
          ),
        ],
      ],
    );

    final Color background = backgroundColor ??
        (isSelected ? colors.primaryContainer : Colors.transparent);

    if (!isInteractive) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          borderRadius: AppRadii.input,
        ),
        child: Padding(padding: padding, child: content),
      );
    }

    return AppPressable(
      onPressed: onTap,
      onLongPress: onLongPress,
      enabled: enabled,
      isSelected: isSelected,
      color: background,
      shadowOffset: 0,
      borderRadius: AppRadii.input,
      padding: padding,
      child: content,
    );
  }
}
