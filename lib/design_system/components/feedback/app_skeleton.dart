import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A shimmering placeholder block.
///
/// Shown in the shape of the content that is loading, so the page does not
/// jump when the real thing arrives. The sweep is hand-rolled from an
/// [AnimationController] and a [LinearGradient] rather than a shimmer package
/// — it is a dozen lines, and it keeps the dependency list empty.
///
/// The animation respects the platform's "reduce motion" setting: when that
/// is on, the block renders as a still tint.
class AppSkeleton extends StatefulWidget {
  const AppSkeleton({
    super.key,
    this.width,
    this.height = AppSpacing.lg,
    this.borderRadius = AppRadii.input,
  });

  /// A single line of placeholder text.
  const AppSkeleton.text({super.key, this.width})
    : height = AppSpacing.lg,
      borderRadius = AppRadii.indicator;

  /// A circular placeholder, for an avatar.
  const AppSkeleton.circle({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = AppRadii.chip;

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<AppSkeleton> createState() => _AppSkeletonState();
}

class _AppSkeletonState extends State<AppSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDuration.shimmer,
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool reduceMotion = MediaQuery.disableAnimationsOf(context);

    final Widget block = SizedBox(width: widget.width, height: widget.height);

    if (reduceMotion) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceVariant,
          borderRadius: widget.borderRadius,
        ),
        child: block,
      );
    }

    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          // Sweep a highlight band from one edge to the other.
          final double t = _controller.value * 3 - 1;
          return DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(t - 1, 0),
                end: Alignment(t + 1, 0),
                colors: <Color>[
                  colors.surfaceVariant,
                  colors.border,
                  colors.surfaceVariant,
                ],
              ),
            ),
            child: child,
          );
        },
        child: block,
      ),
    );
  }
}

/// A stack of [AppSkeleton] lines standing in for a paragraph.
///
/// The last line is shortened, which is what makes a block of placeholders
/// read as text rather than as bars.
class AppSkeletonParagraph extends StatelessWidget {
  const AppSkeletonParagraph({
    super.key,
    this.lines = 3,
    this.spacing = AppSpacing.sm,
  });

  final int lines;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (int i = 0; i < lines; i++) ...<Widget>[
          if (i > 0) SizedBox(height: spacing),
          FractionallySizedBox(
            alignment: AlignmentDirectional.centerStart,
            widthFactor: i == lines - 1 ? 0.6 : 1,
            child: const AppSkeleton.text(),
          ),
        ],
      ],
    );
  }
}
