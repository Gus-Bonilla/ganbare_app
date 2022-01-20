import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:ganbare/src/Models/user.dart';
import 'package:ganbare/src/Services/Notifications.dart';
import 'package:ganbare/src/Services/Sqflite/database_creator.dart';
import 'package:ganbare/src/Services/firebase_auth.dart';
import 'package:ganbare/src/UI/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ganbare/src/Shared/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<dynamic> todosEnMemoria;

void main() async {
  final int helloAlarmID = 0;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DatabaseCreator().initDatabase();

  await AndroidAlarmManager.initialize();

  runApp(MyApp());

  AndroidAlarmManager.periodic(
      const Duration(minutes: 1), helloAlarmID, checkHabits);
}

Future<bool> obtenerTodos() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.reload();
  todosEnMemoria = preferences.get("todosEnMemoria");

  if (todosEnMemoria == null)
    return false;
  else
    return true;
}

void checkHabits() async {
  print("Iniciando check");
  Notifications notifications = new Notifications(0);

  if (await obtenerTodos()) {
    String day2search = "";
    final DateTime now = DateTime.now();
    final TimeOfDay now2 = TimeOfDay.now();

    String formatearHora(String horaChafa) {
      return horaChafa.substring(10, 15);
    }

    switch (now.weekday) {
      case 1:
        day2search = "LUN";
        break;
      case 2:
        day2search = "MAR";
        break;
      case 3:
        day2search = "MIE";
        break;
      case 4:
        day2search = "JUE";
        break;
      case 5:
        day2search = "VIE";
        break;
      case 6:
        day2search = "SAB";
        break;
      case 7:
        day2search = "DOM";
        break;
    }

    for (String actividad in todosEnMemoria) {
      print(actividad);
      List<String> actividadSplitted = actividad.split("##");
      actividad = actividadSplitted[0];
      String diasActividad = actividadSplitted[1];
      String horaActividad = actividadSplitted[2];
      String ultimoDiaCompletado = actividadSplitted[3];
      String completado = actividadSplitted[4];

      if (diasActividad.contains(day2search) &&
          (completado == "NO" ||
              ultimoDiaCompletado != now.weekday.toString())) {
        String horaActual = formatearHora(now2.toString());

        if (horaActual == horaActividad) notifications.showNotification();
      }
    }
  } 
  print("## Check in background for hábits to notify, DONE. ##");

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserObj>.value(
      catchError: (_, __) => null,
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: PrimaryColor,
        ),
        home: Wrapper(),
      ),
    );
  }
}
