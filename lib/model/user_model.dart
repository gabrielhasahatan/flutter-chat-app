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
      lastSeen: DateTime.fromMicrosecondsSinceEpoch(map['lastSeen'] ?? 0),
      createAt: DateTime.fromMicrosecondsSinceEpoch(map['createAt'] ?? 0),
    );
  }
}
