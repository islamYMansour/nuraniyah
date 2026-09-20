import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// One tab in an [AppTabBar].
@immutable
class AppTab {
  const AppTab({required this.label, this.icon});

  final String label;
  final IconData? icon;
}

/// A row of tabs, styled from the tokens.
///
/// Wraps Material's [TabBar], so it works with the usual [TabController] /
/// [DefaultTabController] plumbing and stays in step with a [TabBarView].
/// The indicator is a rounded bar in the primary colour rather than Material's
/// hairline — it reads better against Noor's soft shapes.
///
/// Implements [PreferredSizeWidget] so it can be passed to
/// `AppAppBar.bottom`.
class AppTabBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.isScrollable = false,
    this.onTap,
  });

  final List<AppTab> tabs;

  /// Falls back to the nearest [DefaultTabController].
  final TabController? controller;

  /// Lets the row scroll when the tabs do not fit.
  final bool isScrollable;

  final ValueChanged<int>? onTap;

  @override
  Size get preferredSize => const Size.fromHeight(AppSizing.buttonHeightSmall);

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    return TabBar(
      controller: controller,
      isScrollable: isScrollable,
      onTap: onTap,
      labelColor: colors.primary,
      unselectedLabelColor: colors.textSecondary,
      labelStyle: typography.labelLarge,
      unselectedLabelStyle: typography.labelLarge,
      dividerColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll<Color>(Colors.transparent),
      indicatorSize: TabBarIndicatorSize.label,
      indicator: UnderlineTabIndicator(
        borderRadius: AppRadii.indicator,
        borderSide: BorderSide(
          color: colors.primary,
          width: AppSizing.focusRingWidth,
        ),
      ),
      tabs: <Widget>[
        for (final AppTab tab in tabs)
          Tab(
            height: AppSizing.buttonHeightSmall,
            icon: tab.icon == null
                ? null
                : Icon(tab.icon, size: AppSizing.iconSmall),
            iconMargin: const EdgeInsets.only(bottom: AppSpacing.xxs),
            text: tab.label,
          ),
      ],
    );
  }
}
