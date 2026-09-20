import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_bottom_nav.dart';

/// The vertical navigation that replaces the bottom bar on a wide window.
///
/// A bottom bar on a landscape tablet wastes the widest edge of the screen and
/// puts the controls where a child's hands are not. A rail down the leading
/// edge keeps them in reach and gives the content its full height back.
///
/// Takes the same [AppNavDestination] list as [AppBottomNav], so switching
/// between them costs nothing — see [AppAdaptiveNavigation], which does it for
/// you.
class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    super.key,
    required this.currentIndex,
    required this.destinations,
    required this.onDestinationSelected,
    this.leading,
    this.trailing,
  });

  final int currentIndex;
  final List<AppNavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  /// Pinned above the destinations — a logo, or an `AppFab`.
  final Widget? leading;

  /// Pinned to the bottom — a settings or profile control.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.surface,
        border: BorderDirectional(
          end: BorderSide(color: colors.divider, width: AppSizing.borderWidth),
        ),
      ),
      child: SafeArea(
        right: false,
        child: SizedBox(
          width: AppSizing.navigationRailWidth,
          child: Column(
            children: <Widget>[
              if (leading != null) ...<Widget>[
                const SizedBox(height: AppSpacing.lg),
                leading!,
              ],
              const SizedBox(height: AppSpacing.lg),
              for (int i = 0; i < destinations.length; i++)
                _RailDestination(
                  destination: destinations[i],
                  isSelected: i == currentIndex,
                  onTap: () => onDestinationSelected(i),
                ),
              const Spacer(),
              if (trailing != null) ...<Widget>[
                trailing!,
                const SizedBox(height: AppSpacing.lg),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RailDestination extends StatelessWidget {
  const _RailDestination({
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
        borderRadius: AppRadii.input,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: Column(
            children: <Widget>[
              AnimatedContainer(
                duration: AppDuration.fast,
                curve: AppCurves.standard,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? colors.primaryContainer
                      : Colors.transparent,
                  borderRadius: AppRadii.chip,
                ),
                child: Badge(
                  isLabelVisible: count > 0,
                  label: Text(count > 99 ? '99+' : '$count'),
                  backgroundColor: colors.error,
                  textColor: colors.onError,
                  child: Icon(
                    isSelected
                        ? (destination.selectedIcon ?? destination.icon)
                        : destination.icon,
                    size: AppSizing.iconMedium,
                    color: isSelected ? colors.onPrimaryContainer : color,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.typography.labelSmall.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
