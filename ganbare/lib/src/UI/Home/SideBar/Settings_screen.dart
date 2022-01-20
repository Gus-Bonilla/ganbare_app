import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/SideBar/Drawer.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: MyDrawer(),
      body: new Container(
        child: Center(
          child: Text('Settings Screen'),
        ),
      ),
    );
  }
}
