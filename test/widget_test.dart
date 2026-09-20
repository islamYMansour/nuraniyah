import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nuraniyah_app/app/noor_app.dart';
import 'package:nuraniyah_app/design_system/design_system.dart';
import 'package:nuraniyah_app/features/splash/presentation/splash_screen.dart';

void main() {
  testWidgets('the app opens on the splash screen, in Arabic and RTL', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NoorApp());
    await tester.pump();

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.text('نُور'), findsOneWidget);

    final BuildContext context = tester.element(find.byType(SplashScreen));
    expect(Localizations.localeOf(context).languageCode, 'ar');
    expect(Directionality.of(context), TextDirection.rtl);
  });

  testWidgets('the splash hands off once its duration is up', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const NoorApp());
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);

    // Past the splash duration, then past the cross-fade.
    await tester.pump(const Duration(milliseconds: 2400));
    await tester.pump(AppDuration.slow);
    await tester.pump(AppDuration.slow);

    expect(find.byType(SplashScreen), findsNothing);
  });
}
