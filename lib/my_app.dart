import 'package:flutter/material.dart';

import 'shared/navigation/my_app_navigator_provider.dart';
import 'shared/theme/theme_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(final BuildContext context) {
    final routerDelegate = MyAppRouterDelegate();
    final routeInformationParser = MyAppRouteInformationParser();

    return MaterialApp.router(
      title: 'Cat breeds',
      theme: lightTheme,
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
    );
  }
}
