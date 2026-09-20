import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../cards/app_divider.dart';

/// The list-and-detail layout, collapsed on a phone and side-by-side on a
/// tablet.
///
/// A landscape tablet has room to show what was chosen *and* what it was
/// chosen from; a phone does not. Rather than two screens, this is one widget
/// that renders both arrangements:
///
/// * **compact / medium** — a single pane: [detail] when something is
///   selected, otherwise [pane].
/// * **expanded / large** — [pane] at a fixed width beside [detail], or
///   [placeholder] when nothing is selected yet.
///
/// It stays presentational: it never pushes a route and never decides what is
/// selected. The caller passes `detail: null` to mean "nothing selected",
/// which on a phone is what going back looks like.
///
/// ```dart
/// AppTwoPane(
///   pane: LessonList(onSelected: (id) => setState(() => _selected = id)),
///   detail: _selected == null ? null : LessonDetail(id: _selected!),
///   placeholder: const AppEmptyState(...),
/// );
/// ```
class AppTwoPane extends StatelessWidget {
  const AppTwoPane({
    super.key,
    required this.pane,
    this.detail,
    this.placeholder,
    this.paneWidth = AppSizing.sidePaneWidth,
    this.showDivider = true,
  });

  /// The list side. Always visible on a wide window.
  final Widget pane;

  /// The detail side. Null means nothing is selected.
  final Widget? detail;

  /// Shown on a wide window in place of a missing [detail].
  final Widget? placeholder;

  final double paneWidth;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    if (!context.isWide) {
      return detail ?? pane;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(width: paneWidth, child: pane),
        if (showDivider) const AppDivider.vertical(),
        Expanded(child: detail ?? placeholder ?? const SizedBox.shrink()),
      ],
    );
  }
}
