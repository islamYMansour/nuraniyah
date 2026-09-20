import 'package:flutter/widgets.dart';

import '../../theme/theme.dart';

/// A non-scrolling grid whose column count follows the window.
///
/// Noor is full of grids of equally weighted tiles — the Arabic letters, the
/// harakat, a level's lessons — and those are exactly what looks worst when a
/// phone layout is stretched to a tablet: two enormous tiles where there is
/// room for five.
///
/// By default the column count comes from [AppBreakpoint.gridColumns] (2 on a
/// phone, up to 5 on a large window). Supply [minTileWidth] instead to derive
/// it from the space actually available, which is the better choice inside a
/// pane whose width does not match the window's.
///
/// It lays out with a [Wrap], so it composes inside a `Column` or a
/// `ListView` without needing `shrinkWrap`.
class AppAdaptiveGrid extends StatelessWidget {
  const AppAdaptiveGrid({
    super.key,
    required this.children,
    this.columns,
    this.minTileWidth,
    this.spacing = AppSpacing.md,
    this.runSpacing = AppSpacing.md,
    this.tileAspectRatio,
  });

  final List<Widget> children;

  /// Forces a column count, ignoring the window and [minTileWidth].
  final int? columns;

  /// Fits as many columns as will hold a tile at least this wide.
  final double? minTileWidth;

  final double spacing;
  final double runSpacing;

  /// Constrains each tile's height to `width / tileAspectRatio`. Leave null to
  /// let the tiles size themselves.
  final double? tileAspectRatio;

  @override
  Widget build(BuildContext context) {
    final int fromBreakpoint = context.breakpoint.gridColumns;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double available = constraints.maxWidth;

        int columnCount;
        if (columns != null) {
          columnCount = columns!;
        } else if (minTileWidth != null && available.isFinite) {
          columnCount =
              ((available + spacing) / (minTileWidth! + spacing)).floor();
        } else {
          columnCount = fromBreakpoint;
        }
        columnCount = columnCount.clamp(1, children.length.clamp(1, 12));

        final double tileWidth = available.isFinite
            ? (available - spacing * (columnCount - 1)) / columnCount
            : double.infinity;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: <Widget>[
            for (final Widget child in children)
              SizedBox(
                width: tileWidth,
                height: tileAspectRatio == null || !tileWidth.isFinite
                    ? null
                    : tileWidth / tileAspectRatio!,
                child: child,
              ),
          ],
        );
      },
    );
  }
}
