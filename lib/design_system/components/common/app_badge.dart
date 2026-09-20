import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A count or status marker pinned to another widget.
///
/// With a [child] it overlays the corner; without one it renders standalone,
/// which is what you want inside a row of its own.
class AppBadge extends StatelessWidget {
  const AppBadge({
    super.key,
    this.count,
    this.label,
    this.child,
    this.color,
    this.isVisible = true,
  });

  /// A dot with no number.
  const AppBadge.dot({super.key, this.child, this.color, this.isVisible = true})
    : count = null,
      label = null;

  /// Counts above 99 render as "99+". Zero hides the badge.
  final int? count;

  /// Text shown instead of [count].
  final String? label;

  /// The widget the badge is pinned to.
  final Widget? child;

  /// Defaults to the error colour, which is what a count badge means.
  final Color? color;

  final bool isVisible;

  bool get _isDot => count == null && label == null;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool show = isVisible && (count == null || count! > 0);
    final Color background = color ?? colors.error;

    if (child == null) {
      return show
          ? _Marker(
              text: _isDot ? null : (label ?? _formatCount(count!)),
              background: background,
              foreground: colors.onError,
            )
          : const SizedBox.shrink();
    }

    return Badge(
      isLabelVisible: show,
      backgroundColor: background,
      textColor: colors.onError,
      smallSize: AppSpacing.sm,
      largeSize: AppSpacing.lg,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      textStyle: context.typography.labelSmall,
      label: _isDot ? null : Text(label ?? _formatCount(count!)),
      child: child,
    );
  }

  static String _formatCount(int value) => value > 99 ? '99+' : '$value';
}

class _Marker extends StatelessWidget {
  const _Marker({
    required this.text,
    required this.background,
    required this.foreground,
  });

  final String? text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return Container(
        width: AppSpacing.sm,
        height: AppSpacing.sm,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      );
    }

    return Container(
      constraints: const BoxConstraints(minWidth: AppSpacing.xl),
      height: AppSpacing.xl,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, borderRadius: AppRadii.chip),
      child: Text(
        text!,
        style: context.typography.labelSmall.copyWith(color: foreground),
      ),
    );
  }
}
