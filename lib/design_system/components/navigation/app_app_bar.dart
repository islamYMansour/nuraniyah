import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_back_button.dart';

/// Noor's top app bar.
///
/// Flat and transparent by default so it melts into the cream ground, as the
/// design's screens do; pass `hasBorder: true` for content that scrolls
/// beneath it and needs a visible edge.
///
/// Implements [PreferredSizeWidget], so it drops straight into
/// `Scaffold.appBar`.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions = const <Widget>[],
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.centerTitle = true,
    this.hasBorder = false,
    this.backgroundColor,
    this.bottom,
  }) : assert(
         title == null || titleWidget == null,
         'Supply a title or a titleWidget, not both.',
       );

  /// Plain-text title, styled from the tokens.
  final String? title;

  /// A custom title widget, when [title] is not enough.
  final Widget? titleWidget;

  final List<Widget> actions;

  /// A custom leading widget. Ignored when [showBackButton] is true.
  final Widget? leading;

  /// Shows a direction-aware [AppBackButton].
  final bool showBackButton;

  /// Overrides what the back button does.
  final VoidCallback? onBackPressed;

  final bool centerTitle;

  /// Draws a hairline along the bottom edge.
  final bool hasBorder;

  final Color? backgroundColor;

  /// An extra row beneath the bar — typically an `AppTabBar`.
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: hasBorder
            ? Border(
                bottom: BorderSide(
                  color: colors.divider,
                  width: AppSizing.borderWidth,
                ),
              )
            : null,
      ),
      child: AppBar(
        backgroundColor: backgroundColor ?? colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level0,
        scrolledUnderElevation: AppElevation.level0,
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        titleSpacing: AppSpacing.lg,
        leading: showBackButton
            ? AppBackButton(onPressed: onBackPressed)
            : leading,
        title:
            titleWidget ??
            (title == null
                ? null
                : Text(
                    title!,
                    style: context.typography.titleLarge.copyWith(
                      color: colors.textPrimary,
                    ),
                  )),
        actions: <Widget>[
          ...actions,
          if (actions.isNotEmpty) const SizedBox(width: AppSpacing.sm),
        ],
        bottom: bottom,
      ),
    );
  }
}
