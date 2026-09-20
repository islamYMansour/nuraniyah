import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A checkbox with an optional label and supporting text.
///
/// The whole row is the tap target, not just the box — a child aiming at a
/// 20pt square will miss it. Set [isTristate] for an indeterminate state,
/// which reports `null`.
class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.supportingText,
    this.enabled = true,
    this.isError = false,
    this.isTristate = false,
  });

  /// Null renders the indeterminate state, and is only legal when
  /// [isTristate] is true.
  final bool? value;

  /// A null handler disables the checkbox.
  final ValueChanged<bool?>? onChanged;

  final String? label;
  final String? supportingText;
  final bool enabled;

  /// Draws the error treatment — for an unticked required box on a submitted
  /// form.
  final bool isError;

  final bool isTristate;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    final Color labelColor = _isInteractive
        ? colors.textPrimary
        : colors.textDisabled;

    final Widget box = Checkbox(
      value: value,
      tristate: isTristate,
      onChanged: _isInteractive ? onChanged : null,
      isError: isError,
      activeColor: colors.primary,
      checkColor: colors.onPrimary,
      side: BorderSide(
        color: switch (true) {
          _ when !_isInteractive => colors.disabled,
          _ when isError => colors.error,
          _ => colors.borderStrong,
        },
        width: AppSizing.borderWidthThick,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppRadius.xs)),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.standard,
    );

    if (label == null) {
      return SizedBox.square(
        dimension: AppSizing.minTouchTarget,
        child: Center(child: box),
      );
    }

    return Semantics(
      checked: value ?? false,
      enabled: _isInteractive,
      child: InkWell(
        onTap: _isInteractive
            ? () => onChanged!(
                isTristate && value == false ? null : !(value ?? false),
              )
            : null,
        borderRadius: AppRadii.input,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox.square(
                dimension: AppSizing.minTouchTarget,
                child: Center(child: ExcludeSemantics(child: box)),
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        label!,
                        style: typography.bodyMedium.copyWith(
                          color: labelColor,
                        ),
                      ),
                      if (supportingText != null) ...<Widget>[
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          supportingText!,
                          style: typography.caption.copyWith(
                            color: isError
                                ? colors.error
                                : colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
