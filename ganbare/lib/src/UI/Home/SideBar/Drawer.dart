import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ganbare/src/Services/firebase_auth.dart';
import 'package:ganbare/src/UI/Home/Home_screen.dart';
import 'package:ganbare/src/UI/Home/SideBar/Account_screen.dart';

class MyDrawer extends StatelessWidget {
  final Function onTap;
  final AuthService _auth = AuthService();

  MyDrawer({this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final CollectionReference coleccion =
        FirebaseFirestore.instance.collection('Users');
    final user = FirebaseAuth.instance.currentUser;
    return SizedBox(
      width: size.height * 0.38,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.green[200],
                    Colors.green[300],
                    Colors.green[300],
                    Colors.green[200],
                    Colors.green[200],
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    StreamBuilder(
                        stream: coleccion.doc(user.uid).snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return Container(
                              height: 50,
                              width: 50,
                              child: ClipOval(
                                child: (snapshot.data.data()['pic'] != null)
                                    ? Image.network(
                                        '${snapshot.data.data()['pic']}',
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/silueta.png'),
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    StreamBuilder(
                        stream: coleccion.doc(user.uid).snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            return Text(
                              '${snapshot.data.data()['name']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(
                      height: size.height * 0.001,
                    ),
                    FutureBuilder(
                      future: firebaseUsuario(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Text(
                            '${snapshot.data}',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.008,
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/icons/041-home.svg',height: 30,width: 30,),
              title: Text('Home'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset('assets/images/icons/040-profile.svg',height: 30,width: 30,),
              title: Text('Perfil'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountScreen()),
              ),
            ),
            SizedBox(
              height: size.height * 0.49,
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            ListTile(
                leading: SvgPicture.asset('assets/images/icons/log-out.svg',height: 30,width: 30,),
                title: Text('Cerrar sesión'),
                onTap: () => {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Cerrar Sesión"),
                              content: new Text(
                                  "¿Estás seguro de que quieres \n cerrar sesión?"),
                              actions: <Widget>[
                                new FlatButton(
                                    child: new Text("Si"),
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      await _auth.singOut();
                                      Navigator.of(context).pop();
                                    }),
                                new FlatButton(
                                  child: new Text("Cancelar"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          }),
                    }),
          ],
        ),
      ),
    );
  }

  Future firebaseUsuario() async {
    final usuario = await FirebaseAuth.instance.currentUser.email;
    return usuario;
  }
}
