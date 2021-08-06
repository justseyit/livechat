import 'package:livechat/models/app_user.dart';

abstract class DBBase{
  Future<bool> saveUserToDB(AppUser user);
}