import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A titled block of content.
///
/// Draws the heading, optional description and optional trailing action, then
/// its children, with the section rhythm taken from [AppSpacing]. Using this
/// instead of hand-rolled `Column`s is what keeps vertical spacing identical
/// from screen to screen.
class AppSection extends StatelessWidget {
  const AppSection({
    super.key,
    required this.children,
    this.title,
    this.description,
    this.action,
    this.padding = EdgeInsets.zero,
    this.childSpacing = AppSpacing.contentGap,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
  });

  final List<Widget> children;

  final String? title;

  /// A line of explanatory text beneath the title.
  final String? description;

  /// A trailing control aligned with the title — typically an
  /// `AppButton.text` such as "See all".
  final Widget? action;

  final EdgeInsetsGeometry padding;

  /// Gap inserted between each of [children].
  final double childSpacing;

  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null || action != null) ...<Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (title != null)
                        Text(
                          title!,
                          style: typography.titleLarge.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      if (description != null) ...<Widget>[
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          description!,
                          style: typography.bodySmall.copyWith(
                            color: colors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (action != null) ...<Widget>[
                  const SizedBox(width: AppSpacing.md),
                  action!,
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.contentGap),
          ],
          for (int i = 0; i < children.length; i++) ...<Widget>[
            if (i > 0) SizedBox(height: childSpacing),
            children[i],
          ],
        ],
      ),
    );
  }
}
