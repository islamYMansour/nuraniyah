import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// An on/off switch with an optional label and supporting text.
///
/// Use a switch for a setting that takes effect immediately, and a checkbox
/// for something that is confirmed later by a submit.
class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.supportingText,
    this.enabled = true,
  });

  final bool value;

  /// A null handler disables the switch.
  final ValueChanged<bool>? onChanged;

  final String? label;
  final String? supportingText;
  final bool enabled;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    final Widget control = Switch(
      value: value,
      onChanged: _isInteractive ? onChanged : null,
      activeThumbColor: colors.onPrimary,
      activeTrackColor: colors.primary,
      inactiveThumbColor: colors.surface,
      inactiveTrackColor: colors.surfaceVariant,
      trackOutlineColor: WidgetStatePropertyAll<Color>(colors.border),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    if (label == null) {
      return SizedBox(
        height: AppSizing.minTouchTarget,
        child: Center(child: control),
      );
    }

    return Semantics(
      toggled: value,
      enabled: _isInteractive,
      child: InkWell(
        onTap: _isInteractive ? () => onChanged!(!value) : null,
        borderRadius: AppRadii.input,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.md,
            horizontal: AppSpacing.xs,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label!,
                      style: typography.bodyMedium.copyWith(
                        color: _isInteractive
                            ? colors.textPrimary
                            : colors.textDisabled,
                      ),
                    ),
                    if (supportingText != null) ...<Widget>[
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        supportingText!,
                        style: typography.caption.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              ExcludeSemantics(child: control),
            ],
          ),
        ),
      ),
    );
  }
}
