import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// How wide the content inside an [AppContentContainer] may grow.
enum AppContentWidth {
  /// Running text and forms. The narrowest ceiling — line length is what is
  /// being protected.
  text,

  /// Mixed content: cards, media, a dashboard.
  wide,

  /// No ceiling. The container still applies the window's gutters.
  full,
}

/// Centres and constrains a screen's content, with gutters that widen as the
/// window does.
///
/// This is the single most important piece of Noor's tablet behaviour. Without
/// it, a layout that reads well on a 402pt phone becomes a 1366pt line of
/// Arabic on a 12.9" tablet — technically fine, unreadable in practice.
///
/// Wrap a screen's body in one:
///
/// ```dart
/// Scaffold(
///   body: AppContentContainer(
///     child: Column(children: <Widget>[...]),
///   ),
/// );
/// ```
///
/// On a phone it is a plain padding. On anything wider it also caps the
/// content and centres it in the window.
class AppContentContainer extends StatelessWidget {
  const AppContentContainer({
    super.key,
    required this.child,
    this.width = AppContentWidth.text,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;

  /// Which ceiling applies. Defaults to [AppContentWidth.text].
  final AppContentWidth width;

  /// Overrides the window's gutters. Leave null for the responsive default.
  final EdgeInsetsGeometry? padding;

  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final AppBreakpoint breakpoint = context.breakpoint;

    final double maxWidth = switch (width) {
      AppContentWidth.text => breakpoint.contentMaxWidth,
      AppContentWidth.wide => breakpoint.wideContentMaxWidth,
      AppContentWidth.full => double.infinity,
    };

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: breakpoint.screenPadding),
          child: child,
        ),
      ),
    );
  }
}
