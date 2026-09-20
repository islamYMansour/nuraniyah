import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// One segment of an [AppSegmentedControl].
@immutable
class AppSegment<T> {
  const AppSegment({required this.value, required this.label, this.icon});

  final T value;
  final String label;
  final IconData? icon;
}

/// A pill of mutually exclusive segments — the toggle form.
///
/// Built from scratch rather than from Material's [SegmentedButton] so the
/// selected thumb slides with Noor's own motion tokens and the whole control
/// wears the pill radius from the design.
///
/// Use it for two to four short, equally weighted choices. Beyond that, use
/// [AppDropdown].
class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.value,
    required this.segments,
    required this.onChanged,
    this.enabled = true,
  }) : assert(
         segments.length > 1,
         'A segmented control needs two or more segments.',
       );

  final T value;
  final List<AppSegment<T>> segments;

  /// A null handler disables the control.
  final ValueChanged<T>? onChanged;

  final bool enabled;

  bool get _isInteractive => enabled && onChanged != null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: _isInteractive ? colors.surfaceVariant : colors.disabled,
        borderRadius: AppRadii.chip,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final AppSegment<T> segment in segments)
            Flexible(
              child: _Segment<T>(
                segment: segment,
                isSelected: segment.value == value,
                enabled: _isInteractive,
                onTap: _isInteractive ? () => onChanged!(segment.value) : null,
                colors: colors,
                typography: typography,
              ),
            ),
        ],
      ),
    );
  }
}

class _Segment<T> extends StatelessWidget {
  const _Segment({
    required this.segment,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
    required this.colors,
    required this.typography,
  });

  final AppSegment<T> segment;
  final bool isSelected;
  final bool enabled;
  final VoidCallback? onTap;
  final AppColors colors;
  final AppTypography typography;

  @override
  Widget build(BuildContext context) {
    final Color foreground = switch (true) {
      _ when !enabled => colors.textDisabled,
      _ when isSelected => colors.onPrimary,
      _ => colors.textSecondary,
    };

    return Semantics(
      inMutuallyExclusiveGroup: true,
      selected: isSelected,
      enabled: enabled,
      button: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppDuration.fast,
          curve: AppCurves.standard,
          height: AppSizing.buttonHeightSmall,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: isSelected && enabled ? colors.primary : Colors.transparent,
            borderRadius: AppRadii.chip,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (segment.icon != null) ...<Widget>[
                Icon(
                  segment.icon,
                  size: AppSizing.iconSmall,
                  color: foreground,
                ),
                const SizedBox(width: AppSpacing.sm),
              ],
              Flexible(
                child: Text(
                  segment.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: typography.labelMedium.copyWith(color: foreground),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
