import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../design_system/design_system.dart';

/// Noor's splash screen.
///
/// The brand mark on the cream ground, assembled from the motifs the design
/// already establishes on the welcome screen: the pale sky medallion, the
/// purple "نُور" wordmark, and the two confetti dots.
///
/// The native launch window is painted the same cream (see
/// `android/.../launch_background.xml` and the iOS `LaunchBackground` colour
/// set), so there is no white flash between the OS handing over and this
/// screen drawing its first frame — the medallion simply appears on a ground
/// that was already there.
///
/// It owns no data and loads nothing. Firebase is already initialised before
/// `runApp`, so this is a brand moment on a timer, not a progress screen —
/// which is why it shows no spinner. [onComplete] fires once, after
/// [duration]; the caller decides what comes next.
class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.onComplete,
    this.duration = const Duration(milliseconds: 2200),
  });

  /// Called once, after [duration]. Null leaves the brand mark on screen.
  final VoidCallback? onComplete;

  /// Total time on screen, entrance animation included.
  final Duration duration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const Duration _entrance = Duration(milliseconds: 1200);

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _entrance,
  );

  Timer? _completeTimer;
  bool _hasStarted = false;

  late final Animation<double> _medallion = _curve(0, 0.45);
  late final Animation<double> _wordmark = _curve(0.2, 0.65);
  late final Animation<double> _sunDot = _curve(0.45, 0.8);
  late final Animation<double> _coralDot = _curve(0.55, 0.9);
  late final Animation<double> _subtitle = _curve(0.6, 1);

  Animation<double> _curve(double begin, double end) => CurvedAnimation(
    parent: _controller,
    curve: Interval(begin, end, curve: AppCurves.enter),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_hasStarted) {
      return;
    }
    _hasStarted = true;

    // "Reduce motion" means the brand still lands — it just does not travel.
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }

    _completeTimer = Timer(widget.duration, () {
      if (mounted) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _completeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTypography typography = context.typography;
    final bool isDark = context.isDarkTheme;

    // The plate grows on a tablet so the mark does not sit small in a large
    // window.
    final double medallion = AppResponsive.value<double>(
      context,
      compact: AppSizing.medallion,
      medium: AppSizing.medallionLarge,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: colors.background,
        systemNavigationBarIconBrightness: isDark
            ? Brightness.light
            : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: colors.background,
        body: Semantics(
          label: 'نُور — تعلّم الحروف مع القاعدة النورانية',
          child: ExcludeSemantics(
            child: Center(
              child: AppContentContainer(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _Mark(
                      size: medallion,
                      medallion: _medallion,
                      wordmark: _wordmark,
                      sunDot: _sunDot,
                      coralDot: _coralDot,
                      colors: colors,
                      typography: typography,
                    ),
                    SizedBox(height: context.sectionGap),
                    FadeTransition(
                      opacity: _subtitle,
                      child: Text(
                        // Hardcoded until the app grows an ARB-backed
                        // localisation layer; Noor is Arabic-first, so this is
                        // the source string, not a fallback.
                        'تعلّم الحروف مع القاعدة النورانية',
                        textAlign: TextAlign.center,
                        style: typography.bodyLarge.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The medallion, the wordmark sitting on it, and the two confetti dots.
class _Mark extends StatelessWidget {
  const _Mark({
    required this.size,
    required this.medallion,
    required this.wordmark,
    required this.sunDot,
    required this.coralDot,
    required this.colors,
    required this.typography,
  });

  final double size;
  final Animation<double> medallion;
  final Animation<double> wordmark;
  final Animation<double> sunDot;
  final Animation<double> coralDot;
  final AppColors colors;
  final AppTypography typography;

  @override
  Widget build(BuildContext context) {
    // Room around the plate for the dots, which sit just outside its edge as
    // they do in the design.
    final double box = size * 1.3;

    return SizedBox(
      width: box,
      height: box,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ScaleTransition(
            scale: Tween<double>(begin: 0.72, end: 1).animate(
              CurvedAnimation(parent: medallion, curve: AppCurves.springy),
            ),
            child: FadeTransition(
              opacity: medallion,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: colors.accentSky,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: wordmark,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.18),
                end: Offset.zero,
              ).animate(wordmark),
              child: Text(
                'نُور',
                style: typography.wordmark.copyWith(color: colors.secondary),
              ),
            ),
          ),
          // Alignment, not AlignmentDirectional: the confetti is decoration
          // pinned to the artwork, so it stays put rather than mirroring with
          // the text direction.
          _Dot(
            animation: sunDot,
            alignment: const Alignment(0.77, -0.51),
            diameter: AppSizing.dotMedium,
            color: colors.accentSun,
          ),
          _Dot(
            animation: coralDot,
            alignment: const Alignment(-0.86, -0.05),
            diameter: AppSizing.dotSmall,
            color: colors.accentCoral,
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.animation,
    required this.alignment,
    required this.diameter,
    required this.color,
  });

  final Animation<double> animation;
  final Alignment alignment;
  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ScaleTransition(
        scale: CurvedAnimation(parent: animation, curve: AppCurves.springy),
        child: FadeTransition(
          opacity: animation,
          child: Container(
            width: diameter,
            height: diameter,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
        ),
      ),
    );
  }
}
