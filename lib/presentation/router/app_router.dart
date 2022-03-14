import 'package:bloc_fluttery/presentation/screens/home_screen.dart';
import 'package:bloc_fluttery/presentation/screens/second_screen.dart';
import 'package:bloc_fluttery/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(
            title: 'Home screen',
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (context) => const SecondScreen(
            title: 'Second screen',
            color: Colors.redAccent,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (context) => const ThirdScreen(
            title: 'Third screen',
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }
  }
}
