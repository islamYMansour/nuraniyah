import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import 'app_bottom_nav.dart';
import 'app_navigation_rail.dart';

/// Places the app's primary navigation where the window has room for it.
///
/// A bottom bar below the content on a phone or a portrait tablet; a rail
/// down the leading edge on a landscape tablet or larger. One destination
/// list, one selected index, one callback — the arrangement is this widget's
/// problem, not the screen's.
///
/// It wraps a body rather than being a [Scaffold], so the caller keeps its own
/// app bar, FAB and background:
///
/// ```dart
/// Scaffold(
///   appBar: const AppAppBar(title: 'نُور'),
///   body: AppAdaptiveNavigation(
///     currentIndex: _index,
///     destinations: _destinations,
///     onDestinationSelected: (int i) => setState(() => _index = i),
///     child: _pages[_index],
///   ),
/// );
/// ```
///
/// Purely presentational: it renders the index it is given and reports taps.
/// It owns no state and knows nothing about routes.
class AppAdaptiveNavigation extends StatelessWidget {
  const AppAdaptiveNavigation({
    super.key,
    required this.currentIndex,
    required this.destinations,
    required this.onDestinationSelected,
    required this.child,
    this.railLeading,
    this.railTrailing,
  });

  final int currentIndex;
  final List<AppNavDestination> destinations;
  final ValueChanged<int> onDestinationSelected;

  /// The screen's content.
  final Widget child;

  /// Shown above the rail's destinations. Ignored while the bottom bar is in
  /// use, which has nowhere to put it.
  final Widget? railLeading;

  /// Shown at the bottom of the rail.
  final Widget? railTrailing;

  @override
  Widget build(BuildContext context) {
    if (context.isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppNavigationRail(
            currentIndex: currentIndex,
            destinations: destinations,
            onDestinationSelected: onDestinationSelected,
            leading: railLeading,
            trailing: railTrailing,
          ),
          Expanded(child: child),
        ],
      );
    }

    return Column(
      children: <Widget>[
        Expanded(child: child),
        AppBottomNav(
          currentIndex: currentIndex,
          destinations: destinations,
          onDestinationSelected: onDestinationSelected,
        ),
      ],
    );
  }
}
