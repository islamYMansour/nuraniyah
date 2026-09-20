import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// One choice in an [AppRadioGroup].
@immutable
class AppRadioOption<T> {
  const AppRadioOption({
    required this.value,
    required this.label,
    this.supportingText,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? supportingText;
  final bool enabled;
}

/// A set of mutually exclusive choices.
///
/// The group is the component rather than the individual radio, because a
/// lone radio is meaningless — and because Flutter now requires a
/// [RadioGroup] ancestor to own the selection (`Radio.groupValue` is
/// deprecated). This wraps that for you.
///
/// The whole row is tappable, not just the 20pt dot.
class AppRadioGroup<T> extends StatelessWidget {
  const AppRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.options,
    this.enabled = true,
    this.axis = Axis.vertical,
  });

  /// The currently selected value, or null for nothing selected.
  final T? value;

  /// A null handler disables the whole group.
  final ValueChanged<T?>? onChanged;

  final List<AppRadioOption<T>> options;

  /// Disables the whole group independently of [onChanged].
  final bool enabled;

  /// Lay the options out in a column (the default) or a row.
  final Axis axis;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final List<Widget> tiles = <Widget>[
      for (final AppRadioOption<T> option in options)
        _AppRadioTile<T>(
          option: option,
          isSelected: option.value == value,
          enabled: _isInteractive && option.enabled,
          onTap: _isInteractive && option.enabled
              ? () => onChanged!(option.value)
              : null,
          isExpanded: axis == Axis.vertical,
        ),
    ];

    return RadioGroup<T>(
      groupValue: value,
      onChanged: _isInteractive ? onChanged! : (T? _) {},
      child: axis == Axis.vertical
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: tiles,
            )
          : Row(mainAxisSize: MainAxisSize.min, children: tiles),
    );
  }
}

class _AppRadioTile<T> extends StatelessWidget {
  const _AppRadioTile({
    required this.option,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
    required this.isExpanded,
  });

  final AppRadioOption<T> option;
  final bool isSelected;
  final bool enabled;
  final VoidCallback? onTap;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final Color labelColor = enabled ? colors.textPrimary : colors.textDisabled;

    final Widget label = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          option.label,
          style: typography.bodyMedium.copyWith(color: labelColor),
        ),
        if (option.supportingText != null) ...<Widget>[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            option.supportingText!,
            style: typography.caption.copyWith(color: colors.textSecondary),
          ),
        ],
      ],
    );

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: isSelected,
      enabled: enabled,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadii.input,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
            children: <Widget>[
              SizedBox.square(
                dimension: AppSizing.minTouchTarget,
                child: Center(
                  child: ExcludeSemantics(
                    child: Radio<T>(
                      value: option.value,
                      enabled: enabled,
                      activeColor: colors.primary,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              if (isExpanded)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppSpacing.md),
                    child: label,
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.md),
                  child: label,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
