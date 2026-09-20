import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nuraniyah_app/design_system/design_system.dart';
import 'package:nuraniyah_app/design_system/gallery/gallery.dart';

void main() {
  group('theme', () {
    test('both themes build and carry the token extensions', () {
      for (final ThemeData theme in <ThemeData>[
        AppTheme.light,
        AppTheme.dark,
      ]) {
        expect(theme.extension<AppColors>(), isNotNull);
        expect(theme.extension<AppTypography>(), isNotNull);
      }
    });

    test('no text style carries positive tracking', () {
      // Arabic is cursive: positive letter spacing breaks the joins.
      final AppTypography t = AppTypography.standard;
      for (final TextStyle style in <TextStyle>[
        t.wordmark,
        t.displayLarge,
        t.headlineLarge,
        t.titleLarge,
        t.bodyLarge,
        t.bodyMedium,
        t.labelLarge,
        t.caption,
        t.button,
      ]) {
        expect(style.letterSpacing, 0, reason: 'tracking must stay at zero');
      }
    });

    test('body line height leaves room for harakat', () {
      expect(
        AppTypography.standard.bodyMedium.height,
        greaterThanOrEqualTo(1.7),
      );
    });
  });

  group('gallery', () {
    testWidgets('renders every component in both themes and directions', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      // AppSkeleton shimmers forever by design, so pumpAndSettle would never
      // return anywhere the Feedback tab is mounted. Drive fixed frames
      // instead — long enough to finish the tab and theme transitions.
      Future<void> settle() => tester.pump(const Duration(milliseconds: 500));

      await tester.pumpWidget(const MaterialApp(home: DesignSystemGallery()));
      await settle();
      expect(tester.takeException(), isNull);

      // Every tab, so each section's widgets are actually built.
      for (final String tab in <String>[
        'Controls',
        'Surfaces',
        'Feedback',
        'Foundations',
      ]) {
        await tester.tap(find.text(tab));
        await settle();
        await settle();
        expect(tester.takeException(), isNull, reason: 'while on $tab');
      }

      // Flip to the dark theme, then to LTR, rebuilding everything each time.
      await tester.tap(find.byTooltip('Switch to dark theme'));
      await settle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.byTooltip('Switch to LTR'));
      await settle();
      expect(tester.takeException(), isNull);
    });

    testWidgets('a primary button reports a press', (
      WidgetTester tester,
    ) async {
      int taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: AppButton.primary(
                label: 'هيّا نبدأ',
                onPressed: () => taps++,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();
      expect(taps, 1);
    });

    testWidgets('a disabled button does not', (WidgetTester tester) async {
      int taps = 0;
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: Center(
              child: AppButton.primary(
                label: 'معطل',
                isEnabled: false,
                onPressed: () => taps++,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      await tester.pumpAndSettle();
      expect(taps, 0);
    });
  });
}
