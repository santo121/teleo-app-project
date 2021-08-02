import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;
  CustomPageRoute({@required this.child, @required this.direction})
      : super(
          transitionDuration: Duration(seconds: 0),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        child: child,
        position: Tween<Offset>(begin: getBiginOffcet(), end: Offset.zero)
            .animate(animation),
      );

  Offset getBiginOffcet() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.left:
        return Offset(1, 0);
      case AxisDirection.right:
        return Offset(-1, 0);
    }
  }
}
