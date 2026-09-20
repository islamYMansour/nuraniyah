import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';

/// One entry in an [AppDropdown].
@immutable
class AppDropdownItem<T> {
  const AppDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final IconData? icon;
  final bool enabled;
}

/// A single-select dropdown.
///
/// Wears the same shell as [AppTextField] — label above, field body, error or
/// supporting text below — so a form of mixed inputs lines up.
class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
    this.errorText,
    this.supportingText,
    this.leadingIcon,
    this.enabled = true,
    this.isRequired = false,
  });

  /// The selected value, or null for nothing selected.
  final T? value;

  final List<AppDropdownItem<T>> items;

  /// A null handler disables the dropdown.
  final ValueChanged<T?>? onChanged;

  final String? label;

  /// Shown while nothing is selected.
  final String? hint;

  final String? errorText;
  final String? supportingText;
  final IconData? leadingIcon;
  final bool enabled;
  final bool isRequired;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final bool hasError = errorText != null;

    final Color contentColor =
        _isInteractive ? colors.textPrimary : colors.textDisabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text.rich(
            TextSpan(
              text: label,
              children: isRequired
                  ? <InlineSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: colors.error),
                      ),
                    ]
                  : null,
            ),
            style: typography.labelLarge.copyWith(
              color: _isInteractive ? colors.textSecondary : colors.textDisabled,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Container(
          decoration: BoxDecoration(
            color: _isInteractive ? colors.surfaceVariant : colors.disabled,
            borderRadius: AppRadii.input,
            border: Border.all(
              color: hasError ? colors.error : colors.border,
              width: hasError
                  ? AppSizing.borderWidthThick
                  : AppSizing.borderWidth,
            ),
          ),
          padding: const EdgeInsetsDirectional.only(
            start: AppSpacing.lg,
            end: AppSpacing.md,
          ),
          child: Row(
            children: <Widget>[
              if (leadingIcon != null) ...<Widget>[
                Icon(
                  leadingIcon,
                  size: AppSizing.iconMedium,
                  color: _isInteractive
                      ? colors.textSecondary
                      : colors.textDisabled,
                ),
                const SizedBox(width: AppSpacing.md),
              ],
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<T>(
                    value: value,
                    isExpanded: true,
                    onChanged: _isInteractive ? onChanged : null,
                    borderRadius: AppRadii.input,
                    dropdownColor: colors.surface,
                    focusColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.lg,
                    ),
                    icon: Icon(
                      AppIcons.expand,
                      color: _isInteractive
                          ? colors.textSecondary
                          : colors.textDisabled,
                    ),
                    style: typography.bodyMedium.copyWith(color: contentColor),
                    hint: hint == null
                        ? null
                        : Text(
                            hint!,
                            style: typography.bodyMedium
                                .copyWith(color: colors.textDisabled),
                          ),
                    items: <DropdownMenuItem<T>>[
                      for (final AppDropdownItem<T> item in items)
                        DropdownMenuItem<T>(
                          value: item.value,
                          enabled: item.enabled,
                          child: Row(
                            children: <Widget>[
                              if (item.icon != null) ...<Widget>[
                                Icon(
                                  item.icon,
                                  size: AppSizing.iconSmall,
                                  color: colors.textSecondary,
                                ),
                                const SizedBox(width: AppSpacing.sm),
                              ],
                              Flexible(
                                child: Text(
                                  item.label,
                                  overflow: TextOverflow.ellipsis,
                                  style: typography.bodyMedium.copyWith(
                                    color: item.enabled
                                        ? colors.textPrimary
                                        : colors.textDisabled,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null || supportingText != null) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          Text(
            errorText ?? supportingText!,
            style: typography.caption.copyWith(
              color: hasError ? colors.error : colors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
