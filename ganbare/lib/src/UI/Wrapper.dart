import 'package:flutter/material.dart';
import 'package:ganbare/src/Models/user.dart';
import 'package:ganbare/src/UI/Home/Home_screen.dart';
import 'package:ganbare/src/UI/Login/Login_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserObj>(context);

    if (user == null) {
      return LoginScreen();
    } else {
      return HomeScreen();
    }
  }
}
