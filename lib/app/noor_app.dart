import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../design_system/design_system.dart';
import '../features/splash/presentation/splash_screen.dart';

/// The root of the Noor app.
///
/// Owns the theme, the locale and the very first thing the user sees. Screens
/// live under `lib/features/<feature>/presentation/`; when a feature grows a
/// data layer, `data/` and `domain/` sit beside `presentation/` in the same
/// folder.
class NoorApp extends StatefulWidget {
  const NoorApp({super.key});

  @override
  State<NoorApp> createState() => _NoorAppState();
}

class _NoorAppState extends State<NoorApp> {
  bool _isSplashComplete = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نُور',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      // Scales type with the window size class, so a tablet does not get
      // phone-sized text. Everything else that adapts does so from the widget
      // tree and needs no wiring.
      builder: AppTheme.responsiveBuilder,

      // Noor is Arabic-first. Pinning the locale rather than following the
      // device keeps the app in Arabic — and therefore right-to-left — on a
      // phone set to any language, which is what the design assumes. The
      // delegates give Material's own widgets their Arabic strings.
      locale: const Locale('ar'),
      supportedLocales: const <Locale>[Locale('ar'), Locale('en')],
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      home: AnimatedSwitcher(
        duration: AppDuration.slow,
        switchInCurve: AppCurves.enter,
        switchOutCurve: AppCurves.exit,
        child: _isSplashComplete
            ? const _PlaceholderHome()
            : SplashScreen(
                onComplete: () => setState(() => _isSplashComplete = true),
              ),
      ),
    );
  }
}

/// Temporary scaffolding: what the splash hands off to until the welcome
/// screen from the design is built. Delete this class then.
class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: const SafeArea(
        child: AppEmptyState(
          icon: AppIcons.lesson,
          title: 'نُور',
          description: 'الشاشة التالية قيد الإنشاء.',
        ),
      ),
    );
  }
}
