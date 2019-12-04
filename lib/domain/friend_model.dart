import 'package:flutter/foundation.dart';

class FriendModel {
  FriendModel(this.id, this.name, this.email, this.phoneNumber);

  final int id;
  @required
  final String name;
  final String email;
  final int phoneNumber;

  // FB ID
  // IG ID
  // whatsapp ID
  // wechat ID
  // linkedin ID

  // To insert into SQLite DB
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      // 'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }
}
