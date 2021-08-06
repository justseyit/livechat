import 'package:livechat/models/app_user.dart';
import 'package:livechat/service_locator.dart';
import 'package:livechat/services/auth/auth_base.dart';
import 'package:livechat/services/auth/fake_auth_service.dart';
import 'package:livechat/services/auth/firebase_auth_service.dart';
import 'package:livechat/services/db/firestore_db_service.dart';


enum AppMode {Debug, Release}

class AuthRepository implements AuthBase {
  AuthRepository(this.appMode);
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  final AppMode appMode;

  @override
  AppUser? get currentUser {
    switch(appMode){
      case AppMode.Debug:
        return _fakeAuthService.currentUser;

      case AppMode.Release:
        return _firebaseAuthService.currentUser;
    }
  }

  @override
  Future<AppUser?> signInAnonymously() async {
    switch(appMode){
      case AppMode.Debug:
        return await _fakeAuthService.signInAnonymously();

      case AppMode.Release:
        AppUser? user = await _firebaseAuthService.signInAnonymously();
        if(user != null) _firestoreDBService.saveUserToDB(user);
        return user;
    }
  }

  @override
  Future<bool> signOut() async {
    switch(appMode){
      case AppMode.Debug:
        return await _fakeAuthService.signOut();

      case AppMode.Release:
        return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<AppUser?> signInWithEmail({required String email, required String password}) async {
    switch(appMode){
      case AppMode.Debug:
        return await _fakeAuthService.signInWithEmail();

      case AppMode.Release:
        AppUser? user = await _firebaseAuthService.signInWithEmail(email: email, password: password);
        if(user != null) _firestoreDBService.saveUserToDB(user);
        return user;
    }
  }

  @override
  Future<AppUser?> signInWithFacebook() async {
    switch(appMode){
      case AppMode.Debug:
        return await _fakeAuthService.signInWithFacebook();

      case AppMode.Release:
        AppUser? user = await _firebaseAuthService.signInWithFacebook();
        if(user != null) _firestoreDBService.saveUserToDB(user);
        return user;
    }
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    switch(appMode){
      case AppMode.Debug:
        return await _fakeAuthService.signInWithGoogle();

      case AppMode.Release:
        AppUser? user = await _firebaseAuthService.signInWithGoogle();
        if(user != null) _firestoreDBService.saveUserToDB(user);
        return user;
    }
  }

  @override
  Future<AppUser?> signUpWithEmail({required String email, required String password}) async{
    switch(appMode){
      case AppMode.Debug:
        return await _fakeAuthService.signUpWithEmail(email: email, password: password);

      case AppMode.Release:
        AppUser? user = await _firebaseAuthService.signUpWithEmail(email: email, password: password);
        if(user != null) _firestoreDBService.saveUserToDB(user);
        return user;
    }
  }

}