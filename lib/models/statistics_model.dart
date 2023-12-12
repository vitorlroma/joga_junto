class Statistics {
  final String id;
  final int score;
  final int assists;
  Statistics({
    required this.id,
    required this.score,
    required this.assists,
  });

  Statistics copyWith({
    String? id,
    int? score,
    int? assists,
  }) {
    return Statistics(
      id: id ?? this.id,
      score: score ?? this.score,
      assists: assists ?? this.assists,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'assists': assists,
    };
  }

  factory Statistics.fromMap(Map<String, dynamic> map) {
    return Statistics(
      id: map['id'] ?? '',
      score: map['score']?.toInt() ?? 0,
      assists: map['assists']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'Statistics(id: $id, score: $score, assists: $assists)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Statistics &&
      other.id == id &&
      other.score == score &&
      other.assists == assists;
  }

  @override
  int get hashCode => id.hashCode ^ score.hashCode ^ assists.hashCode;
}
