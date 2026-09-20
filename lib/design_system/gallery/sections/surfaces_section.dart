import 'package:flutter/material.dart';

import '../../design_system.dart';
import '../gallery_scaffold.dart';

/// Cards, surfaces, lists, avatars and badges.
class SurfacesSection extends StatefulWidget {
  const SurfacesSection({super.key});

  @override
  State<SurfacesSection> createState() => _SurfacesSectionState();
}

class _SurfacesSectionState extends State<SurfacesSection> {
  int _selectedRow = 0;

  @override
  Widget build(BuildContext context) {
    final AppColors c = context.colors;

    return ListView(
      padding: AppSpacing.screenInsets,
      children: <Widget>[
        GallerySection(
          title: 'Cards',
          description: 'Give a card an onTap and it becomes a real button.',
          children: <Widget>[
            AppCard(
              child: Text(
                'filled — the default on the cream ground',
                style: context.typography.bodyMedium,
              ),
            ),
            AppCard(
              variant: AppCardVariant.elevated,
              child: Text(
                'elevated — a soft shadow lifts it',
                style: context.typography.bodyMedium,
              ),
            ),
            AppCard(
              variant: AppCardVariant.outlined,
              child: Text(
                'outlined — a hairline border',
                style: context.typography.bodyMedium,
              ),
            ),
            AppCard(
              onTap: () {},
              child: Text(
                'tappable — press it',
                style: context.typography.bodyMedium,
              ),
            ),
            AppCard(
              isSelected: true,
              onTap: () {},
              child: Text(
                'selected',
                style: context.typography.bodyMedium,
              ),
            ),
          ],
        ),
        GallerySection(
          title: 'Surfaces and dividers',
          children: <Widget>[
            GalleryRow(
              label: 'Surface',
              children: <Widget>[
                AppSurface(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  color: c.accentSky,
                  child: Text(
                    'accentSky',
                    style: context.typography.labelMedium
                        .copyWith(color: c.onAccentSky),
                  ),
                ),
                AppSurface.circle(
                  size: AppSizing.avatarLarge,
                  color: c.accentSun,
                  child: Text(
                    'أ',
                    style: context.typography.headlineMedium
                        .copyWith(color: c.onAccentSun),
                  ),
                ),
              ],
            ),
            const AppDivider(spacing: AppSpacing.md),
            Row(
              children: <Widget>[
                Text('يمين', style: context.typography.bodySmall),
                const AppDivider.vertical(spacing: AppSpacing.md),
                Text('يسار', style: context.typography.bodySmall),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Lists',
          children: <Widget>[
            const AppListSectionHeader(title: 'الدروس', count: 3),
            for (int i = 0; i < 3; i++)
              AppListItem(
                title: 'الدرس ${i + 1}',
                subtitle: 'الحروف المفردة',
                leading: AppAvatar(
                  size: AppAvatarSize.small,
                  initials: '${i + 1}',
                  backgroundColor: c.primaryContainer,
                  foregroundColor: c.onPrimaryContainer,
                ),
                trailing: const AppTag(
                  label: 'مكتمل',
                  tone: AppTagTone.success,
                ),
                showChevron: true,
                isSelected: _selectedRow == i,
                onTap: () => setState(() => _selectedRow = i),
              ),
            const AppDivider(spacing: AppSpacing.md),
            AppExpandableListItem(
              title: 'ما هي القاعدة النورانية؟',
              subtitle: 'اضغط للتوسيع',
              leading: Icon(AppIcons.help, color: c.textSecondary),
              children: <Widget>[
                Text(
                  'طريقة لتعليم القراءة الصحيحة للحروف العربية والقرآن الكريم.',
                  style: context.typography.bodySmall
                      .copyWith(color: c.textSecondary),
                ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Avatars and badges',
          children: <Widget>[
            GalleryRow(
              label: 'Avatar sizes and fallbacks',
              children: <Widget>[
                const AppAvatar(size: AppAvatarSize.small, initials: 'نو'),
                const AppAvatar(initials: 'نو'),
                const AppAvatar(size: AppAvatarSize.large, initials: 'نو'),
                const AppAvatar(size: AppAvatarSize.large),
                AppAvatar(
                  size: AppAvatarSize.large,
                  initials: 'نو',
                  badge: Container(
                    width: AppSpacing.lg,
                    height: AppSpacing.lg,
                    decoration: BoxDecoration(
                      color: c.success,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: c.surface,
                        width: AppSizing.borderWidthThick,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            GalleryRow(
              label: 'Badges',
              children: <Widget>[
                AppBadge(
                  count: 3,
                  child: Icon(AppIcons.notification, color: c.textSecondary),
                ),
                AppBadge(
                  count: 128,
                  child: Icon(AppIcons.mail, color: c.textSecondary),
                ),
                AppBadge.dot(
                  child: Icon(AppIcons.chat, color: c.textSecondary),
                ),
                const AppBadge(count: 5),
                const AppBadge.dot(),
              ],
            ),
            GalleryRow(
              label: 'Tooltip',
              children: <Widget>[
                AppTooltip(
                  message: 'اضغط مطولًا لعرض التلميح',
                  child: Icon(AppIcons.info, color: c.info),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
