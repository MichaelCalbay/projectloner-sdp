import 'package:flutter/material.dart';
import 'package:projectloner/matching/chat_screen.dart';
import 'package:projectloner/models/user_matches.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    debugPrint('This route: ${settings.name}');

    switch (settings.name) {
      case ChatScreen.routeName:
        return ChatScreen.route(match: settings.arguments as UserMatch);

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
