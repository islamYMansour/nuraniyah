import 'package:flutter/material.dart';

import '../../icons/app_icons.dart';
import '../../theme/theme.dart';

/// The avatar size ramp.
enum AppAvatarSize {
  /// 40pt — inside a list row.
  small,

  /// 56pt — the default.
  medium,

  /// 80pt — a profile header.
  large,

  /// 200pt — the character plate from the onboarding screen.
  medallion,
}

/// A circular representation of a person.
///
/// Falls back in order: [imageUrl], then [initials], then a person glyph — so
/// it always renders something, whatever the data is missing. A failed image
/// load falls back the same way rather than showing a broken box.
class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.imageProvider,
    this.initials,
    this.size = AppAvatarSize.medium,
    this.backgroundColor,
    this.foregroundColor,
    this.hasBorder = false,
    this.badge,
    this.semanticLabel,
  });

  /// A network image. Ignored when [imageProvider] is supplied.
  final String? imageUrl;

  /// Any image source — an asset, a file, memory bytes.
  final ImageProvider<Object>? imageProvider;

  /// One or two letters, shown when there is no image.
  final String? initials;

  final AppAvatarSize size;
  final Color? backgroundColor;
  final Color? foregroundColor;

  /// Draws a ring in the surface colour — for avatars overlapping each other
  /// or sitting on a busy ground.
  final bool hasBorder;

  /// A small widget pinned to the bottom-end corner: a status dot, a level
  /// badge.
  final Widget? badge;

  final String? semanticLabel;

  double get _diameter => switch (size) {
    AppAvatarSize.small => AppSizing.avatarSmall,
    AppAvatarSize.medium => AppSizing.avatarMedium,
    AppAvatarSize.large => AppSizing.avatarLarge,
    AppAvatarSize.medallion => AppSizing.medallion,
  };

  TextStyle _initialsStyle(AppTypography typography) => switch (size) {
    AppAvatarSize.small => typography.labelMedium,
    AppAvatarSize.medium => typography.titleMedium,
    AppAvatarSize.large => typography.headlineMedium,
    AppAvatarSize.medallion => typography.displayMedium,
  };

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color background = backgroundColor ?? colors.accentSky;
    final Color foreground = foregroundColor ?? colors.onAccentSky;

    final ImageProvider<Object>? image =
        imageProvider ?? (imageUrl != null ? NetworkImage(imageUrl!) : null);

    Widget avatar = Container(
      width: _diameter,
      height: _diameter,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
        border: hasBorder
            ? Border.all(
                color: colors.surface,
                width: AppSizing.borderWidthThick,
              )
            : null,
        image: image == null
            ? null
            : DecorationImage(
                image: image,
                fit: BoxFit.cover,
                // A failed load leaves the fallback beneath showing.
                onError: (Object error, StackTrace? stack) {},
              ),
      ),
      alignment: Alignment.center,
      child: image != null
          ? null
          : (initials != null && initials!.isNotEmpty
                ? Text(
                    initials!,
                    style: _initialsStyle(
                      context.typography,
                    ).copyWith(color: foreground),
                  )
                : Icon(
                    AppIcons.user,
                    size: _diameter * 0.5,
                    color: foreground,
                  )),
    );

    if (badge != null) {
      avatar = Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          avatar,
          PositionedDirectional(bottom: 0, end: 0, child: badge!),
        ],
      );
    }

    return Semantics(
      image: image != null,
      label: semanticLabel,
      child: ExcludeSemantics(child: avatar),
    );
  }
}
