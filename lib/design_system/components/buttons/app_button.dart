import 'package:flutter/material.dart';

import '../../theme/theme.dart';
import '../common/app_pressable.dart';

/// How a button is weighted on the page.
enum AppButtonVariant {
  /// The teal key from the design. One per screen — the single most
  /// important action.
  primary,

  /// The purple key. A strong action that is not *the* action.
  secondary,

  /// A bordered, unfilled key. Safe secondary actions, "cancel".
  outlined,

  /// Label only. Low-weight actions and inline links.
  text,

  /// A filled key in the error colour. Destructive actions.
  danger,
}

/// The three button heights on the ramp.
enum AppButtonSize {
  /// 44pt — inside a dense row or a card footer.
  small,

  /// 56pt — the default.
  medium,

  /// 72pt — the hero call to action, as on the onboarding screen.
  large,
}

/// Noor's button.
///
/// Filled variants carry the design's solid slab and press into the page;
/// [AppButtonVariant.outlined] and [AppButtonVariant.text] are flat. All of
/// them handle hover, keyboard focus, press, disabled and loading, and take
/// every colour, size, radius and duration from the design tokens.
///
/// ```dart
/// AppButton.primary(
///   label: 'هيّا نبدأ',
///   size: AppButtonSize.large,
///   isFullWidth: true,
///   onPressed: () {},
/// );
/// ```
///
/// While [isLoading] is true the button keeps its exact size and swaps its
/// content for a spinner, so the layout never jumps.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
    this.maxWidth = AppSizing.maxButtonWidth,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  });

  /// The teal key from the design.
  const AppButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
    this.maxWidth = AppSizing.maxButtonWidth,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  }) : variant = AppButtonVariant.primary;

  /// The purple key.
  const AppButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
    this.maxWidth = AppSizing.maxButtonWidth,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  }) : variant = AppButtonVariant.secondary;

  /// A bordered, unfilled key.
  const AppButton.outlined({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
    this.maxWidth = AppSizing.maxButtonWidth,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  }) : variant = AppButtonVariant.outlined;

  /// Label only.
  const AppButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
    this.maxWidth = AppSizing.maxButtonWidth,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  }) : variant = AppButtonVariant.text;

  /// A filled key in the error colour, for destructive actions.
  const AppButton.danger({
    super.key,
    required this.label,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = true,
    this.isFullWidth = false,
    this.maxWidth = AppSizing.maxButtonWidth,
    this.focusNode,
    this.autofocus = false,
    this.semanticLabel,
  }) : variant = AppButtonVariant.danger;

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;

  /// Shown before the label, on the reading-start side.
  final IconData? icon;

  /// Shown after the label, on the reading-end side.
  final IconData? trailingIcon;

  /// Replaces the content with a spinner and blocks input.
  final bool isLoading;

  /// Disables the button independently of [onPressed].
  final bool isEnabled;

  /// Stretches the button to its parent's width, up to [maxWidth].
  final bool isFullWidth;

  /// The ceiling a full-width button stops growing at.
  ///
  /// `isFullWidth` means "fill the column", not "span the window": on a
  /// tablet a 1000pt key looks like a mistake and strands its label in the
  /// middle of an empty bar. Pass [double.infinity] to opt out.
  final double maxWidth;

  final FocusNode? focusNode;
  final bool autofocus;
  final String? semanticLabel;

  bool get _isInteractive => isEnabled && !isLoading && onPressed != null;

  double get _height => switch (size) {
    AppButtonSize.small => AppSizing.buttonHeightSmall,
    AppButtonSize.medium => AppSizing.buttonHeightMedium,
    AppButtonSize.large => AppSizing.buttonHeightLarge,
  };

  double get _horizontalPadding => switch (size) {
    AppButtonSize.small => AppSpacing.xl,
    AppButtonSize.medium => AppSpacing.xxl,
    AppButtonSize.large => AppSpacing.buttonHorizontal,
  };

  double get _iconSize => switch (size) {
    AppButtonSize.small => AppSizing.iconSmall,
    AppButtonSize.medium => AppSizing.iconMedium,
    AppButtonSize.large => AppSizing.iconLarge,
  };

  TextStyle _textStyle(AppTypography typography) => switch (size) {
    AppButtonSize.small => typography.labelLarge,
    AppButtonSize.medium => typography.labelLarge,
    AppButtonSize.large => typography.button,
  };

  _ButtonPalette _palette(AppColors colors) {
    if (!_isInteractive) {
      return switch (variant) {
        AppButtonVariant.text || AppButtonVariant.outlined => _ButtonPalette(
          foreground: colors.textDisabled,
        ),
        _ => _ButtonPalette(
          background: colors.disabled,
          foreground: colors.onDisabled,
        ),
      };
    }
    return switch (variant) {
      AppButtonVariant.primary => _ButtonPalette(
        background: colors.primary,
        foreground: colors.onPrimary,
        slab: colors.primaryShadow,
      ),
      AppButtonVariant.secondary => _ButtonPalette(
        background: colors.secondary,
        foreground: colors.onSecondary,
        slab: colors.secondaryShadow,
      ),
      AppButtonVariant.danger => _ButtonPalette(
        background: colors.error,
        foreground: colors.onError,
        slab: colors.onErrorContainer,
      ),
      AppButtonVariant.outlined => _ButtonPalette(
        foreground: colors.primaryStrong,
        border: colors.borderStrong,
      ),
      AppButtonVariant.text => _ButtonPalette(foreground: colors.textLink),
    };
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final _ButtonPalette palette = _palette(colors);
    final TextStyle textStyle = _textStyle(
      context.typography,
    ).copyWith(color: palette.foreground);

    final Widget content = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (icon != null) ...<Widget>[
          Icon(icon, size: _iconSize, color: palette.foreground),
          const SizedBox(width: AppSpacing.inlineGap),
        ],
        Flexible(
          child: Text(
            label,
            style: textStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailingIcon != null) ...<Widget>[
          const SizedBox(width: AppSpacing.inlineGap),
          Icon(trailingIcon, size: _iconSize, color: palette.foreground),
        ],
      ],
    );

    final Widget button = AppPressable(
      onPressed: _isInteractive ? onPressed : null,
      enabled: _isInteractive,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel ?? label,
      color: palette.background,
      shadowColor: palette.slab,
      borderRadius: AppRadii.button,
      border: palette.border == null
          ? null
          : Border.all(
              color: palette.border!,
              width: AppSizing.borderWidthThick,
            ),
      child: SizedBox(
        height: _height,
        width: isFullWidth ? double.infinity : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
          child: Center(
            child: isLoading
                ? SizedBox.square(
                    dimension: _iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: AppSizing.borderWidthThick,
                      color: palette.foreground,
                    ),
                  )
                : content,
          ),
        ),
      ),
    );

    if (!isFullWidth || !maxWidth.isFinite) {
      return button;
    }

    return Align(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: button,
      ),
    );
  }
}

/// The resolved colours for one button variant in one state.
@immutable
class _ButtonPalette {
  const _ButtonPalette({
    this.background,
    required this.foreground,
    this.slab,
    this.border,
  });

  final Color? background;
  final Color foreground;
  final Color? slab;
  final Color? border;
}
