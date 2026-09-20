import 'package:flutter/material.dart';

import '../../design_system.dart';
import '../gallery_scaffold.dart';

/// Buttons, inputs, selection controls and chips, in every state.
class ControlsSection extends StatefulWidget {
  const ControlsSection({super.key});

  @override
  State<ControlsSection> createState() => _ControlsSectionState();
}

class _ControlsSectionState extends State<ControlsSection> {
  bool _checkbox = true;
  bool? _tristate;
  bool _switch = true;
  String? _radio = 'a';
  String _segment = 'letters';
  String? _dropdown;
  bool _filterSelected = true;
  final List<String> _tags = <String>['فتحة', 'ضمة', 'كسرة'];

  @override
  Widget build(BuildContext context) {
    return AppContentContainer(
      width: AppContentWidth.wide,
      padding: EdgeInsets.zero,
      child: ListView(
        padding: context.screenInsets,
        children: <Widget>[
          GallerySection(
            title: 'Buttons',
            description:
                'Filled variants carry the solid slab and press into the page. '
                'Tab to one to see the focus ring.',
            children: <Widget>[
              GalleryRow(
                label: 'Variants',
                children: <Widget>[
                  AppButton.primary(label: 'أساسي', onPressed: () {}),
                  AppButton.secondary(label: 'ثانوي', onPressed: () {}),
                  AppButton.outlined(label: 'محدد', onPressed: () {}),
                  AppButton.text(label: 'نصي', onPressed: () {}),
                  AppButton.danger(label: 'حذف', onPressed: () {}),
                ],
              ),
              GalleryRow(
                label: 'Sizes',
                children: <Widget>[
                  AppButton.primary(
                    label: 'صغير',
                    size: AppButtonSize.small,
                    onPressed: () {},
                  ),
                  AppButton.primary(label: 'متوسط', onPressed: () {}),
                  AppButton.primary(
                    label: 'هيّا نبدأ',
                    size: AppButtonSize.large,
                    onPressed: () {},
                  ),
                ],
              ),
              GalleryRow(
                label: 'With icons',
                children: <Widget>[
                  AppButton.primary(
                    label: 'استمع',
                    icon: AppIcons.volumeOn,
                    onPressed: () {},
                  ),
                  AppButton.outlined(
                    label: 'التالي',
                    trailingIcon: AppIcons.forward,
                    onPressed: () {},
                  ),
                ],
              ),
              GalleryRow(
                label: 'States',
                children: <Widget>[
                  const AppButton.primary(label: 'معطل'),
                  const AppButton.primary(label: 'تحميل', isLoading: true),
                  const AppButton.outlined(label: 'معطل'),
                  const AppButton.text(label: 'معطل'),
                ],
              ),
              GalleryRow(
                label: 'Full width',
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: AppButton.primary(
                      label: 'هيّا نبدأ',
                      size: AppButtonSize.large,
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              GalleryRow(
                label: 'Icon buttons and FAB',
                children: <Widget>[
                  AppIconButton(
                    icon: AppIcons.play,
                    tooltip: 'Play',
                    onPressed: () {},
                  ),
                  AppIconButton(
                    icon: AppIcons.star,
                    tooltip: 'Favourite',
                    variant: AppIconButtonVariant.tonal,
                    onPressed: () {},
                  ),
                  AppIconButton(
                    icon: AppIcons.microphone,
                    tooltip: 'Record',
                    variant: AppIconButtonVariant.filled,
                    onPressed: () {},
                  ),
                  const AppIconButton(icon: AppIcons.play, tooltip: 'Disabled'),
                  AppFab(icon: AppIcons.add, tooltip: 'Add', onPressed: () {}),
                  AppFab(
                    icon: AppIcons.add,
                    tooltip: 'Add lesson',
                    label: 'درس جديد',
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
          GallerySection(
            title: 'Text fields',
            children: <Widget>[
              const AppTextField(
                label: 'اسم الطفل',
                hint: 'أدخل الاسم',
                supportingText: 'كما تريد أن يظهر في التقارير',
                isRequired: true,
              ),
              const AppTextField(
                label: 'محدد',
                hint: 'حقل بحدود',
                variant: AppTextFieldVariant.outlined,
              ),
              const AppTextField(
                label: 'خطأ',
                initialValue: 'قيمة غير صالحة',
                errorText: 'هذا الحقل مطلوب',
              ),
              const AppTextField(
                label: 'معطل',
                initialValue: 'لا يمكن التعديل',
                enabled: false,
              ),
              const AppTextField(
                label: 'للقراءة فقط',
                initialValue: 'قيمة ثابتة',
                readOnly: true,
                leadingIcon: AppIcons.locked,
              ),
              const AppTextField.number(label: 'العمر', hint: '7'),
              const AppTextField.multiline(
                label: 'ملاحظات',
                hint: 'اكتب ملاحظاتك هنا',
              ),
              const AppPasswordField(label: 'كلمة المرور', hint: '••••••••'),
              const AppSearchField(hint: 'ابحث عن درس'),
            ],
          ),
          GallerySection(
            title: 'Selection',
            children: <Widget>[
              AppCheckbox(
                value: _checkbox,
                label: 'تفعيل الصوت',
                supportingText: 'تشغيل نطق الحرف تلقائيًا',
                onChanged: (bool? v) => setState(() => _checkbox = v ?? false),
              ),
              AppCheckbox(
                value: _tristate,
                isTristate: true,
                label: 'حالة غير محددة',
                onChanged: (bool? v) => setState(() => _tristate = v),
              ),
              const AppCheckbox(value: false, onChanged: null, label: 'معطل'),
              const AppCheckbox(
                value: false,
                onChanged: null,
                label: 'خطأ',
                isError: true,
                supportingText: 'يجب الموافقة للمتابعة',
              ),
              AppRadioGroup<String>(
                value: _radio,
                onChanged: (String? v) => setState(() => _radio = v),
                options: const <AppRadioOption<String>>[
                  AppRadioOption<String>(
                    value: 'a',
                    label: 'مستوى المبتدئ',
                    supportingText: 'الحروف المفردة',
                  ),
                  AppRadioOption<String>(value: 'b', label: 'مستوى المتوسط'),
                  AppRadioOption<String>(
                    value: 'c',
                    label: 'معطل',
                    enabled: false,
                  ),
                ],
              ),
              AppSwitch(
                value: _switch,
                label: 'الوضع الليلي',
                supportingText: 'يتبع إعدادات النظام',
                onChanged: (bool v) => setState(() => _switch = v),
              ),
              const AppSwitch(value: false, onChanged: null, label: 'معطل'),
              AppSegmentedControl<String>(
                value: _segment,
                onChanged: (String v) => setState(() => _segment = v),
                segments: const <AppSegment<String>>[
                  AppSegment<String>(value: 'letters', label: 'الحروف'),
                  AppSegment<String>(value: 'harakat', label: 'الحركات'),
                  AppSegment<String>(value: 'words', label: 'الكلمات'),
                ],
              ),
              AppDropdown<String>(
                label: 'المستوى',
                hint: 'اختر مستوى',
                value: _dropdown,
                onChanged: (String? v) => setState(() => _dropdown = v),
                items: const <AppDropdownItem<String>>[
                  AppDropdownItem<String>(value: '1', label: 'المستوى الأول'),
                  AppDropdownItem<String>(value: '2', label: 'المستوى الثاني'),
                  AppDropdownItem<String>(
                    value: '3',
                    label: 'المستوى الثالث (مقفل)',
                    enabled: false,
                  ),
                ],
              ),
              const AppDropdown<String>(
                label: 'معطل',
                hint: 'غير متاح',
                value: null,
                items: <AppDropdownItem<String>>[],
                onChanged: null,
              ),
            ],
          ),
          GallerySection(
            title: 'Chips and tags',
            children: <Widget>[
              GalleryRow(
                label: 'Chips',
                children: <Widget>[
                  AppChip(label: 'إجراء', onPressed: () {}),
                  AppChip(
                    label: 'تصفية',
                    variant: AppChipVariant.filter,
                    isSelected: _filterSelected,
                    onPressed: () =>
                        setState(() => _filterSelected = !_filterSelected),
                  ),
                  const AppChip(label: 'معطل', enabled: false),
                  for (final String tag in _tags)
                    AppChip(
                      label: tag,
                      variant: AppChipVariant.input,
                      onDeleted: () => setState(() => _tags.remove(tag)),
                    ),
                ],
              ),
              GalleryRow(
                label: 'Tags',
                children: const <Widget>[
                  AppTag(label: 'محايد'),
                  AppTag(label: 'أساسي', tone: AppTagTone.primary),
                  AppTag(label: 'ثانوي', tone: AppTagTone.secondary),
                  AppTag(label: 'مكتمل', tone: AppTagTone.success),
                  AppTag(label: 'تحذير', tone: AppTagTone.warning),
                  AppTag(label: 'خطأ', tone: AppTagTone.error),
                  AppTag(label: 'معلومة', tone: AppTagTone.info),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
