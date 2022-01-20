import 'package:firebase_auth/firebase_auth.dart';
import 'package:ganbare/src/Models/user.dart';
import 'package:ganbare/src/Services/Database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserObj _userFromFirebaseUSer(User user) {
    return user != null ? UserObj(uid: user.uid) : null;
  }

  Stream<UserObj> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUSer(user));
  }

  //Iniciar sesion anonimo
  Future singInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Iniciar sesion con credenciales
  Future signInWithCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //registrar con credenciales
  Future registerWithCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      await DatabaseServices(uid: user.uid)
          .updateUserData('usuario', 0, 0, 1, 'Hombre', 0, 0, 0);
      await user.sendEmailVerification();
      return _userFromFirebaseUSer(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //cerrar sesion
  Future singOut() async {
    try {
      return Future.wait([_auth.signOut(), _googleSignIn.signOut()]);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await _auth.signInWithCredential(credential);
      return _auth.currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

}
