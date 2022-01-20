import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Home_screen.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineCompleted.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineRest.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineStart.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineWithRepetitions.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Rutine/RutineWithTimer.dart';

class Routerer {

  static const String homeRoute = '/';
  static const String rutineStartRoute = '/rutinestart';
  static const String rutineTimerRoute = '/rutinetimer';
  static const String rutineRepetitionsRoute = '/rutinerepetitions';
  static const String rutineRestRoute = '/rutinesrest';
  static const String rutineCompletedRoute = '/rutinecompleted';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case rutineStartRoute:
        return MaterialPageRoute(builder: (_) => RutineStart());
      case rutineTimerRoute:
        return MaterialPageRoute(builder: (_) => RutineWithTimer());
      case rutineRepetitionsRoute:
        return MaterialPageRoute(builder: (_) => RutineWithRepetitions());
      case rutineRestRoute:
        return MaterialPageRoute(builder: (_) => RutineRest());
      case rutineCompletedRoute:
        return MaterialPageRoute(builder: (_) => RutineCompleted());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
