import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ganbare/src/UI/Login/PasswordForget.dart';
import 'package:ganbare/src/UI/Register/Register_screen.dart';
import 'package:ganbare/src/Services/firebase_auth.dart';
import 'package:ganbare/src/Shared/Loading.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  String validatePassword(value) {
    if (value.isEmpty) {
      return 'Campo requerido';
    } else if (value.lenght < 6) {
      return 'Debe tener 6 caracteres o más';
    } else if (value.lenght > 8) {
      return 'Debe tener menos de 8 caracteres';
    } else {
      return null;
    }
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/LoginUp.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                left: 20,
                                top: 80,
                                child: Center(
                                  child: Container(
                                    child: Text(
                                      'Inicia Sesión',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 3.0,
                                            offset: Offset(0, 0))
                                      ]),
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
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PasswordForget()));
                                    },
                                    padding: EdgeInsets.only(right: 0.0),
                                    child: Text('¿Olvidaste tu contraseña?'),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.06,
                                ),
                                Container(
                                  height: 100.0,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 25.0,
                                  ),
                                  child: RaisedButton(
                                    elevation: 5.0,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result =
                                            await _auth.signInWithCredentials(
                                                email, password);
                                        setState(() => loading = false);
                                        if (result == null) {
                                          setState(() => error =
                                              'Ingresa un formato de correo valido');
                                          loading = false;
                                        }
                                      } else {
                                        _scaffoldKey.currentState.showSnackBar(
                                          SnackBar(
                                            elevation: 5.0,
                                            duration: Duration(seconds: 3),
                                            backgroundColor: Colors.red[400],
                                            content: Row(
                                              children: <Widget>[
                                                Icon(Icons.info),
                                                SizedBox(
                                                  width: size.width * 0.03,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                        'Email o contraseña no validos'))
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
                                    color: Colors.green[400],
                                    child: Text(
                                      'Ingresar',
                                      style: TextStyle(
                                          color: Colors.white,
                                          letterSpacing: 1.5,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.06,
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterScreen(),
                                      ),
                                    ),
                                  },
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '¿Aún no tienes una cuenta? ',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        TextSpan(
                                          text: '¡Registrate!',
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}
