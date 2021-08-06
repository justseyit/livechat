import 'package:livechat/models/app_user.dart';
import 'package:livechat/services/auth/auth_base.dart';

class FakeAuthService implements AuthBase{

  final String _fakeUserID = '98247268407267026';
  final String _fakeUserEmail = 'fakeuser@test.com';

  @override
  AppUser? get currentUser => AppUser(uid: _fakeUserID);

  @override
  Future<AppUser?> signInAnonymously() async {
    return await Future.delayed(Duration(seconds: 2), () => AppUser(uid: _fakeUserID));
  }

  @override
  Future<bool> signOut() async {
    return await Future.delayed(Duration(seconds: 2), () => true);
  }

  @override
  Future<AppUser?> signInWithEmail({String email = 'mail', String password = 'pass'}) async {
    return await Future.delayed(Duration(seconds: 2), () => AppUser(uid: _fakeUserID, email: _fakeUserEmail));
  }

  @override
  Future<AppUser?> signInWithFacebook() async {
    return await Future.delayed(Duration(seconds: 2), () => AppUser(uid: _fakeUserID, email: _fakeUserEmail));
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    return await Future.delayed(Duration(seconds: 2), () => AppUser(uid: _fakeUserID, email: _fakeUserEmail));
  }

  @override
  Future<AppUser?> signUpWithEmail({required String email, required String password}) async{
    return await Future.delayed(Duration(seconds: 2), () => AppUser(uid: _fakeUserID, email: _fakeUserEmail));
  }


}