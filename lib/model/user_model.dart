import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String photoUrl;
  final bool isOnline;
  final DateTime lastSeen;
  final DateTime createAt;

  UserModel(
      {required this.id,
      required this.createAt,
      required this.displayName,
      required this.email,
      this.isOnline = false,
      required this.lastSeen,
      this.photoUrl = ""});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
      "isOnline": isOnline,
      "lastSeen": lastSeen,
      "createAt": createAt,
    };
  }

  static UserModel fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      displayName: map['displayName'] ?? '',
      email: map['email'] ?? '',
      isOnline: map['isOnline'] ?? false,
      photoUrl: map['photoUrl'] ?? '',
      lastSeen: map['lastSeen'] != null
          ? (map['lastSeen'] as Timestamp).toDate()
          : DateTime.now(),
      createAt: map['createAt'] != null
          ? (map['createAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoUrl,
    bool? isOnline,
    DateTime? lastSeen,
    DateTime? createAt,
  }) {
    return UserModel(
        id: id ?? this.id,
        createAt: createAt ?? this.createAt,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        lastSeen: lastSeen ?? this.lastSeen,
        isOnline: isOnline ?? this.isOnline,
        photoUrl: photoUrl ?? this.photoUrl);
  }
}
