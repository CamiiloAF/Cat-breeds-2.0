import 'package:aleteo_triqui/services/theme_config.dart';
import 'package:flutter/material.dart';

import 'providers/my_app_navigator_provider.dart';

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
