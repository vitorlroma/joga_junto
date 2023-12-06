import 'package:collection/collection.dart';

class Team {
  final String id;
  final String creator;
  final String name;
  final List<String> members;
  Team({
    required this.id,
    required this.creator,
    required this.name,
    required this.members,
  });

  Team copyWith({
    String? id,
    String? creator,
    String? name,
    List<String>? members,
  }) {
    return Team(
      id: id ?? this.id,
      creator: creator ?? this.creator,
      name: name ?? this.name,
      members: members ?? this.members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'creator': creator,
      'name': name,
      'members': members,
    };
  }

  factory Team.fromMap(Map<String, dynamic> map) {
    return Team(
      id: map['id'] as String,
      creator: map['creator'] as String,
      name: map['name'] as String,
      members: List<String>.from((map['members'] as List<String>))
    );
  }
  
  @override
  String toString() {
    return 'Team(id: $id, creator: $creator, name: $name, members: $members)';
  }

  @override
  bool operator ==(covariant Team other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return 
      other.id == id &&
      other.creator == creator &&
      other.name == name &&
      listEquals(other.members, members);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      creator.hashCode ^
      name.hashCode ^
      members.hashCode;
  }
}
