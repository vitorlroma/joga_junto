// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String profilePic;
  final String name;
  final String email;
  final String password;
  final String cpf;
  final List<String> address;
  final String cityState;
  final String statistics;
  final int karma;
  UserModel({
    required this.uid,
    required this.profilePic,
    required this.name,
    required this.email,
    required this.password,
    required this.cpf,
    required this.address,
    required this.cityState,
    required this.statistics,
    required this.karma,
  });

  UserModel copyWith({
    String? uid,
    String? profilePic,
    String? name,
    String? email,
    String? password,
    String? cpf,
    List<String>? address,
    String? cityState,
    String? statistics,
    int? karma,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      cpf: cpf ?? this.cpf,
      address: address ?? this.address,
      cityState: cityState ?? this.cityState,
      statistics: statistics ?? this.statistics,
      karma: karma ?? this.karma,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'profilePic': profilePic,
      'name': name,
      'email': email,
      'password': password,
      'cpf': cpf,
      'addres': address,
      'cityState': cityState,
      'statistics': statistics,
      'karma': karma,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      cpf: map['cpf'] as String,
      address: List<String>.from((map['address'] as List<String>)),
      cityState: map['cityState'] as String,
      statistics: map['statistics'] as String,
      karma: map['karma'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, profilePic: $profilePic, name: $name, email: $email, password: $password, cpf: $cpf, address: $address, cityState: $cityState, statistics: $statistics, karma: $karma)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.profilePic == profilePic &&
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.cpf == cpf &&
      listEquals(other.address, address) &&
      other.cityState == cityState &&
      other.statistics == statistics &&
      other.karma == karma;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      profilePic.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      cpf.hashCode ^
      address.hashCode ^
      cityState.hashCode ^
      statistics.hashCode ^
      karma.hashCode;
  }
}
