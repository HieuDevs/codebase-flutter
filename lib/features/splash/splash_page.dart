import 'package:codebase/core/isolates/isolate_background_sound.dart';
import 'package:codebase/core/routes/app_navigator.dart';
import 'package:codebase/core/routes/props.dart';
import 'package:codebase/core/routes/routes.dart';
import 'package:codebase/shared/resources/assets.dart';
import 'package:codebase/shared/resources/gap.dart';
import 'package:codebase/shared/resources/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SplashPage extends HookWidget {
  final RouteProps props;
  const SplashPage({super.key, required this.props});

  void navigateToHome() {
    AppNavigator.pushReplacementNamed(RouteNames.home, transition: NavigationTransition.scale);
  }

  @override
  Widget build(BuildContext context) {
    final logoController = useAnimationController(duration: const Duration(milliseconds: 1500));
    final textController = useAnimationController(duration: const Duration(milliseconds: 1000));

    final logoAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: logoController, curve: Curves.elasticOut)),
    );

    final textAnimation = useAnimation(
      Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: textController, curve: Curves.easeInOut)),
    );

    useEffect(() {
      Future<void> startSplashSequence() async {
        await logoController.forward();
        await Future<void>.delayed(const Duration(milliseconds: 300));
        await textController.forward();
        await Future<void>.delayed(const Duration(milliseconds: 500));
        navigateToHome();
      }

      startSplashSequence();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: logoAnimation,
              child: Container(
                width: AppValues.s100,
                height: AppValues.s100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppValues.s10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: AppValues.s20,
                      offset: const Offset(0, AppValues.s10),
                    ),
                  ],
                ),
                child: Image.asset(AppAssets.imageLogo, width: AppValues.s60, height: AppValues.s60),
              ),
            ),
            const SizedBox(height: AppGap.s32),
            Opacity(
              opacity: textAnimation,
              child: Column(
                children: [
                  Text(
                    'Codebase',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: AppGap.s8),
                  Text(
                    'Your Flutter App',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white.withValues(alpha: 0.8)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppGap.s80),
            Opacity(
              opacity: textAnimation,
              child: SizedBox(
                width: AppValues.s40,
                height: AppValues.s40,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white.withValues(alpha: 0.7)),
                  strokeWidth: AppValues.s3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
