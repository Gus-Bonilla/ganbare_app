import 'package:flutter/material.dart';
import 'package:ganbare/src/UI/Home/NavigationBar.dart';
import 'package:ganbare/src/UI/Home/SideBar/Drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: MyDrawer(),
      body: Container(
        child: NavigationBar(),
      ),
    );
  }
}
