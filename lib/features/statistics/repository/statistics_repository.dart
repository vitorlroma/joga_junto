import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:joga_junto/core/constants/firebase_constants.dart';
import 'package:joga_junto/core/failure.dart';
import 'package:joga_junto/core/provider/firebase_provider.dart';
import 'package:joga_junto/core/type_defs.dart';
import 'package:joga_junto/models/statistics_model.dart';

final statisticsRepositoryProvider = Provider((ref) {
  return StatisticsRepository(firestore: ref.watch(firestoreProvider));
});

class StatisticsRepository {
  final FirebaseFirestore _firestore;
  StatisticsRepository({
    required FirebaseFirestore firestore
  }): _firestore = firestore;
  
  FutureVoid createStatistics(String uid) async {
    try {
      final statistics = Statistics(id: uid, score: 0);
      return right(await _statistics.doc(uid).set(statistics.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    } 
  }

  Stream<Statistics> getUserStatistics(String uid) {
    return _statistics.where('id', isEqualTo: uid).snapshots().map((event) {
      Statistics statistic;
      statistic = Statistics.fromMap(event.docs.first as Map<String, dynamic>);
      return statistic;
    });
  }

  CollectionReference get _statistics => _firestore.collection(FirebaseConstants.statisticsCollection);
}
