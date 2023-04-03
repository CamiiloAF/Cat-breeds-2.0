import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/entities/entity_bloc.dart';
import '../../shared/navigation/my_app_navigator_provider.dart';

class NavigatorBloc extends BlocModule {

  NavigatorBloc(final PageManager pageManager, [final Widget? homePage]) {
    _pageManager = pageManager;
    if (homePage != null) {
      setHomePage(homePage);
    }
  }

  static String name = 'blocNavigator';
  late PageManager _pageManager;

  void back() {
    _pageManager.back();
  }

  String _title = '';

  String get title => _title;

  int get historyPageLength => _pageManager.historyPagesCount;

  void setTitle(final String title) {
    _title = title;
    _pageManager.setPageTitle(title);
  }

  void update() {
    _pageManager.update();
  }

  void pushPage(final String routeName, final Widget widget,
      [final Object? arguments]) {
    _pageManager.push(routeName, widget, arguments);
  }

  void pushAndReplacement(
    final String routeName,
    final Widget widget, [
    final Object? arguments,
  ]) {
    _pageManager.pushAndReplacement(routeName, widget, arguments);
  }

  void pushNamedAndReplacement(final String routeName,
      [final Object? arguments]) {
    _pageManager.pushNamedAndReplacement(routeName, arguments);
  }

  void pushPageWidthTitle(
      final String title, final String routeName, final Widget widget) {
    _pageManager.setPageTitle(title);
    _pageManager.push(routeName, widget);
  }

  void setHomePage(final Widget widget, [final Object? arguments]) {
    _pageManager.setHomePage(widget, arguments);
  }

  void addPagesForDynamicLinksDirectory(final Map<String, Widget> mapOfPages) {
    mapOfPages.forEach((final key, final value) {
      _pageManager.registerPageToDirectory(routeName: key, widget: value);
    });
  }

  void removePageFromHistory(final String routeName) {
    _pageManager.removePageFromDirectory(routeName);
  }

  void pushNamed(final String routeName) {
    var finalRouteName = '';
    try {
      if (routeName[0] != '/') {
        finalRouteName = '/$routeName';
      }
      myPageManager.pushNamed(finalRouteName);
    } catch (e) {
      _sendToCrashlytics(e);
    }
  }

  List<String> get directoryOfRoutes => _pageManager.directoryOfPages;

  void clearAndGoHome() {
    _pageManager.clearHistory();
  }

  @override
  FutureOr<void> dispose() {
    _pageManager.dispose();
    return null;
  }

  void _sendToCrashlytics(final Object e) {}
}
