import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:livechat/models/app_user.dart';
import 'package:livechat/services/db/db_base.dart';

class FirestoreDBService implements DBBase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<bool> saveUserToDB(AppUser user) async{
    Map<String, dynamic> userMap = user.toMap();
    userMap['updatedAt'] = FieldValue.serverTimestamp();
    userMap['createdAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('users').doc('${user.uid}').set(userMap);

    DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore.doc('users/${user.uid}').get();
    Map<String, dynamic> readMap = (snapshot.data() as Map<String, dynamic>);
    AppUser readUser = AppUser.fromMap(readMap);
    print(readUser.toString());
    return true;
  }

}