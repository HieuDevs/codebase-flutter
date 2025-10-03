import 'package:flutter/material.dart';
import 'package:lua/core/routes/routes.dart';
import 'package:lua/core/routes/props.dart';
import 'package:lua/features/splash/splash_page.dart';
import 'package:lua/features/home/presentation/home_page.dart';
import 'package:lua/features/auth/auth_page.dart';

enum NavigationTransition { slide, fade, scale, slideUp, slideDown, slideLeft, slideRight }

class AppNavigator {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext? get currentContext => navigatorKey.currentContext;

  static NavigatorState? get currentState => navigatorKey.currentState;

  static Future<T?> push<T extends Object?>(
    String routeName, {
    RouteProps? props,
    NavigationTransition transition = NavigationTransition.slide,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
  }) {
    return currentState!.push<T>(
      _createRoute(
        routeName,
        props: props,
        transition: transition,
        duration: duration,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    String routeName, {
    RouteProps? props,
    NavigationTransition transition = NavigationTransition.slide,
    Duration duration = const Duration(milliseconds: 300),
    TO? result,
  }) {
    return currentState!.pushReplacement<T, TO>(
      _createRoute(routeName, props: props, transition: transition, duration: duration),
      result: result,
    );
  }

  static Future<T?> pushAndRemoveUntil<T extends Object?>(
    String routeName, {
    RouteProps? props,
    NavigationTransition transition = NavigationTransition.fade,
    Duration duration = const Duration(milliseconds: 300),
    bool Function(Route<dynamic>)? predicate,
  }) {
    return currentState!.pushAndRemoveUntil<T>(
      _createRoute(routeName, props: props, transition: transition, duration: duration),
      predicate ?? (route) => false,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    if (currentState!.canPop()) {
      currentState!.pop<T>(result);
    }
  }

  static void popUntil(String routeName) {
    currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void popToRoot() {
    currentState!.popUntil((route) => route.isFirst);
  }

  static bool canPop() {
    return currentState?.canPop() ?? false;
  }

  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    RouteProps? props,
    NavigationTransition transition = NavigationTransition.slide,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return push<T>(routeName, props: props, transition: transition, duration: duration);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    RouteProps? props,
    NavigationTransition transition = NavigationTransition.slide,
    Duration duration = const Duration(milliseconds: 300),
    TO? result,
  }) {
    return pushReplacement<T, TO>(
      routeName,
      props: props,
      transition: transition,
      duration: duration,
    );
  }

  static Route<T> _createRoute<T>(
    String routeName, {
    RouteProps? props,
    NavigationTransition transition = NavigationTransition.slide,
    Duration duration = const Duration(milliseconds: 300),
    bool fullscreenDialog = false,
  }) {
    return PageRouteBuilder<T>(
      settings: RouteSettings(name: routeName, arguments: props),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _getPageWidget(routeName, props ?? NoProps());
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      fullscreenDialog: fullscreenDialog,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return _buildTransition(context, animation, secondaryAnimation, child, transition);
      },
    );
  }

  static Widget _getPageWidget(String routeName, RouteProps props) {
    switch (routeName) {
      case RouteNames.splash:
        return SplashPage(props: props);
      case RouteNames.home:
        return HomePage(props: props);
      case RouteNames.auth:
        return AuthPage(props: props);
      default:
        return SplashPage(props: props);
    }
  }

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    NavigationTransition transition,
  ) {
    switch (transition) {
      case NavigationTransition.slide:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );

      case NavigationTransition.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        );

      case NavigationTransition.slideDown:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
          child: child,
        );

      case NavigationTransition.slideLeft:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );

      case NavigationTransition.slideRight:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
          child: child,
        );

      case NavigationTransition.fade:
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );

      case NavigationTransition.scale:
        return ScaleTransition(
          scale: Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut)),
          child: FadeTransition(opacity: animation, child: child),
        );
    }
  }
}

class CustomPageRoute<T> extends PageRoute<T> {
  final Widget child;
  final NavigationTransition transition;
  final Duration duration;

  CustomPageRoute({
    required this.child,
    this.transition = NavigationTransition.slide,
    this.duration = const Duration(milliseconds: 300),
    super.settings,
  });

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return AppNavigator._buildTransition(context, animation, secondaryAnimation, child, transition);
  }
}
