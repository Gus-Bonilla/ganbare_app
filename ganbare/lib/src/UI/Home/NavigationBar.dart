import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/Tabs/Habits.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ganbare/src/UI/Home/Tabs/Home/Home.dart';
import 'package:ganbare/src/UI/Home/Tabs/Water.dart';
import 'package:ganbare/src/UI/Home/Tabs/Workout/Workout.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBar createState() => _NavigationBar();
}

class _NavigationBar extends State<NavigationBar> {
  int _currentIndex = 0;
  final tabs = [
    new Home(),
    new Workout(),
    new Habits(),
    new Water(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/icons/041-home.svg',height: 40,width: 40,),
            label: 'home',
            backgroundColor: Colors.green[400],
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/icons/002-excercise.svg',height: 40,width: 40,),
            label: 'Ejercicio',
            backgroundColor: Colors.red[400],
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/icons/013-diet.svg',height: 40,width: 40,),
            label: 'Habitos',
            backgroundColor: Colors.indigo[400],
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/icons/006-drink water.svg',height: 40,width: 40,),
            label: 'Hidratacion',
            backgroundColor: Colors.blue[400],
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
