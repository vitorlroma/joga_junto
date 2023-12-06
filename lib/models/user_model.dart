class UserModel {
  final String profilePic;
  final String email;
  final String password;
  UserModel({
    required this.profilePic,
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? profilePic,
    String? email,
    String? password,
  }) {
    return UserModel(
      profilePic: profilePic ?? this.profilePic,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'profilePic': profilePic,
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      profilePic: map['profilePic'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  @override
  String toString() => 'UserModel(profilePic: $profilePic, email: $email, password: $password)';

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.profilePic == profilePic &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => profilePic.hashCode ^ email.hashCode ^ password.hashCode;
}
