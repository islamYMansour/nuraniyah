import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_elevation.dart';
import 'app_radii.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

/// Builds Noor's [ThemeData] from the design tokens.
///
/// This is the only place where tokens are wired into Material. Screens never
/// construct a [ThemeData] and never read a raw value — they read
/// `context.colors`, `context.typography` and the `AppSpacing` / `AppRadii` /
/// `AppElevation` ramps.
abstract final class AppTheme {
  /// Light theme — the one the design specifies.
  static ThemeData get light => _build(AppColors.light, Brightness.light);

  /// Dark theme — the same tokens, inverted.
  static ThemeData get dark => _build(AppColors.dark, Brightness.dark);

  /// Legacy alias kept so existing entry points keep compiling.
  static ThemeData get lightTheme => light;

  /// Legacy alias kept so existing entry points keep compiling.
  static ThemeData get darkTheme => dark;

  static ThemeData _build(AppColors colors, Brightness brightness) {
    final AppTypography typography = AppTypography.standard;
    final TextTheme textTheme = typography.toTextTheme().apply(
          bodyColor: colors.textPrimary,
          displayColor: colors.textPrimary,
        );

    final ColorScheme colorScheme = ColorScheme(
      brightness: brightness,
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      primaryContainer: colors.primaryContainer,
      onPrimaryContainer: colors.onPrimaryContainer,
      secondary: colors.secondary,
      onSecondary: colors.onSecondary,
      secondaryContainer: colors.secondaryContainer,
      onSecondaryContainer: colors.onSecondaryContainer,
      tertiary: colors.accentSun,
      onTertiary: colors.onAccentSun,
      tertiaryContainer: colors.warningContainer,
      onTertiaryContainer: colors.onWarningContainer,
      error: colors.error,
      onError: colors.onError,
      errorContainer: colors.errorContainer,
      onErrorContainer: colors.onErrorContainer,
      surface: colors.surface,
      onSurface: colors.onSurface,
      surfaceContainerLowest: colors.surface,
      surfaceContainerLow: colors.background,
      surfaceContainer: colors.surfaceVariant,
      surfaceContainerHigh: colors.surfaceVariant,
      surfaceContainerHighest: colors.surfaceVariant,
      onSurfaceVariant: colors.onSurfaceVariant,
      inverseSurface: colors.surfaceInverse,
      onInverseSurface: colors.onSurfaceInverse,
      outline: colors.border,
      outlineVariant: colors.divider,
      shadow: colors.shadow,
      scrim: colors.scrim,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      textTheme: textTheme,
      fontFamily: AppFontFamily.primary,
      fontFamilyFallback: AppFontFamily.fallback,
      scaffoldBackgroundColor: colors.background,
      canvasColor: colors.background,
      splashFactory: InkSparkle.splashFactory,

      // Tokens travel with the theme, so they lerp on a light/dark switch.
      extensions: <ThemeExtension<dynamic>>[colors, typography],

      appBarTheme: AppBarTheme(
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level0,
        scrolledUnderElevation: AppElevation.level0,
        centerTitle: true,
        titleTextStyle: typography.titleLarge.copyWith(color: colors.textPrimary),
        iconTheme: IconThemeData(
          color: colors.textPrimary,
          size: AppSizing.iconMedium,
        ),
      ),

      iconTheme: IconThemeData(
        color: colors.textPrimary,
        size: AppSizing.iconMedium,
      ),

      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: AppSizing.borderWidth,
        space: AppSizing.borderWidth,
      ),

      cardTheme: CardThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: colors.shadow,
        elevation: AppElevation.level1,
        margin: EdgeInsets.zero,
        shape: AppShapes.card,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level3,
        shape: AppShapes.dialog,
        titleTextStyle: typography.headlineSmall.copyWith(color: colors.textPrimary),
        contentTextStyle: typography.bodyMedium.copyWith(color: colors.textSecondary),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: AppElevation.level3,
        shape: AppShapes.sheet,
        showDragHandle: true,
        dragHandleColor: colors.borderStrong,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          disabledBackgroundColor: colors.disabled,
          disabledForegroundColor: colors.onDisabled,
          shadowColor: colors.shadow,
          elevation: AppElevation.level0,
          minimumSize: const Size(0, AppSizing.buttonHeightMedium),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonHorizontal,
          ),
          shape: AppShapes.button,
          textStyle: typography.button,
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colors.secondary,
          foregroundColor: colors.onSecondary,
          disabledBackgroundColor: colors.disabled,
          disabledForegroundColor: colors.onDisabled,
          minimumSize: const Size(0, AppSizing.buttonHeightMedium),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonHorizontal,
          ),
          shape: AppShapes.button,
          textStyle: typography.button,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primaryStrong,
          disabledForegroundColor: colors.onDisabled,
          minimumSize: const Size(0, AppSizing.buttonHeightMedium),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.buttonHorizontal,
          ),
          side: BorderSide(
            color: colors.border,
            width: AppSizing.borderWidthThick,
          ),
          shape: AppShapes.button,
          textStyle: typography.button,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colors.textLink,
          disabledForegroundColor: colors.textDisabled,
          minimumSize: const Size(0, AppSizing.minTouchTarget),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          shape: AppShapes.button,
          textStyle: typography.labelMedium,
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          foregroundColor: colors.textPrimary,
          disabledForegroundColor: colors.textDisabled,
          minimumSize: const Size.square(AppSizing.minTouchTarget),
          iconSize: AppSizing.iconMedium,
        ),
      ),

      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: colors.surfaceVariant,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        hintStyle: typography.bodyMedium.copyWith(color: colors.textDisabled),
        labelStyle: typography.labelLarge.copyWith(color: colors.textSecondary),
        errorStyle: typography.caption.copyWith(color: colors.error),
        border: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: colors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: colors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(
            color: colors.borderFocus,
            width: AppSizing.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(
            color: colors.error,
            width: AppSizing.borderWidthThick,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: AppRadii.input,
          borderSide: BorderSide(color: colors.disabled),
        ),
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colors.surfaceVariant,
        selectedColor: colors.primaryContainer,
        disabledColor: colors.disabled,
        side: BorderSide(color: colors.border),
        shape: AppShapes.chip,
        labelStyle: typography.labelMedium.copyWith(color: colors.textPrimary),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        backgroundColor: colors.surfaceInverse,
        contentTextStyle:
            typography.bodyMedium.copyWith(color: colors.onSurfaceInverse),
        actionTextColor: colors.primary,
        behavior: SnackBarBehavior.floating,
        elevation: AppElevation.level2,
        shape: AppShapes.input,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colors.primary,
        linearTrackColor: colors.surfaceVariant,
        circularTrackColor: colors.surfaceVariant,
        linearMinHeight: AppSpacing.sm,
        borderRadius: AppRadii.indicator,
      ),

      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: colors.surfaceInverse,
          borderRadius: AppRadii.input,
        ),
        textStyle: typography.caption.copyWith(color: colors.onSurfaceInverse),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      ),

      listTileTheme: ListTileThemeData(
        iconColor: colors.textSecondary,
        textColor: colors.textPrimary,
        titleTextStyle: typography.titleMedium.copyWith(color: colors.textPrimary),
        subtitleTextStyle:
            typography.bodySmall.copyWith(color: colors.textSecondary),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        shape: AppShapes.card,
        minVerticalPadding: AppSpacing.md,
      ),
    );
  }
}
