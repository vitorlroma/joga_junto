import 'package:flutter/foundation.dart';

class Team {
  final String id;
  final String creator;
  final String banner;
  final String avatar;
  final String name;
  final List<String> members;
  Team({
    required this.id,
    required this.creator,
    required this.banner,
    required this.avatar,
    required this.name,
    required this.members,
  });
  
  Team copyWith({
    String? id,
    String? creator,
    String? banner,
    String? avatar,
    String? name,
    List<String>? members,
  }) {
    return Team(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      banner: banner ?? this.banner,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator': creator,
      'banner': banner,
      'avatar': avatar,
      'name': name,
      'members': members,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as String,
      creator: map['creator'] as String,
      banner: map['banner'] as String,
      avatar: map['avatar'] as String,
      name: map['name'] as String,
      members: List<String>.from(map['members']),
      ); 
  }

  @override
  String toString() {
    return 'Team(id: $id, creator: $creator, banner: $banner, avatar: $avatar, name: $name, members: $members)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.creator == creator &&
      other.banner == banner &&
      other.avatar == avatar &&
      other.name == name &&
      listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      creator.hashCode ^
      banner.hashCode ^
      avatar.hashCode ^
      name.hashCode ^
      members.hashCode;
  }
}
