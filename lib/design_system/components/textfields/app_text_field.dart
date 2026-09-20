import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/theme.dart';

/// How a text field is drawn.
enum AppTextFieldVariant {
  /// A soft tinted fill with no outline. The default — it sits calmly on
  /// Noor's cream ground.
  filled,

  /// A transparent field with a visible border.
  outlined,
}

/// Noor's text field.
///
/// One component covers every case in the design: plain text, numbers,
/// multiline, read-only, with or without leading and trailing icons. Search
/// and password are separate only because they add behaviour — see
/// [AppSearchField] and [AppPasswordField], both of which compose this.
///
/// Label and supporting text are rendered outside the input rather than as a
/// floating Material label, so their typography comes straight from the
/// tokens and Arabic ascenders are never clipped by an animating label.
///
/// ```dart
/// AppTextField(
///   label: 'اسم الطفل',
///   hint: 'أدخل الاسم',
///   supportingText: 'كما تريد أن يظهر في التقارير',
///   onChanged: (String value) {},
/// );
/// ```
///
/// Supply either a [controller] or an [initialValue], not both. When only
/// [initialValue] is given the field owns its controller and disposes it.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.errorText,
    this.supportingText,
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.trailingIconTooltip,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.isRequired = false,
    this.autofocus = false,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.focusNode,
    this.variant = AppTextFieldVariant.filled,
    this.textAlign = TextAlign.start,
    this.autofillHints,
  }) : assert(
          controller == null || initialValue == null,
          'Supply a controller or an initialValue, not both.',
        );

  /// A numeric field: digits only, numeric keyboard.
  const AppTextField.number({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.errorText,
    this.supportingText,
    this.leadingIcon,
    this.trailingIcon,
    this.onTrailingIconPressed,
    this.trailingIconTooltip,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.isRequired = false,
    this.autofocus = false,
    this.textInputAction,
    this.maxLength,
    this.focusNode,
    this.variant = AppTextFieldVariant.filled,
    this.textAlign = TextAlign.start,
  })  : obscureText = false,
        keyboardType = TextInputType.number,
        inputFormatters = const <TextInputFormatter>[],
        maxLines = 1,
        minLines = null,
        autofillHints = null,
        assert(
          controller == null || initialValue == null,
          'Supply a controller or an initialValue, not both.',
        );

  /// A field that grows to several lines.
  const AppTextField.multiline({
    super.key,
    this.controller,
    this.initialValue,
    this.label,
    this.hint,
    this.errorText,
    this.supportingText,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.readOnly = false,
    this.isRequired = false,
    this.autofocus = false,
    this.maxLength,
    this.focusNode,
    this.variant = AppTextFieldVariant.filled,
    this.textAlign = TextAlign.start,
    this.minLines = 3,
    this.maxLines = 6,
  })  : leadingIcon = null,
        trailingIcon = null,
        onTrailingIconPressed = null,
        trailingIconTooltip = null,
        obscureText = false,
        keyboardType = TextInputType.multiline,
        textInputAction = TextInputAction.newline,
        inputFormatters = null,
        autofillHints = null,
        assert(
          controller == null || initialValue == null,
          'Supply a controller or an initialValue, not both.',
        );

  final TextEditingController? controller;
  final String? initialValue;

  /// Shown above the field.
  final String? label;

  /// Placeholder shown while the field is empty.
  final String? hint;

  /// When non-null the field takes its error treatment and shows this text in
  /// place of [supportingText].
  final String? errorText;

  /// Hint shown beneath the field.
  final String? supportingText;

  final IconData? leadingIcon;
  final IconData? trailingIcon;

  /// Makes the trailing icon tappable.
  final VoidCallback? onTrailingIconPressed;

  /// Accessibility label for the trailing icon. Required by
  /// [onTrailingIconPressed] to be meaningful.
  final String? trailingIconTooltip;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final bool enabled;

  /// Shows the value but refuses edits, while staying focusable and
  /// selectable — unlike `enabled: false`, which greys the field out.
  final bool readOnly;

  final bool obscureText;

  /// Appends a marker to [label]. Presentational only — validation is the
  /// caller's job.
  final bool isRequired;

  final bool autofocus;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;
  final int? minLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final AppTextFieldVariant variant;
  final TextAlign textAlign;
  final Iterable<String>? autofillHints;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController? _ownedController;
  FocusNode? _ownedFocusNode;
  bool _isFocused = false;

  TextEditingController get _controller =>
      widget.controller ??
      (_ownedController ??= TextEditingController(text: widget.initialValue));

  FocusNode get _focusNode => widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _ownedFocusNode?.dispose();
    _ownedController?.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_isFocused != _focusNode.hasFocus) {
      setState(() => _isFocused = _focusNode.hasFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final bool hasError = widget.errorText != null;
    final bool isDisabled = !widget.enabled;

    final Color borderColor = switch (true) {
      _ when isDisabled => colors.disabled,
      _ when hasError => colors.error,
      _ when _isFocused => colors.borderFocus,
      _ => colors.border,
    };

    final Color fillColor = switch (true) {
      _ when isDisabled => colors.disabled,
      _ when widget.variant == AppTextFieldVariant.outlined =>
        Colors.transparent,
      _ => colors.surfaceVariant,
    };

    final Color contentColor =
        isDisabled ? colors.textDisabled : colors.textPrimary;

    final Color iconColor = switch (true) {
      _ when isDisabled => colors.textDisabled,
      _ when hasError => colors.error,
      _ when _isFocused => colors.primaryStrong,
      _ => colors.textSecondary,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          Text.rich(
            TextSpan(
              text: widget.label,
              children: widget.isRequired
                  ? <InlineSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(color: colors.error),
                      ),
                    ]
                  : null,
            ),
            style: typography.labelLarge.copyWith(
              color: isDisabled ? colors.textDisabled : colors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        AnimatedContainer(
          duration: AppDuration.fast,
          curve: AppCurves.standard,
          decoration: BoxDecoration(
            color: fillColor,
            borderRadius: AppRadii.input,
            border: Border.all(
              color: borderColor,
              width: _isFocused || hasError
                  ? AppSizing.borderWidthThick
                  : AppSizing.borderWidth,
            ),
          ),
          child: Row(
            crossAxisAlignment: widget.maxLines > 1
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.leadingIcon != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: AppSpacing.lg,
                    top: AppSpacing.lg,
                    bottom: AppSpacing.lg,
                  ),
                  child: Icon(
                    widget.leadingIcon,
                    size: AppSizing.iconMedium,
                    color: iconColor,
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  readOnly: widget.readOnly,
                  obscureText: widget.obscureText,
                  autofocus: widget.autofocus,
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  inputFormatters: widget.inputFormatters,
                  maxLines: widget.maxLines,
                  minLines: widget.minLines,
                  maxLength: widget.maxLength,
                  onChanged: widget.onChanged,
                  onSubmitted: widget.onSubmitted,
                  textAlign: widget.textAlign,
                  autofillHints: widget.autofillHints,
                  cursorColor: colors.primary,
                  style: typography.bodyMedium.copyWith(color: contentColor),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: typography.bodyMedium
                        .copyWith(color: colors.textDisabled),
                    // The container above draws the fill, border and focus
                    // ring; the raw field contributes padding only.
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.lg,
                    ),
                  ),
                ),
              ),
              if (widget.trailingIcon != null)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: AppSpacing.sm,
                  ),
                  child: widget.onTrailingIconPressed == null
                      ? Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Icon(
                            widget.trailingIcon,
                            size: AppSizing.iconMedium,
                            color: iconColor,
                          ),
                        )
                      : IconButton(
                          onPressed: widget.enabled
                              ? widget.onTrailingIconPressed
                              : null,
                          icon: Icon(widget.trailingIcon),
                          iconSize: AppSizing.iconMedium,
                          color: iconColor,
                          tooltip: widget.trailingIconTooltip,
                          constraints: const BoxConstraints.tightFor(
                            width: AppSizing.minTouchTarget,
                            height: AppSizing.minTouchTarget,
                          ),
                        ),
                ),
            ],
          ),
        ),
        if (widget.errorText != null || widget.supportingText != null) ...<Widget>[
          const SizedBox(height: AppSpacing.sm),
          Text(
            widget.errorText ?? widget.supportingText!,
            style: typography.caption.copyWith(
              color: hasError
                  ? colors.error
                  : (isDisabled ? colors.textDisabled : colors.textSecondary),
            ),
          ),
        ],
      ],
    );
  }
}
