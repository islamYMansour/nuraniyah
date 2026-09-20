import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// Builds a different tree per window size class.
///
/// Reach for it when a tablet needs a genuinely different *layout*, not just
/// looser spacing — a row where the phone has a column, a second pane, a grid
/// where the phone has a list. For anything that is only a value change, use
/// `AppResponsive.value` instead; a whole second widget tree is a lot of code
/// to maintain for a number.
///
/// Only [compact] is required; a class with no builder falls back to the
/// nearest narrower one.
///
/// ```dart
/// AppResponsiveBuilder(
///   compact: (BuildContext context) => const _LessonList(),
///   expanded: (BuildContext context) => const _LessonListAndDetail(),
/// );
/// ```
class AppResponsiveBuilder extends StatelessWidget {
  const AppResponsiveBuilder({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
  });

  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;
  final WidgetBuilder? large;

  @override
  Widget build(BuildContext context) {
    final WidgetBuilder builder = AppResponsive.value<WidgetBuilder>(
      context,
      compact: compact,
      medium: medium,
      expanded: expanded,
      large: large,
    );
    return builder(context);
  }
}
