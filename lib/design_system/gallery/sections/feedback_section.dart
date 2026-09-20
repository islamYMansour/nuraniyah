import 'package:flutter/material.dart';

import '../../design_system.dart';
import '../gallery_scaffold.dart';

/// Messages, snack bars, dialogs, sheets, empty and loading states.
class FeedbackSection extends StatefulWidget {
  const FeedbackSection({super.key});

  @override
  State<FeedbackSection> createState() => _FeedbackSectionState();
}

class _FeedbackSectionState extends State<FeedbackSection> {
  double _progress = 0.6;
  String _lastAnswer = '—';

  @override
  Widget build(BuildContext context) {
    final AppColors c = context.colors;

    return ListView(
      padding: AppSpacing.screenInsets,
      children: <Widget>[
        GallerySection(
          title: 'Inline messages',
          description:
              'The icon is decorative — the text carries the meaning, so '
              'colour is never the only signal.',
          children: <Widget>[
            const AppMessage.success(
              title: 'أحسنت!',
              message: 'أكملت الدرس بنجاح.',
            ),
            const AppMessage.warning(message: 'لم تتدرب منذ ثلاثة أيام.'),
            AppMessage.error(
              title: 'تعذّر الحفظ',
              message: 'تحقق من اتصالك بالإنترنت.',
              action: AppButton.text(
                label: 'إعادة المحاولة',
                size: AppButtonSize.small,
                onPressed: () {},
              ),
            ),
            AppMessage(
              message: 'يمكنك الاستماع للحرف بالضغط على أيقونة الصوت.',
              onDismissed: () {},
            ),
          ],
        ),
        GallerySection(
          title: 'Snack bars',
          children: <Widget>[
            GalleryRow(
              label: 'Tones',
              children: <Widget>[
                AppButton.outlined(
                  label: 'محايد',
                  size: AppButtonSize.small,
                  onPressed: () =>
                      AppSnackbar.show(context, message: 'تم الحفظ'),
                ),
                AppButton.outlined(
                  label: 'نجاح',
                  size: AppButtonSize.small,
                  onPressed: () => AppSnackbar.showSuccess(
                    context,
                    message: 'أحسنت! إجابة صحيحة',
                  ),
                ),
                AppButton.outlined(
                  label: 'تحذير',
                  size: AppButtonSize.small,
                  onPressed: () =>
                      AppSnackbar.showWarning(context, message: 'انتبه للحركة'),
                ),
                AppButton.outlined(
                  label: 'خطأ',
                  size: AppButtonSize.small,
                  onPressed: () => AppSnackbar.showError(
                    context,
                    message: 'حدث خطأ',
                    actionLabel: 'إعادة',
                    onActionPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Dialogs and sheets',
          description: 'Last answer: $_lastAnswer',
          children: <Widget>[
            GalleryRow(
              label: 'Show',
              children: <Widget>[
                AppButton.outlined(
                  label: 'تنبيه',
                  size: AppButtonSize.small,
                  onPressed: () => AppDialogs.alert(
                    context,
                    title: 'أحسنت!',
                    message: 'لقد أكملت جميع حروف المستوى الأول.',
                    confirmLabel: 'تمام',
                    icon: AppIcons.trophy,
                  ),
                ),
                AppButton.outlined(
                  label: 'تأكيد',
                  size: AppButtonSize.small,
                  onPressed: () async {
                    final bool? answer = await AppDialogs.confirm(
                      context,
                      title: 'إعادة الدرس؟',
                      message: 'سيتم فقدان تقدمك الحالي في هذا الدرس.',
                      confirmLabel: 'إعادة',
                      cancelLabel: 'إلغاء',
                    );
                    if (!mounted) return;
                    setState(() => _lastAnswer = '$answer');
                  },
                ),
                AppButton.outlined(
                  label: 'حذف',
                  size: AppButtonSize.small,
                  onPressed: () async {
                    final bool? answer = await AppDialogs.confirm(
                      context,
                      title: 'حذف الملف الشخصي؟',
                      message: 'لا يمكن التراجع عن هذا الإجراء.',
                      confirmLabel: 'حذف',
                      cancelLabel: 'إلغاء',
                      icon: AppIcons.delete,
                      isDestructive: true,
                    );
                    if (!mounted) return;
                    setState(() => _lastAnswer = '$answer');
                  },
                ),
                AppButton.outlined(
                  label: 'ورقة سفلية',
                  size: AppButtonSize.small,
                  onPressed: () => AppBottomSheets.show<void>(
                    context,
                    builder: (BuildContext sheetContext) => AppBottomSheet(
                      title: 'اختر مستوى',
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          for (int i = 1; i <= 3; i++)
                            AppListItem(
                              title: 'المستوى $i',
                              showChevron: true,
                              onTap: () => Navigator.of(sheetContext).pop(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        GallerySection(
          title: 'Progress and loading',
          children: <Widget>[
            GalleryRow(
              label: 'Indicators',
              children: const <Widget>[
                AppProgressIndicator(),
                AppProgressIndicator(value: 0.35),
                AppProgressIndicator(size: AppSizing.iconMedium),
              ],
            ),
            AppProgressBar(value: _progress),
            Slider(
              value: _progress,
              activeColor: c.primary,
              onChanged: (double v) => setState(() => _progress = v),
            ),
            const AppProgressBar(value: null),
          ],
        ),
        GallerySection(
          title: 'Skeletons',
          description:
              'Shaped like the content that is loading, so nothing jumps. '
              'Honours "reduce motion".',
          children: <Widget>[
            Row(
              children: <Widget>[
                const AppSkeleton.circle(size: AppSizing.avatarMedium),
                const SizedBox(width: AppSpacing.lg),
                const Expanded(child: AppSkeletonParagraph()),
              ],
            ),
            const AppSkeleton(height: AppSizing.avatarLarge),
          ],
        ),
        GallerySection(
          title: 'Empty and loading states',
          children: <Widget>[
            AppCard(
              variant: AppCardVariant.outlined,
              child: AppEmptyState(
                icon: AppIcons.noResults,
                title: 'لا توجد نتائج',
                description: 'جرّب البحث بكلمة أخرى.',
                action: AppButton.primary(
                  label: 'مسح البحث',
                  size: AppButtonSize.small,
                  onPressed: () {},
                ),
              ),
            ),
            const AppCard(
              variant: AppCardVariant.outlined,
              child: SizedBox(
                height: 160,
                child: AppLoadingState(message: 'جارٍ التحميل…'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
