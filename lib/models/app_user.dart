import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser{
  late final String uid;
  String? email;
  String? userName;
  String? photoURL;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? level;

  AppUser({required this.uid, this.email, this.userName, this.photoURL, this.createdAt, this.updatedAt, this.level});

  Map<String, dynamic> toMap(){
    final String unPart1 = this.email!.substring(0, this.email!.indexOf('@'));
    final String unPart2 = this.email!.substring(this.email!.indexOf('@')+1, this.email!.indexOf('.'));
    Map<String, dynamic> map = Map();
    map['uid'] = this.uid;
    map['email'] = this.email ?? '';
    map['userName'] = this.userName ?? unPart1 + unPart2;
    map['photoURL'] = this.photoURL ?? 'https://www.elderwood.com/MediaUploads/person.png';
    map['createdAt'] = this.createdAt ?? '';
    map['updatedAt'] = this.updatedAt ?? '';
    map['level'] = this.level ?? 0;
    return map;
  }

  AppUser.fromMap(Map<String, dynamic> map){
    this.uid = map['uid'];
    this.email = map['email'];
    this.userName = map['userName'];
    this.photoURL = map['photoURL'];
    this.createdAt = (map['createdAt'] as Timestamp).toDate();
    this.updatedAt = (map['updatedAt'] as Timestamp).toDate();
    this.level = map['level'];
  }

  @override
  String toString() {
    return 'AppUser(\nuid: $uid,\nemail: $email,\nuserName: $userName,\nphotoURL: $photoURL,\ncreatedAt: $createdAt,\nupdatedAt: $updatedAt,\nlevel: $level,\n)';
  }
}