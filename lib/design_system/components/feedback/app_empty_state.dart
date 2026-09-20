import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// The placeholder for "there is nothing here".
///
/// Centres an icon in a tinted plate — the same circular plate the character
/// stands on in the design — above a title, an optional line of explanation
/// and an optional action. Use it for an empty list, a search with no
/// results, and an error that the user can retry.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.description,
    this.action,
    this.iconColor,
    this.plateColor,
    this.illustration,
  });

  final IconData icon;
  final String title;
  final String? description;

  /// A control beneath the text — typically an `AppButton`.
  final Widget? action;

  final Color? iconColor;
  final Color? plateColor;

  /// Replaces the icon plate entirely, for a real illustration.
  final Widget? illustration;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizing.maxContentWidth),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxxl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              illustration ??
                  Container(
                    width: AppSizing.avatarLarge * 1.5,
                    height: AppSizing.avatarLarge * 1.5,
                    decoration: BoxDecoration(
                      color: plateColor ?? colors.accentSky,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: AppSizing.iconXLarge,
                      color: iconColor ?? colors.onAccentSky,
                    ),
                  ),
              const SizedBox(height: AppSpacing.sectionGap),
              Text(
                title,
                textAlign: TextAlign.center,
                style: typography.titleLarge.copyWith(color: colors.textPrimary),
              ),
              if (description != null) ...<Widget>[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: typography.bodyMedium
                      .copyWith(color: colors.textSecondary),
                ),
              ],
              if (action != null) ...<Widget>[
                const SizedBox(height: AppSpacing.sectionGap),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
