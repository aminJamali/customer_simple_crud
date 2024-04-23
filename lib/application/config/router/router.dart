import 'package:flutter/material.dart';
import 'package:mc_crud_test/main.dart';
import 'route_names.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(
          builder: (final context) => const MyHomePage(title: 'title'),
        );
      default:
        return MaterialPageRoute(
          builder: (final context) => const MyHomePage(title: 'title'),
        );
    }
  }
}
