import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import 'app_text_field.dart';

/// A search input.
///
/// Composes [AppTextField] and adds the two behaviours that make it a search
/// box: a leading magnifier, and a clear button that appears only once there
/// is something to clear.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    this.controller,
    this.hint,
    this.onChanged,
    this.onSubmitted,
    this.onCleared,
    this.enabled = true,
    this.autofocus = false,
    this.focusNode,
    this.clearTooltip = 'Clear search',
  });

  final TextEditingController? controller;

  /// Placeholder. Defaults to nothing — pass a localised string.
  final String? hint;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Called after the field is emptied by the clear button.
  final VoidCallback? onCleared;

  final bool enabled;
  final bool autofocus;
  final FocusNode? focusNode;

  /// Accessibility label for the clear button.
  final String clearTooltip;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  TextEditingController? _ownedController;
  bool _hasText = false;

  TextEditingController get _controller =>
      widget.controller ?? (_ownedController ??= TextEditingController());

  @override
  void initState() {
    super.initState();
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _ownedController?.dispose();
    super.dispose();
  }

  void _handleTextChange() {
    final bool hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
    }
  }

  void _clear() {
    _controller.clear();
    widget.onChanged?.call('');
    widget.onCleared?.call();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: _controller,
      hint: widget.hint,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      leadingIcon: AppIcons.search,
      trailingIcon: _hasText ? AppIcons.closeCircle : null,
      onTrailingIconPressed: _hasText ? _clear : null,
      trailingIconTooltip: widget.clearTooltip,
    );
  }
}
