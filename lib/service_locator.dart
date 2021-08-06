import 'package:get_it/get_it.dart';
import 'package:livechat/repository/auth_repository.dart';
import 'package:livechat/services/auth/fake_auth_service.dart';
import 'package:livechat/services/auth/firebase_auth_service.dart';
import 'package:livechat/services/db/firestore_db_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => FirebaseAuthService());
  locator.registerLazySingleton(() => FakeAuthService());
  locator.registerLazySingleton(() => AuthRepository(AppMode.Release));
  locator.registerLazySingleton(() => FirestoreDBService());
}