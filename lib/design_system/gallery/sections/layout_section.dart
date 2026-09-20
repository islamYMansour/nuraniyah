import 'package:flutter/material.dart';

import '../../design_system.dart';
import '../gallery_scaffold.dart';

/// Breakpoints, responsive spacing, and the layout components.
class LayoutSection extends StatefulWidget {
  const LayoutSection({super.key});

  @override
  State<LayoutSection> createState() => _LayoutSectionState();
}

class _LayoutSectionState extends State<LayoutSection> {
  int _navIndex = 0;
  int? _selectedLesson;

  static const List<AppNavDestination> _destinations = <AppNavDestination>[
    AppNavDestination(icon: AppIcons.home, label: 'الرئيسية'),
    AppNavDestination(icon: AppIcons.book, label: 'الدروس', badgeCount: 2),
    AppNavDestination(icon: AppIcons.trophy, label: 'الإنجازات'),
    AppNavDestination(icon: AppIcons.user, label: 'حسابي'),
  ];

  @override
  Widget build(BuildContext context) {
    final AppColors c = context.colors;
    final AppBreakpoint bp = context.breakpoint;
    final double width = MediaQuery.sizeOf(context).width;

    return ListView(
      padding: context.screenInsets,
      children: <Widget>[
        GallerySection(
          title: 'This window',
          description:
              'Resize the window, or rotate the device, and everything below '
              'reacts.',
          children: <Widget>[
            AppCard(
              variant: AppCardVariant.outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _Readout('width', '${width.toStringAsFixed(0)}pt'),
                  _Readout('breakpoint', bp.name),
                  _Readout(
                    'screenPadding',
                    '${bp.screenPadding.toStringAsFixed(0)}pt',
                  ),
                  _Readout(
                    'sectionGap',
                    '${bp.sectionGap.toStringAsFixed(0)}pt',
                  ),
                  _Readout('typeScale', '×${bp.typeScale}'),
                  _Readout('gridColumns', '${bp.gridColumns}'),
                  _Readout(
                    'contentMaxWidth',
                    bp.contentMaxWidth.isFinite
                        ? '${bp.contentMaxWidth.toStringAsFixed(0)}pt'
                        : 'unbounded',
                  ),
                ],
              ),
            ),
            GalleryRow(
              label: 'The ramp',
              children: <Widget>[
                for (final AppBreakpoint step in AppBreakpoint.values)
                  AppTag(
                    label: step.name,
                    tone: step == bp ? AppTagTone.primary : AppTagTone.neutral,
                  ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'AppAdaptiveGrid',
          description:
              'Column count follows the window — two on a phone, up to five. '
              'The grid Noor actually needs: letters and lessons.',
          children: <Widget>[
            AppAdaptiveGrid(
              tileAspectRatio: 1,
              children: <Widget>[
                for (final String letter in <String>[
                  'أ',
                  'ب',
                  'ت',
                  'ث',
                  'ج',
                  'ح',
                  'خ',
                  'د',
                ])
                  AppCard(
                    padding: EdgeInsets.zero,
                    onTap: () {},
                    child: Center(
                      child: Text(
                        letter,
                        style: context.typography.displaySmall.copyWith(
                          color: c.secondary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Adaptive navigation',
          description:
              'Bottom bar on a phone, rail on a landscape tablet. Same '
              'destinations, same callback — the arrangement is the '
              "component's problem.",
          children: <Widget>[
            _BreakpointPreview(
              label: 'compact — 400×720',
              width: 400,
              height: 720,
              child: _NavPreview(
                index: _navIndex,
                destinations: _destinations,
                onSelected: (int i) => setState(() => _navIndex = i),
              ),
            ),
            _BreakpointPreview(
              label: 'expanded — 1024×720',
              width: 1024,
              height: 720,
              child: _NavPreview(
                index: _navIndex,
                destinations: _destinations,
                onSelected: (int i) => setState(() => _navIndex = i),
              ),
            ),
          ],
        ),
        GallerySection(
          title: 'AppTwoPane',
          description:
              'One pane on a phone, list-and-detail on a landscape tablet. It '
              'never routes — the caller passes detail: null for "nothing '
              'selected".',
          children: <Widget>[
            _BreakpointPreview(
              label: 'compact — 400×560',
              width: 400,
              height: 560,
              child: _TwoPanePreview(
                selected: _selectedLesson,
                onSelected: (int? i) => setState(() => _selectedLesson = i),
              ),
            ),
            _BreakpointPreview(
              label: 'expanded — 1024×560',
              width: 1024,
              height: 560,
              child: _TwoPanePreview(
                selected: _selectedLesson,
                onSelected: (int? i) => setState(() => _selectedLesson = i),
              ),
            ),
          ],
        ),
        GallerySection(
          title: 'AppContentContainer',
          description:
              'Caps and centres a screen’s content. Everything in this '
              'gallery is already inside one.',
          children: <Widget>[
            AppCard(
              variant: AppCardVariant.outlined,
              padding: EdgeInsets.zero,
              child: AppContentContainer(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'تعلّم الحروف مع القاعدة النورانية. هذا النص محصور داخل '
                  'أقصى عرض مريح للقراءة، مهما اتسعت النافذة.',
                  style: context.typography.bodyMedium.copyWith(
                    color: c.textSecondary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Readout extends StatelessWidget {
  const _Readout(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: context.typography.caption.copyWith(
                color: context.colors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: context.typography.labelMedium.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders its child at a simulated window size, scaled down to fit.
///
/// Overriding the [MediaQuery] size is what makes the preview honest: the
/// child resolves its own breakpoint from the simulated width, so what you
/// see is exactly what that device would get.
class _BreakpointPreview extends StatelessWidget {
  const _BreakpointPreview({
    required this.label,
    required this.width,
    required this.height,
    required this.child,
  });

  final String label;
  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final AppColors c = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label,
          style: context.typography.labelSmall.copyWith(color: c.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: AppRadii.card,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppRadii.card,
              border: Border.all(color: c.border),
            ),
            child: AspectRatio(
              aspectRatio: width / height,
              child: FittedBox(
                child: SizedBox(
                  width: width,
                  height: height,
                  child: MediaQuery(
                    data: MediaQuery.of(
                      context,
                    ).copyWith(size: Size(width, height)),
                    child: child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavPreview extends StatelessWidget {
  const _NavPreview({
    required this.index,
    required this.destinations,
    required this.onSelected,
  });

  final int index;
  final List<AppNavDestination> destinations;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.background,
      child: AppAdaptiveNavigation(
        currentIndex: index,
        destinations: destinations,
        onDestinationSelected: onSelected,
        child: Center(
          child: Text(
            destinations[index].label,
            style: context.typography.headlineMedium.copyWith(
              color: context.colors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _TwoPanePreview extends StatelessWidget {
  const _TwoPanePreview({required this.selected, required this.onSelected});

  final int? selected;
  final ValueChanged<int?> onSelected;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.background,
      child: AppTwoPane(
        pane: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: <Widget>[
            const AppListSectionHeader(title: 'الدروس', count: 4),
            for (int i = 0; i < 4; i++)
              AppListItem(
                title: 'الدرس ${i + 1}',
                showChevron: true,
                isSelected: selected == i,
                onTap: () => onSelected(i),
              ),
          ],
        ),
        detail: selected == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!context.isWide)
                      AppButton.text(
                        label: 'رجوع',
                        icon: AppIcons.back,
                        size: AppButtonSize.small,
                        onPressed: () => onSelected(null),
                      ),
                    Text(
                      'الدرس ${selected! + 1}',
                      style: context.typography.headlineMedium.copyWith(
                        color: context.colors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
        placeholder: const AppEmptyState(
          icon: AppIcons.lesson,
          title: 'اختر درسًا',
          description: 'اختر درسًا من القائمة لعرض تفاصيله.',
        ),
      ),
    );
  }
}
