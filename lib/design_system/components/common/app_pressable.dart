import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';

/// The interaction primitive every pressable surface in Noor is built from.
///
/// It renders Noor's signature depth — a solid, un-blurred slab of a darker
/// shade sitting beneath the face — and animates that slab to nothing on
/// press while the face travels down by the same distance, so the control
/// reads as a physical key being pushed into the page. The slab's height is
/// reserved in the layout, so nothing reflows while it animates.
///
/// It also carries the states that every interactive component owes the user:
/// hover, keyboard focus (with a visible ring), press and disabled, plus
/// Enter/Space activation and a semantics node. Buttons, cards, chips and
/// list rows all compose this rather than re-implementing any of it.
///
/// Pass `shadowColor: null` for a flat surface with no slab (text and
/// outlined buttons), which still gets every other state.
class AppPressable extends StatefulWidget {
  const AppPressable({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.color,
    this.shadowColor,
    this.shadowOffset = AppSizing.buttonShadowOffset,
    this.borderRadius = AppRadii.button,
    this.border,
    this.padding,
    this.enabled = true,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
    this.isSelected = false,
    this.mouseCursor,
  });

  /// The content of the surface.
  final Widget child;

  /// Tap handler. A null handler disables the surface.
  final VoidCallback? onPressed;

  /// Optional long-press handler.
  final VoidCallback? onLongPress;

  /// Fill of the face. Transparent when null.
  final Color? color;

  /// The solid slab beneath the face. Null means no slab — a flat surface.
  final Color? shadowColor;

  /// How far the slab sits below the face, and therefore how far the face
  /// travels on press.
  final double shadowOffset;

  final BorderRadius borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;

  /// Set false to disable independently of [onPressed].
  final bool enabled;

  final FocusNode? focusNode;
  final bool autofocus;

  /// Announced by screen readers in place of the child's own text.
  final String? semanticLabel;

  /// Reported to assistive technology as the selected state.
  final bool isSelected;

  final MouseCursor? mouseCursor;

  @override
  State<AppPressable> createState() => _AppPressableState();
}

class _AppPressableState extends State<AppPressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppDuration.instant,
  );

  bool _isHovered = false;
  bool _isFocused = false;

  bool get _isEnabled => widget.enabled && widget.onPressed != null;

  bool get _hasSlab => widget.shadowColor != null && widget.shadowOffset > 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setPressed(bool pressed) {
    if (!_isEnabled) return;
    if (pressed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  void _handlePressed() {
    if (!_isEnabled) return;
    HapticFeedback.lightImpact();
    widget.onPressed!.call();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double slab = _hasSlab ? widget.shadowOffset : 0;

    return Semantics(
      button: true,
      enabled: _isEnabled,
      selected: widget.isSelected ? true : null,
      label: widget.semanticLabel,
      child: FocusableActionDetector(
        enabled: _isEnabled,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        mouseCursor:
            widget.mouseCursor ??
            (_isEnabled ? SystemMouseCursors.click : SystemMouseCursors.basic),
        onShowHoverHighlight: (bool value) =>
            setState(() => _isHovered = value),
        onShowFocusHighlight: (bool value) =>
            setState(() => _isFocused = value),
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        actions: <Type, Action<Intent>>{
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              _handlePressed();
              return null;
            },
          ),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          onTap: _isEnabled ? _handlePressed : null,
          onLongPress: _isEnabled ? widget.onLongPress : null,
          child: Padding(
            // Reserve the slab so the control never changes its layout size.
            padding: EdgeInsets.only(bottom: slab),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                final double t = _controller.value;
                return Transform.translate(
                  offset: Offset(0, slab * t),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: widget.borderRadius,
                      border: _isFocused
                          ? Border.all(
                              color: colors.borderFocus,
                              width: AppSizing.focusRingWidth,
                            )
                          : widget.border,
                      boxShadow: _hasSlab
                          ? AppElevation.solid(
                              widget.shadowColor!,
                              offset: slab * (1 - t),
                            )
                          : null,
                    ),
                    child: child,
                  ),
                );
              },
              child: AnimatedOpacity(
                duration: AppDuration.fast,
                // A hover lift, on the platforms that have a pointer.
                opacity: _isHovered && _isEnabled ? 0.92 : 1,
                child: Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
