import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// One destination in an [AppBottomNav].
@immutable
class AppNavDestination {
  const AppNavDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badgeCount,
  });

  final IconData icon;

  /// Shown while this destination is current. Defaults to [icon].
  final IconData? selectedIcon;

  final String label;

  /// A count shown on the icon. Null or zero hides the badge.
  final int? badgeCount;
}

/// The bottom navigation bar.
///
/// A controlled component: it renders [currentIndex] and reports taps through
/// [onDestinationSelected]. It does not route, own state, or know what any
/// destination means.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.destinations,
    required this.onDestinationSelected,
  }) : assert(
          destinations.length >= 2 && destinations.length <= 5,
          'A bottom bar carries between two and five destinations.',
        );

  final int currentIndex;
  final List<AppNavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border(
          top: BorderSide(color: colors.divider, width: AppSizing.borderWidth),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizing.buttonHeightLarge,
          child: Row(
            children: <Widget>[
              for (int i = 0; i < destinations.length; i++)
                Expanded(
                  child: _Destination(
                    destination: destinations[i],
                    isSelected: i == currentIndex,
                    onTap: () => onDestinationSelected(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({
    required this.destination,
    required this.isSelected,
    required this.onTap,
  });

  final AppNavDestination destination;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color color = isSelected ? colors.primary : colors.textSecondary;
    final int count = destination.badgeCount ?? 0;

    return Semantics(
      button: true,
      selected: isSelected,
      label: destination.label,
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Badge(
              isLabelVisible: count > 0,
              label: Text(count > 99 ? '99+' : '$count'),
              backgroundColor: colors.error,
              textColor: colors.onError,
              child: AnimatedSwitcher(
                duration: AppDuration.fast,
                child: Icon(
                  isSelected
                      ? (destination.selectedIcon ?? destination.icon)
                      : destination.icon,
                  key: ValueKey<bool>(isSelected),
                  size: AppSizing.iconMedium,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              destination.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.typography.labelSmall.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
