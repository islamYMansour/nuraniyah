import 'package:flutter/material.dart';

import '../design_system.dart';
import 'sections/controls_section.dart';
import 'sections/feedback_section.dart';
import 'sections/foundations_section.dart';
import 'sections/surfaces_section.dart';

/// A live catalogue of the design system.
///
/// **A test harness, not an application screen.** It exists so the tokens and
/// components can be seen, pressed and checked in both themes and both
/// writing directions before any real screen is built. No feature should
/// import it, and it holds no business logic.
///
/// It owns its own theme and [Directionality] rather than inheriting them, so
/// the two toggles in the app bar flip everything beneath without touching
/// the host app:
///
/// * **Theme** — light and dark, to confirm every token has a dark value and
///   that nothing relies on a hard-coded colour.
/// * **Direction** — RTL and LTR. Noor is Arabic-first, so RTL is the
///   default here; flip to LTR to catch any component that uses `left`/`right`
///   where it should use `start`/`end`.
///
/// To view it, point your entry point at it temporarily:
///
/// ```dart
/// MaterialApp(home: const DesignSystemGallery());
/// ```
class DesignSystemGallery extends StatefulWidget {
  const DesignSystemGallery({super.key});

  @override
  State<DesignSystemGallery> createState() => _DesignSystemGalleryState();
}

class _DesignSystemGalleryState extends State<DesignSystemGallery> {
  bool _isDark = false;
  TextDirection _direction = TextDirection.rtl;

  static const List<AppTab> _tabs = <AppTab>[
    AppTab(label: 'Foundations'),
    AppTab(label: 'Controls'),
    AppTab(label: 'Surfaces'),
    AppTab(label: 'Feedback'),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = _isDark ? AppTheme.dark : AppTheme.light;

    return Theme(
      data: theme,
      child: Directionality(
        textDirection: _direction,
        child: Builder(
          // A Builder so the descendants below read the overridden theme and
          // direction, not the host app's.
          builder: (BuildContext context) {
            return DefaultTabController(
              length: _tabs.length,
              child: Scaffold(
                backgroundColor: context.colors.background,
                appBar: AppAppBar(
                  title: 'Design System',
                  centerTitle: false,
                  hasBorder: true,
                  actions: <Widget>[
                    AppIconButton(
                      icon: _direction == TextDirection.rtl
                          ? AppIcons.forward
                          : AppIcons.back,
                      tooltip: _direction == TextDirection.rtl
                          ? 'Switch to LTR'
                          : 'Switch to RTL',
                      onPressed: () => setState(
                        () => _direction = _direction == TextDirection.rtl
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                      ),
                    ),
                    AppIconButton(
                      icon: AppIcons.theme,
                      tooltip: _isDark
                          ? 'Switch to light theme'
                          : 'Switch to dark theme',
                      isSelected: _isDark,
                      onPressed: () => setState(() => _isDark = !_isDark),
                    ),
                  ],
                  bottom: const AppTabBar(tabs: _tabs, isScrollable: true),
                ),
                body: const TabBarView(
                  children: <Widget>[
                    FoundationsSection(),
                    ControlsSection(),
                    SurfacesSection(),
                    FeedbackSection(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
