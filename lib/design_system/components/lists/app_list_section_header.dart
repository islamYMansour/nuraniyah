import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A heading between groups of list rows.
///
/// Quieter than [AppSection]'s title — it labels a run of rows rather than
/// opening a whole block of a screen. Pass [count] to show how many rows
/// follow.
class AppListSectionHeader extends StatelessWidget {
  const AppListSectionHeader({
    super.key,
    required this.title,
    this.count,
    this.action,
    this.padding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.sm,
    ),
  });

  final String title;
  final int? count;

  /// A trailing control, typically an `AppButton.text`.
  final Widget? action;

  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              count == null ? title : '$title ($count)',
              style: typography.labelMedium
                  .copyWith(color: colors.textSecondary),
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}
