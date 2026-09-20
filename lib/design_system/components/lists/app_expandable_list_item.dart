import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';

/// A list row that reveals more content when tapped.
///
/// A controlled component when [isExpanded] and [onExpansionChanged] are both
/// given; otherwise it keeps the state itself. Built on [AnimatedCrossFade]
/// with the shared motion tokens rather than Material's [ExpansionTile], whose
/// dividers and padding fight Noor's shapes.
class AppExpandableListItem extends StatefulWidget {
  const AppExpandableListItem({
    super.key,
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.isExpanded,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
    this.enabled = true,
    this.childrenPadding = const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      0,
      AppSpacing.lg,
      AppSpacing.lg,
    ),
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget> children;

  /// Drives the row from outside. Pair with [onExpansionChanged].
  final bool? isExpanded;

  final ValueChanged<bool>? onExpansionChanged;

  /// Only consulted when [isExpanded] is null.
  final bool initiallyExpanded;

  final bool enabled;
  final EdgeInsetsGeometry childrenPadding;

  @override
  State<AppExpandableListItem> createState() => _AppExpandableListItemState();
}

class _AppExpandableListItemState extends State<AppExpandableListItem> {
  late bool _isExpanded = widget.initiallyExpanded;

  bool get _expanded => widget.isExpanded ?? _isExpanded;

  void _toggle() {
    if (!widget.enabled) return;
    final bool next = !_expanded;
    if (widget.isExpanded == null) {
      setState(() => _isExpanded = next);
    }
    widget.onExpansionChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final Color titleColor =
        widget.enabled ? colors.textPrimary : colors.textDisabled;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Semantics(
          button: true,
          expanded: _expanded,
          enabled: widget.enabled,
          child: InkWell(
            onTap: widget.enabled ? _toggle : null,
            borderRadius: AppRadii.input,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.lg,
              ),
              child: Row(
                children: <Widget>[
                  if (widget.leading != null) ...<Widget>[
                    widget.leading!,
                    const SizedBox(width: AppSpacing.lg),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: typography.titleSmall
                              .copyWith(color: titleColor),
                        ),
                        if (widget.subtitle != null) ...<Widget>[
                          const SizedBox(height: AppSpacing.xxs),
                          Text(
                            widget.subtitle!,
                            style: typography.bodySmall
                                .copyWith(color: colors.textSecondary),
                          ),
                        ],
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: AppDuration.medium,
                    curve: AppCurves.standard,
                    child: Icon(
                      AppIcons.expand,
                      size: AppSizing.iconMedium,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: widget.childrenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: widget.children,
            ),
          ),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: AppDuration.medium,
          sizeCurve: AppCurves.standard,
        ),
      ],
    );
  }
}
