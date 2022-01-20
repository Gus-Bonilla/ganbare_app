import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:ganbare/src/Services/firebase_auth.dart';

class PasswordForget extends StatefulWidget {
  @override
  _PasswordForgetState createState() => _PasswordForgetState();
}

class _PasswordForgetState extends State<PasswordForget> {
  String _email;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  var list = [
    Colors.green[200],
    Colors.green[300],
    Colors.green[400],
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: size.height * 1,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: top,
              end: bottom,
              colors: list,
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: size.height * 0.15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })
                ],
              ),
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      child: Text(
                        'Ingresa tu correo para que restablezcas tu contraseña',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: TextFormField(
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                          hintText: 'Correo',
                          hintStyle: TextStyle(color: Colors.white),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Campo requerido'),
                          EmailValidator(errorText: 'El email no es valido'),
                        ]),
                        onChanged: (value) {
                          setState(() => _email = value);
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.15,
                    ),
                    Container(
                      height: size.height * 0.08,
                      width: size.width * 0.8,
                      child: RaisedButton(
                        elevation: 5.0,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            await _auth.resetPassword(_email);
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                elevation: 5.0,
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.white,
                                content: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.thumb_up,
                                      color: Colors.green[400],
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Email enviado',
                                      style: TextStyle(color: Colors.black),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        child: Text(
                          'Enviar',
                          style: TextStyle(
                              color: Colors.green[400],
                              letterSpacing: 1.5,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
