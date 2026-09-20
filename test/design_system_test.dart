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

  group('breakpoints', () {
    test('window size classes fall on the Material boundaries', () {
      expect(AppBreakpoint.fromWidth(320), AppBreakpoint.compact);
      expect(AppBreakpoint.fromWidth(599.9), AppBreakpoint.compact);
      expect(AppBreakpoint.fromWidth(600), AppBreakpoint.medium);
      expect(AppBreakpoint.fromWidth(839.9), AppBreakpoint.medium);
      expect(AppBreakpoint.fromWidth(840), AppBreakpoint.expanded);
      expect(AppBreakpoint.fromWidth(1199.9), AppBreakpoint.expanded);
      expect(AppBreakpoint.fromWidth(1200), AppBreakpoint.large);
    });

    test('real devices land where they should', () {
      // iPhone 16 portrait, iPad mini portrait, iPad 11" landscape,
      // iPad Pro 12.9" landscape.
      expect(AppBreakpoint.fromWidth(402), AppBreakpoint.compact);
      expect(AppBreakpoint.fromWidth(744), AppBreakpoint.medium);
      expect(AppBreakpoint.fromWidth(1194), AppBreakpoint.expanded);
      expect(AppBreakpoint.fromWidth(1366), AppBreakpoint.large);
    });

    test('gutters and columns grow monotonically', () {
      double padding = -1;
      int columns = -1;
      for (final AppBreakpoint bp in AppBreakpoint.values) {
        expect(bp.screenPadding, greaterThan(padding));
        expect(bp.gridColumns, greaterThan(columns));
        padding = bp.screenPadding;
        columns = bp.gridColumns;
      }
    });

    test('a class with no value of its own falls back to the narrower one', () {
      String pick(AppBreakpoint bp) =>
          AppResponsive.valueFor<String>(bp, compact: 'c', expanded: 'e');
      expect(pick(AppBreakpoint.compact), 'c');
      expect(pick(AppBreakpoint.medium), 'c', reason: 'falls back to compact');
      expect(pick(AppBreakpoint.expanded), 'e');
      expect(pick(AppBreakpoint.large), 'e', reason: 'falls back to expanded');
    });

    test('scaledBy scales sizes and leaves heights alone', () {
      final AppTypography base = AppTypography.standard;
      final AppTypography big = base.scaledBy(1.1);
      expect(
        big.bodyMedium.fontSize,
        closeTo(base.bodyMedium.fontSize! * 1.1, 0.001),
      );
      expect(big.bodyMedium.height, base.bodyMedium.height);
      expect(identical(base.scaledBy(1), base), isTrue);
    });
  });

  group('tablet layout', () {
    Future<void> pumpAt(WidgetTester tester, Size size, Widget child) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(body: child),
        ),
      );
      await tester.pump(const Duration(milliseconds: 400));
    }

    Widget navigation() => AppAdaptiveNavigation(
      currentIndex: 0,
      destinations: const <AppNavDestination>[
        AppNavDestination(icon: AppIcons.home, label: 'Home'),
        AppNavDestination(icon: AppIcons.book, label: 'Lessons'),
      ],
      onDestinationSelected: (int _) {},
      child: const SizedBox.expand(),
    );

    testWidgets('a phone gets the bottom bar', (WidgetTester tester) async {
      await pumpAt(tester, const Size(402, 874), navigation());
      expect(find.byType(AppBottomNav), findsOneWidget);
      expect(find.byType(AppNavigationRail), findsNothing);
    });

    testWidgets('a landscape tablet gets the rail', (
      WidgetTester tester,
    ) async {
      await pumpAt(tester, const Size(1194, 834), navigation());
      expect(find.byType(AppNavigationRail), findsOneWidget);
      expect(find.byType(AppBottomNav), findsNothing);
    });

    testWidgets('two-pane collapses on a phone and splits on a tablet', (
      WidgetTester tester,
    ) async {
      Widget pane() =>
          const AppTwoPane(pane: Text('list'), detail: Text('detail'));

      await pumpAt(tester, const Size(402, 874), pane());
      expect(find.text('detail'), findsOneWidget);
      expect(find.text('list'), findsNothing, reason: 'one pane on a phone');

      await pumpAt(tester, const Size(1194, 834), pane());
      expect(find.text('list'), findsOneWidget);
      expect(find.text('detail'), findsOneWidget);
    });

    testWidgets('the grid adds columns as the window grows', (
      WidgetTester tester,
    ) async {
      Widget grid() => AppAdaptiveGrid(
        children: List<Widget>.generate(
          8,
          (int i) => SizedBox(height: 40, child: Text('t$i')),
        ),
      );

      await pumpAt(tester, const Size(402, 874), grid());
      final double phoneTile = tester.getSize(find.text('t0').first).width;

      await pumpAt(tester, const Size(1194, 834), grid());
      final double tabletTile = tester.getSize(find.text('t0').first).width;

      // Four columns of a 1194pt window are each narrower than two of a
      // 402pt one only if the column count really changed.
      expect(tabletTile, lessThan(1194 / 2));
      expect(phoneTile, greaterThan(0));
    });

    testWidgets('a full-width button stops growing', (
      WidgetTester tester,
    ) async {
      await pumpAt(
        tester,
        const Size(1194, 834),
        AppButton.primary(
          label: 'هيّا نبدأ',
          isFullWidth: true,
          onPressed: () {},
        ),
      );
      // AppButton's outermost node is an Align that fills the column on
      // purpose, so that the capped button centres inside it. The face is
      // the AppPressable underneath — that is what must stop growing.
      final double face = tester.getSize(find.byType(AppPressable).first).width;
      expect(face, lessThanOrEqualTo(AppSizing.maxButtonWidth));
      expect(
        tester.getSize(find.byType(AppButton)).width,
        greaterThan(face),
        reason: 'the button should still be centred in the full column',
      );
    });

    testWidgets('the gallery renders on a tablet', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1366, 1024);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const MaterialApp(home: DesignSystemGallery()));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Layout'));
      await tester.pump(const Duration(milliseconds: 500));
      await tester.pump(const Duration(milliseconds: 500));
      expect(tester.takeException(), isNull);
    });
  });
}
