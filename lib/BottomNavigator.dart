import 'package:flutter/material.dart';
import 'package:project/CreateEvent.dart';
import 'package:project/HomaPage.dart';
import 'package:project/LoginPage.dart';
import 'package:project/RegisterPage.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatefulWidget {
  TabNavigator({required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  @override
  late Widget child;

  @override
  Widget build(BuildContext context) {
    if (widget.tabItem == "Page1")
      child = HomePage();
    else if (widget.tabItem == "Page2")
      child = CEventPage();
    else if (widget.tabItem == "Page3")
      child = LoginPage();
    return Navigator(
      key: widget.navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            fullscreenDialog: false, builder: (context) => child);
      },
    );
  }
}
