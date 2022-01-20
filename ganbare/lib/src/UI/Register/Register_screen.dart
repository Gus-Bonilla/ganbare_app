import 'package:flutter/material.dart';
import 'package:ganbare/src/Services/firebase_auth.dart';
import 'package:ganbare/src/UI/Login/Login_screen.dart';
import 'package:ganbare/src/Shared/Loading.dart';
import 'package:ganbare/src/UI/Update_userData.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String password2 = '';
  String error = '';

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              height: size.height * 1,
              padding: EdgeInsets.symmetric(vertical: 0),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                    Colors.green[400],
                    Colors.green[400],
                    Colors.green[500],
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Registrate',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 2.0,
                        ),
                        Text(
                          'Un paso a una mejor vida',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 30,
                                ),
                                //-----------------
                                Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Form(
                                    key: _formKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.email),
                                              border: InputBorder.none,
                                              hintText: 'Correo',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: 'Campo requerido'),
                                              EmailValidator(
                                                  errorText:
                                                      'El email no es valido'),
                                            ]),
                                            onChanged: (value) {
                                              setState(() => email = value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.lock),
                                              border: InputBorder.none,
                                              hintText: 'Contraseña',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: MultiValidator([
                                              RequiredValidator(
                                                  errorText: 'Campo requerido'),
                                              MinLengthValidator(6,
                                                  errorText:
                                                      'Debe tener 6 caracteres o más'),
                                              MaxLengthValidator(10,
                                                  errorText:
                                                      'No debe tener mas de 10 caracteres')
                                            ]),
                                            onChanged: (value) {
                                              setState(() => password = value);
                                            },
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[100]),
                                            ),
                                          ),
                                          child: TextFormField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              icon: Icon(Icons.vpn_key),
                                              border: InputBorder.none,
                                              hintText: 'Confirma contraseña',
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[400]),
                                            ),
                                            validator: (val) => MatchValidator(
                                                    errorText:
                                                        'Las contraseñas no son iguales')
                                                .validateMatch(val, password),
                                            onChanged: (value) {
                                              setState(() => password2 = value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: size.height * 0.12,
                                  width: size.width * 0.8,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result =
                                            await _auth.registerWithCredentials(
                                                email, password);
                                        setState(() => loading = false);
                                        if (result == null) {
                                          setState(() => error =
                                              'Ingresa un formato de correo valido');
                                          loading = false;
                                        } else {
                                          loading = false;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateUserData()));
                                        }
                                      }
                                    },
                                    padding: EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    color: Colors.green[400],
                                    child: Text(
                                      'Registrar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    )
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '¿Ya tienes una cuenta? ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '¡Inicia Sesión!',
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
