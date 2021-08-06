import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:livechat/models/app_user.dart';
import 'package:livechat/services/auth/auth_base.dart';

class FirebaseAuthService implements AuthBase{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleAuth = GoogleSignIn();

  @override
  AppUser? get currentUser{
    try{
      final User? user = _auth.currentUser;
      return user != null ? AppUser(uid: user.uid) : null;
    }catch(ex){
      print('An error occoured in FirebaseAuthService, get currentUser.\nCode:  $ex');
    }
  }

  @override
  Future<AppUser?> signInAnonymously() async {
    try{
      final UserCredential credential = await _auth.signInAnonymously();
      return AppUser(uid: credential.user!.uid);
    }catch(ex){
      print('An error occoured in FirebaseAuthService, signInAnonymously().\nCode:  $ex');
      return null;
    }
  }

  @override
  Future<bool> signOut() async {
    try{
      await _googleAuth.signOut();
      await _facebookAuth.logOut();
      await _auth.signOut();
      return true;
    }catch(ex){
      print('An error occoured in FirebaseAuthService, signOut().\nCode:  $ex');
      return false;
    }
  }

  @override
  Future<AppUser?> signInWithEmail({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return AppUser(uid: userCredential.user!.uid, email: userCredential.user!.email);
    }catch (ex) {
      print('An error occoured in FirebaseAuthService, signInWithEmail().\nCode:  $ex');
      return null;
    }
  }

  @override
  Future<AppUser?> signInWithFacebook() async {
    try{
      // Trigger the sign-in flow
      final LoginResult loginResult = await _facebookAuth.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, get the UserCredential
      final UserCredential credential = await _auth.signInWithCredential(facebookAuthCredential);

      return AppUser(uid: credential.user!.uid, email: credential.user!.email);
    }catch(ex){
      print('An error occoured in FirebaseAuthService, signInWithFacebook().\nCode:  $ex');
      return null;
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleAuth.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, get the UserCredential
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      return AppUser(uid: userCredential.user!.uid, email: userCredential.user!.email);
    }catch(ex){
      print('An error occoured in FirebaseAuthService, signInWithGoogle().\nCode:  $ex');
      return null;
    }
  }

  @override
  Future<AppUser?> signUpWithEmail({required String email, required String password}) async{
    try{
      final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return AppUser(uid: credential.user!.uid, email: credential.user!.email);
    }catch(ex){
      print('An error occoured in FirebaseAuthService, signUpWithEmail().\nCode:  $ex');
      return null;
    }
  }

}