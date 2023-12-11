class Statistics {
  final String id;
  final int score;
  Statistics({
    required this.id,
    required this.score,
  });
  

  Statistics copyWith({
    String? id,
    int? score,
  }) {
    return Statistics(
      id: id ?? this.id,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
    };
  }

  factory Statistics.fromMap(Map<String, dynamic> map) {
    return Statistics(
      id: map['id'] ?? '',
      score: map['score']?.toInt() ?? 0,
    );
  }

  @override
  String toString() => 'Statistics(id: $id, score: $score)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Statistics &&
      other.id == id &&
      other.score == score;
  }

  @override
  int get hashCode => id.hashCode ^ score.hashCode;
}
