import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import 'app_text_field.dart';

/// A password input with a reveal toggle.
///
/// Composes [AppTextField]; the only thing it owns is whether the value is
/// currently masked.
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.supportingText,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.isRequired = false,
    this.autofocus = false,
    this.focusNode,
    this.textInputAction,
    this.isNewPassword = false,
    this.showTooltip = 'Show password',
    this.hideTooltip = 'Hide password',
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? supportingText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;
  final bool isRequired;
  final bool autofocus;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  /// Set true on a sign-up form so the OS offers to generate and save a
  /// password rather than autofilling an existing one.
  final bool isNewPassword;

  /// Accessibility labels for the reveal toggle.
  final String showTooltip;
  final String hideTooltip;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: widget.controller,
      label: widget.label,
      hint: widget.hint,
      errorText: widget.errorText,
      supportingText: widget.supportingText,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      enabled: widget.enabled,
      isRequired: widget.isRequired,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      obscureText: _isObscured,
      keyboardType: TextInputType.visiblePassword,
      autofillHints: <String>[
        if (widget.isNewPassword)
          AutofillHints.newPassword
        else
          AutofillHints.password,
      ],
      leadingIcon: AppIcons.locked,
      trailingIcon: _isObscured ? AppIcons.visible : AppIcons.hidden,
      trailingIconTooltip:
          _isObscured ? widget.showTooltip : widget.hideTooltip,
      onTrailingIconPressed: () =>
          setState(() => _isObscured = !_isObscured),
    );
  }
}
