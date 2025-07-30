import 'package:flutter/material.dart';

// navigation_service.dart: Uygulama genelinde navigation işlemlerini yönetmek için kullanılır.
// Global navigatorKey ile sayfa geçişleri yapılabilir.

enum TransitionType {
  fade,
  slideFromRight,
  slideFromLeft,
  slideFromTop,
  slideFromBottom,
  scale,
  rotation,
  none,
}

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;
  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic>? navigateToWidget(
    Widget page, {
    TransitionType transition = TransitionType.fade,
  }) {
    return navigatorKey.currentState?.push(_buildRoute(page, transition: transition));
  }

  Future<dynamic>? pushReplacementWidget(
    Widget page, {
    TransitionType transition = TransitionType.fade,
  }) {
    return navigatorKey.currentState?.pushReplacement(_buildRoute(page, transition: transition));
  }

  Future<dynamic>? pushAndRemoveUntilWidget(
    Widget page, {
    TransitionType transition = TransitionType.fade,
  }) {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      _buildRoute(page, transition: transition),
      (route) => false,
    );
  }

  Route _buildRoute(
    Widget page, {
    TransitionType transition = TransitionType.fade,
  }) {
    switch (transition) {
      case TransitionType.fade:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.slideFromRight:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.slideFromLeft:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.slideFromTop:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.slideFromBottom:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.scale:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(scale: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.rotation:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return RotationTransition(turns: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 400),
        );
      case TransitionType.none:
        return MaterialPageRoute(builder: (_) => page);
    }
  }

  void goBack() {
    return navigatorKey.currentState?.pop();
  }

  void popUntilRoot() {
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }
}
