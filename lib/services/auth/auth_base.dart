import 'package:livechat/models/app_user.dart';

abstract class AuthBase{
 AppUser? get currentUser;
 Future<AppUser?> signInAnonymously();
 Future<AppUser?> signInWithGoogle();
 Future<AppUser?> signInWithFacebook();
 Future<AppUser?> signInWithEmail({required String email, required String password});
 Future<AppUser?> signUpWithEmail({required String email, required String password});
 Future<bool> signOut();
}