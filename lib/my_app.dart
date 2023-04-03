import 'package:aleteo_triqui/shared/theme/theme_config.dart';
import 'package:flutter/material.dart';

import 'shared/navigation/my_app_navigator_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    MyAppRouterDelegate routerDelegate = MyAppRouterDelegate();
    MyAppRouteInformationParser routeInformationParser =
        MyAppRouteInformationParser();

    return MaterialApp.router(
      title: 'Cat breeds',
      theme: lightTheme,
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
    );
  }
}
