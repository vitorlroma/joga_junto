
class UserModel {
  final String uid;
  final String profilePic;
  final String email;
  final String password;
  UserModel({
    required this.uid,
    required this.profilePic,
    required this.email,
    required this.password,
  });
  

  UserModel copyWith({
    String? uid,
    String? profilePic,
    String? email,
    String? password,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'profilePic': profilePic,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, profilePic: $profilePic, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.profilePic == profilePic &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      profilePic.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}
