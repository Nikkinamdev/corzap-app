import 'package:flutter/material.dart';

class CustomNavigator {
  /// --- Core Navigation Functions ---

  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  static void push(
    BuildContext context,
    Widget page, {
    TransitionType transition = TransitionType.slideRight,
  }) {
    Navigator.push(context, _buildPageRoute(page, transition));
  }

  static void pushReplacement(
    BuildContext context,
    Widget page, {
    TransitionType transition = TransitionType.slideRight,
  }) {
    Navigator.pushReplacement(context, _buildPageRoute(page, transition));
  }

  static void removeUntil(
    BuildContext context,
    Widget page, {
    TransitionType transition = TransitionType.slideRight,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      _buildPageRoute(page, transition),
      (route) => false,
    );
  }

  /// --- Private Route Builder with Smooth Animations ---
  static PageRouteBuilder _buildPageRoute(
    Widget page,
    TransitionType transition,
  ) {
    switch (transition) {
      case TransitionType.slideLeft:
        return _slideTransition(page, const Offset(1, 0));
      case TransitionType.slideRight:
        return _slideTransition(page, const Offset(-1, 0));
      case TransitionType.slideTop:
        return _slideTransition(page, const Offset(0, 1));
      case TransitionType.slideBottom:
        return _slideTransition(page, const Offset(0, -1));
      case TransitionType.fade:
        return _fadeTransition(page);
      case TransitionType.scale:
        return _scaleTransition(page);
      case TransitionType.rotation:
        return _rotationTransition(page);
      case TransitionType.size:
        return _sizeTransition(page);
      case TransitionType.none:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration.zero,
        );
    }
  }

  /// --- Smooth Transition Helpers ---
  static PageRouteBuilder _slideTransition(Widget page, Offset begin) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          SlideTransition(
            position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          ),
    );
  }

  static PageRouteBuilder _fadeTransition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            ),
            child: child,
          ),
    );
  }

  static PageRouteBuilder _scaleTransition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          ),
    );
  }

  static PageRouteBuilder _rotationTransition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
            turns: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            ),
            child: child,
          ),
    );
  }

  static PageRouteBuilder _sizeTransition(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          Align(
            alignment: Alignment.center,
            child: SizeTransition(
              sizeFactor: CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
              child: child,
            ),
          ),
    );
  }
}

/// Available transition types
enum TransitionType {
  none,
  slideLeft,
  slideRight,
  slideTop,
  slideBottom,
  fade,
  scale,
  rotation,
  size,
}
