import 'package:flutter/material.dart';

import '../../../app_config.dart';
import '../../../core/blocs/bloc_user_notifications.dart';
import '../../../core/blocs/navigator_bloc.dart';
import '../../breeds/presentation/pages/breeds_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final animationDuration = const Duration(milliseconds: 1500);
  late final AnimationController _controller = AnimationController(
    duration: animationDuration,
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _navigateToMainPage());

    blocCore.addBlocModule(
      UserNotificationsBloc.name,
      UserNotificationsBloc(context),
    );

    super.initState();
  }

  void _navigateToMainPage() {
    Future.delayed(animationDuration * 2, () {
      blocCore.getBlocModule<NavigatorBloc>(NavigatorBloc.name)
        ..pushAndReplacement('home', const BreedsPage())
        ..removePageFromHistory('/');
    });
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) =>
  //         const BreedsPage(),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(1.0, 0.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;
  //
  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //
  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.96),
      body: FadeTransition(
        opacity: _animation,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Catbreeds',
                style: theme.textTheme.displaySmall!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
            Image.asset(
              'assets/images/splash.jpg',
              fit: BoxFit.fitHeight,
            ),
          ],
        ),
      ),
    );
  }
}
