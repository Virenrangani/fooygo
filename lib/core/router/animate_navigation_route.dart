import 'package:flutter/cupertino.dart';
import 'package:foodygo/feature/home/presentation/page/bottomnav.dart';

class AnimateNavigationRoute {

   static Route<void> cartRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => BottomNav(index:2,),
      transitionDuration: Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.linear;
        var scaleTween = Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve));

        var fadeTween = Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: curve));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            alignment: Alignment.topRight,
            child: child,
          ),
        );
      },
    );
  }

}