import 'package:lua/core/extensions/context.dart';
import 'package:lua/core/routes/app_navigator.dart';
import 'package:lua/core/routes/props.dart';
import 'package:lua/core/routes/routes.dart';
import 'package:lua/core/common/constants.dart';
import 'package:lua/core/providers/theme_provider.dart';
import 'package:lua/shared/resources/assets.dart';
import 'package:lua/shared/resources/gap.dart';
import 'package:lua/shared/resources/theme.dart';
import 'package:lua/shared/resources/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends HookConsumerWidget {
  final RouteProps props;
  const SplashPage({super.key, required this.props});

  void navigateToHome() {
    AppNavigator.pushReplacementNamed(RouteNames.home, transition: NavigationTransition.scale);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoController = useAnimationController(duration: const Duration(milliseconds: 1800));
    final textController = useAnimationController(duration: const Duration(milliseconds: 1200));
    final shimmerController = useAnimationController(duration: const Duration(milliseconds: 1800));
    final backgroundController = useAnimationController(
      duration: const Duration(milliseconds: 2500),
    );
    final pulseController = useAnimationController(duration: const Duration(milliseconds: 1500));

    final logoScale = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: logoController, curve: Curves.elasticOut)),
    );

    final textAnimation = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: textController, curve: Curves.easeInOut)),
    );

    final shimmerAnimation = useAnimation(
      Tween<double>(
        begin: -1.0,
        end: 2.0,
      ).animate(CurvedAnimation(parent: shimmerController, curve: Curves.linear)),
    );

    final backgroundAnimation = useAnimation(
      Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: backgroundController, curve: Curves.easeInOut)),
    );

    final pulseAnimation = useAnimation(
      Tween<double>(
        begin: 1.0,
        end: 1.1,
      ).animate(CurvedAnimation(parent: pulseController, curve: Curves.easeInOut)),
    );

    useEffect(() {
      Future<void> startSplashSequence() async {
        backgroundController.forward();
        await Future<void>.delayed(const Duration(milliseconds: 200));
        logoController.forward();
        await Future<void>.delayed(const Duration(milliseconds: 400));
        textController.forward();
        shimmerController.repeat();
        pulseController.repeat(reverse: true);
        await Future<void>.delayed(const Duration(milliseconds: 3000));
        navigateToHome();
      }

      startSplashSequence();
      return null;
    }, []);

    final isDark = ref.watch(isDarkModeProvider);

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark ? AppTheme.black900 : AppTheme.white,
              isDark
                  ? AppTheme.gray900.withValues(alpha: 0.95)
                  : AppTheme.gray10.withValues(alpha: backgroundAnimation),
              isDark
                  ? AppTheme.gray800.withValues(alpha: backgroundAnimation)
                  : AppTheme.gray20.withValues(alpha: backgroundAnimation * 0.9),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _ParticlesPainter(backgroundAnimation, isDark)),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: logoScale * pulseAnimation,
                    child: Stack(
                      children: [
                        Image.asset(
                          AppAssets.imageLogo,
                          width: AppValues.s100,
                          height: AppValues.s100,
                        ),
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppValues.s28),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppValues.s28),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppTheme.white.withValues(alpha: 0.2),
                                    AppTheme.white.withValues(alpha: 0.1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppGap.s32),
                  Transform.translate(
                    offset: Offset(0, 30 * (1 - textAnimation)),
                    child: Opacity(
                      opacity: textAnimation,
                      child: Column(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) {
                              return LinearGradient(
                                begin: Alignment(shimmerAnimation - 1, -0.5),
                                end: Alignment(shimmerAnimation, 0.5),
                                colors: [
                                  (isDark ? AppTheme.gray100 : AppTheme.gray900).withValues(
                                    alpha: 0.7,
                                  ),
                                  isDark ? AppTheme.white : AppTheme.black900,
                                  (isDark ? AppTheme.gray100 : AppTheme.gray900).withValues(
                                    alpha: 0.7,
                                  ),
                                ],
                              ).createShader(bounds);
                            },
                            child: Text(
                              AppConstants.appName,
                              style: context.getTextTheme.displayMedium?.copyWith(
                                color: AppTheme.white,
                                fontWeight: AppTheme.black,
                                letterSpacing: AppValues.s4,
                                height: AppValues.s1,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppGap.s12),
                          Text(
                            'Real life AI',
                            style: context.getTextTheme.headlineSmall?.copyWith(
                              color: isDark ? AppTheme.gray100 : AppTheme.gray900,
                              letterSpacing: AppValues.s3,
                              fontWeight: AppTheme.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppGap.s12),
                  Transform.translate(
                    offset: Offset(0, 20 * (1 - textAnimation)),
                    child: Opacity(
                      opacity: (textAnimation * pulseAnimation).clamp(0.0, 1.0),
                      child: Container(
                        width: AppValues.s60,
                        height: AppValues.s60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              (isDark ? AppTheme.gray800 : AppTheme.white).withValues(alpha: 0.7),
                              (isDark ? AppTheme.gray700 : AppTheme.gray20).withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(AppValues.s30),
                          border: Border.all(
                            color: (isDark ? AppTheme.gray600 : AppTheme.gray100).withValues(
                              alpha: 0.5,
                            ),
                            width: AppValues.s2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: (isDark ? AppTheme.white : AppTheme.gray900).withValues(
                                alpha: 0.08,
                              ),
                              blurRadius: AppValues.s12,
                              spreadRadius: 0.0,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(AppValues.s12),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isDark ? AppTheme.gray100 : AppTheme.gray900,
                            ),
                            strokeWidth: AppValues.s3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ParticlesPainter extends CustomPainter {
  final double animation;
  final bool isDark;

  _ParticlesPainter(this.animation, this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? AppTheme.white : AppTheme.gray900).withValues(alpha: 0.05 * animation)
      ..style = PaintingStyle.fill;

    for (int i = 0; i < 25; i++) {
      final x = (size.width / 25) * i + (animation * 60);
      final y = (size.height / 25) * i + (animation * 40);
      canvas.drawCircle(Offset(x % size.width, y % size.height), AppValues.s3, paint);
    }
  }

  @override
  bool shouldRepaint(_ParticlesPainter oldDelegate) => animation != oldDelegate.animation;
}
