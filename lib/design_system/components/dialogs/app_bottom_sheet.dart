import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// The content shell of a bottom sheet: drag handle, optional title, body.
///
/// Use it inside [AppBottomSheets.show] — or on its own if you are driving
/// the sheet yourself.
class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.actions = const <Widget>[],
    this.padding = const EdgeInsets.all(AppSpacing.xxl),
  });

  final Widget child;
  final String? title;

  /// Trailing controls in the title row.
  final List<Widget> actions;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Container(
              width: AppSizing.iconXLarge,
              height: AppSpacing.xs,
              decoration: BoxDecoration(
                color: colors.borderStrong,
                borderRadius: AppRadii.indicator,
              ),
            ),
          ),
          if (title != null) ...<Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.xxl,
                AppSpacing.lg,
                AppSpacing.xxl,
                0,
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title!,
                      style: context.typography.titleLarge.copyWith(
                        color: colors.textPrimary,
                      ),
                    ),
                  ),
                  ...actions,
                ],
              ),
            ),
          ],
          Flexible(
            child: Padding(padding: padding, child: child),
          ),
        ],
      ),
    );
  }
}

/// Imperative helpers for showing a bottom sheet with Noor's shape and scrim.
abstract final class AppBottomSheets {
  static Future<T?> show<T>(
    BuildContext context, {
    required WidgetBuilder builder,
    bool isDismissible = true,
    bool isScrollControlled = true,
  }) {
    final AppColors colors = context.colors;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      enableDrag: isDismissible,
      showDragHandle: false,
      backgroundColor: colors.surface,
      barrierColor: colors.scrim.withValues(alpha: AppElevation.scrimOpacity),
      shape: AppShapes.sheet,
      // A full-bleed sheet on a landscape tablet is a very wide, very short
      // strip. Cap it and let showModalBottomSheet centre it.
      constraints: context.isWide
          ? const BoxConstraints(maxWidth: AppSizing.maxSheetWidth)
          : null,
      // Keeps the sheet clear of the keyboard when it holds a text field.
      useSafeArea: true,
      builder: builder,
    );
  }
}
