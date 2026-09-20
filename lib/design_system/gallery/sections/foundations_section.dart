import 'package:flutter/material.dart';

import '../../design_system.dart';
import '../gallery_scaffold.dart';

/// Colour, type, spacing, shape, depth and icons.
class FoundationsSection extends StatelessWidget {
  const FoundationsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors c = context.colors;

    return ListView(
      padding: AppSpacing.screenInsets,
      children: <Widget>[
        GallerySection(
          title: 'Colour',
          description:
              'Semantic tokens only. Every pair meets WCAG AA except where '
              'the token docs say otherwise.',
          children: <Widget>[
            _Swatches(
              label: 'Brand',
              swatches: <_Swatch>[
                _Swatch('primary', c.primary, c.onPrimary),
                _Swatch(
                  'primaryContainer',
                  c.primaryContainer,
                  c.onPrimaryContainer,
                ),
                _Swatch('secondary', c.secondary, c.onSecondary),
                _Swatch(
                  'secondaryContainer',
                  c.secondaryContainer,
                  c.onSecondaryContainer,
                ),
              ],
            ),
            _Swatches(
              label: 'Surfaces',
              swatches: <_Swatch>[
                _Swatch('background', c.background, c.onBackground),
                _Swatch('surface', c.surface, c.onSurface),
                _Swatch('surfaceVariant', c.surfaceVariant, c.onSurfaceVariant),
                _Swatch('surfaceInverse', c.surfaceInverse, c.onSurfaceInverse),
              ],
            ),
            _Swatches(
              label: 'Status',
              swatches: <_Swatch>[
                _Swatch('success', c.success, c.onSuccess),
                _Swatch('warning', c.warning, c.onWarning),
                _Swatch('error', c.error, c.onError),
                _Swatch('info', c.info, c.onInfo),
              ],
            ),
            _Swatches(
              label: 'Accents from the design',
              swatches: <_Swatch>[
                _Swatch('accentSky', c.accentSky, c.onAccentSky),
                _Swatch('accentSun', c.accentSun, c.onAccentSun),
                _Swatch('accentCoral', c.accentCoral, c.onAccentCoral),
              ],
            ),
            _Swatches(
              label: 'Text and lines',
              swatches: <_Swatch>[
                _Swatch('textPrimary', c.textPrimary, c.background),
                _Swatch('textSecondary', c.textSecondary, c.background),
                _Swatch('textDisabled', c.textDisabled, c.background),
                _Swatch('textLink', c.textLink, c.background),
                _Swatch('border', c.border, c.textPrimary),
                _Swatch('divider', c.divider, c.textPrimary),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Typography',
          description: 'Arabic-first: zero tracking, generous line height.',
          children: <Widget>[
            _TypeRow('wordmark 56/800', context.typography.wordmark, 'نُور'),
            _TypeRow(
              'displayLarge 56/700',
              context.typography.displayLarge,
              'أ ب ت',
            ),
            _TypeRow(
              'displaySmall 36/700',
              context.typography.displaySmall,
              'الحروف',
            ),
            _TypeRow(
              'headlineLarge 32/700',
              context.typography.headlineLarge,
              'عنوان الشاشة',
            ),
            _TypeRow(
              'headlineSmall 24/600',
              context.typography.headlineSmall,
              'عنوان فرعي',
            ),
            _TypeRow(
              'titleLarge 22/600',
              context.typography.titleLarge,
              'عنوان بطاقة',
            ),
            _TypeRow(
              'titleSmall 18/600',
              context.typography.titleSmall,
              'عنوان صف',
            ),
            _TypeRow(
              'bodyLarge 18/400',
              context.typography.bodyLarge,
              'تعلّم الحروف مع القاعدة النورانية',
            ),
            _TypeRow(
              'bodyMedium 16/400',
              context.typography.bodyMedium,
              'نص أساسي للقراءة داخل التطبيق',
            ),
            _TypeRow(
              'bodySmall 14/400',
              context.typography.bodySmall,
              'نص ثانوي ومساعد',
            ),
            _TypeRow(
              'labelMedium 14/600',
              context.typography.labelMedium,
              'تسجيل الدخول',
            ),
            _TypeRow('caption 12/400', context.typography.caption, 'حاشية'),
            _TypeRow('button 22/700', context.typography.button, 'هيّا نبدأ'),
          ],
        ),
        GallerySection(
          title: 'Spacing',
          description: 'A 4pt ramp.',
          children: <Widget>[
            for (final (String name, double value) in <(String, double)>[
              ('xs', AppSpacing.xs),
              ('sm', AppSpacing.sm),
              ('md', AppSpacing.md),
              ('lg', AppSpacing.lg),
              ('xl', AppSpacing.xl),
              ('xxl', AppSpacing.xxl),
              ('xxxl', AppSpacing.xxxl),
              ('x4', AppSpacing.x4),
              ('x5', AppSpacing.x5),
              ('x6', AppSpacing.x6),
            ])
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 56,
                    child: Text(
                      name,
                      style: context.typography.caption.copyWith(
                        color: c.textSecondary,
                      ),
                    ),
                  ),
                  Container(
                    width: value,
                    height: AppSpacing.md,
                    decoration: BoxDecoration(
                      color: c.primary,
                      borderRadius: AppRadii.indicator,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '${value.toStringAsFixed(0)}pt',
                    style: context.typography.caption.copyWith(
                      color: c.textDisabled,
                    ),
                  ),
                ],
              ),
          ],
        ),
        GallerySection(
          title: 'Shape',
          children: <Widget>[
            GalleryRow(
              label: 'Radius ramp',
              children: <Widget>[
                for (final (String name, double value) in <(String, double)>[
                  ('xs 8', AppRadius.xs),
                  ('sm 12', AppRadius.sm),
                  ('md 16', AppRadius.md),
                  ('lg 20', AppRadius.lg),
                  ('xl 24', AppRadius.xl),
                  ('xxl 32', AppRadius.xxl),
                  ('pill', AppRadius.pill),
                ])
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        width: AppSizing.avatarMedium,
                        height: AppSizing.avatarMedium,
                        decoration: BoxDecoration(
                          color: c.primaryContainer,
                          borderRadius: BorderRadius.circular(value),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        name,
                        style: context.typography.caption.copyWith(
                          color: c.textSecondary,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Elevation',
          description:
              'Solid depth for anything pressable; soft depth for passive '
              'surfaces.',
          children: <Widget>[
            GalleryRow(
              label: 'Depth',
              crossAxisAlignment: WrapCrossAlignment.start,
              children: <Widget>[
                _DepthChip(
                  label: 'solid',
                  shadow: AppElevation.solid(c.primaryShadow),
                  color: c.primary,
                ),
                _DepthChip(
                  label: 'card',
                  shadow: AppElevation.card(c.shadow),
                  color: c.surface,
                ),
                _DepthChip(
                  label: 'raised',
                  shadow: AppElevation.raised(c.shadow),
                  color: c.surface,
                ),
                _DepthChip(
                  label: 'overlay',
                  shadow: AppElevation.overlay(c.shadow),
                  color: c.surface,
                ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Icons',
          description:
              'Material Icons, rounded. Arrows and chevrons mirror under RTL '
              '— flip the direction toggle above to check.',
          children: <Widget>[
            GalleryRow(
              label: 'Navigation and arrows',
              children: <Widget>[
                for (final IconData icon in <IconData>[
                  AppIcons.back,
                  AppIcons.forward,
                  AppIcons.chevronForward,
                  AppIcons.expand,
                  AppIcons.home,
                  AppIcons.menu,
                  AppIcons.close,
                ])
                  Icon(icon, color: c.textSecondary),
              ],
            ),
            GalleryRow(
              label: 'Education and media',
              children: <Widget>[
                for (final IconData icon in <IconData>[
                  AppIcons.book,
                  AppIcons.lesson,
                  AppIcons.star,
                  AppIcons.trophy,
                  AppIcons.streak,
                  AppIcons.play,
                  AppIcons.microphone,
                  AppIcons.volumeOn,
                ])
                  Icon(icon, color: c.secondary),
              ],
            ),
            GalleryRow(
              label: 'Status',
              children: <Widget>[
                Icon(AppIcons.success, color: c.success),
                Icon(AppIcons.warning, color: c.warning),
                Icon(AppIcons.error, color: c.error),
                Icon(AppIcons.info, color: c.info),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _Swatch {
  const _Swatch(this.name, this.color, this.onColor);
  final String name;
  final Color color;
  final Color onColor;
}

class _Swatches extends StatelessWidget {
  const _Swatches({required this.label, required this.swatches});

  final String label;
  final List<_Swatch> swatches;

  @override
  Widget build(BuildContext context) {
    return GalleryRow(
      label: label,
      children: <Widget>[
        for (final _Swatch swatch in swatches)
          Container(
            width: 148,
            height: AppSizing.avatarLarge,
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: swatch.color,
              borderRadius: AppRadii.input,
              border: Border.all(color: context.colors.border),
            ),
            alignment: AlignmentDirectional.bottomStart,
            child: Text(
              swatch.name,
              style: context.typography.labelSmall.copyWith(
                color: swatch.onColor,
              ),
            ),
          ),
      ],
    );
  }
}

class _TypeRow extends StatelessWidget {
  const _TypeRow(this.label, this.style, this.sample);

  final String label;
  final TextStyle style;
  final String sample;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: context.typography.caption.copyWith(
            color: context.colors.textDisabled,
          ),
        ),
        Text(sample, style: style.copyWith(color: context.colors.textPrimary)),
      ],
    );
  }
}

class _DepthChip extends StatelessWidget {
  const _DepthChip({
    required this.label,
    required this.shadow,
    required this.color,
  });

  final String label;
  final List<BoxShadow> shadow;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: AppSizing.avatarLarge,
            height: AppSizing.avatarMedium,
            decoration: BoxDecoration(
              color: color,
              borderRadius: AppRadii.card,
              boxShadow: shadow,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: context.typography.caption.copyWith(
              color: context.colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
