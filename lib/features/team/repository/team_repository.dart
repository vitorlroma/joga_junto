import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:joga_junto/core/constants/constants.dart';
import 'package:joga_junto/core/constants/firebase_constants.dart';
import 'package:joga_junto/core/failure.dart';
import 'package:joga_junto/core/provider/firebase_provider.dart';
import 'package:joga_junto/core/type_defs.dart';
import 'package:joga_junto/features/statistics/controller/statistics_controller.dart';
import 'package:joga_junto/models/team_model.dart';

final teamRepositoryProvider = Provider((ref) {
  return TeamRepository(firestore: ref.watch(firestoreProvider));
});

class TeamRepository {
  final FirebaseFirestore _firestore;
  TeamRepository({
    required FirebaseFirestore firestore
  }): _firestore = firestore;

  FutureVoid createTeam(List<String> args, StatisticsController statisticsController) async {
    try {
      final teamRef = _teams.doc();
      final Team team = Team(
        id: teamRef.id, 
        creator: args[0], 
        banner: Constants.bannerDefault, 
        avatar: Constants.avatarDefault, 
        name: args[1], 
        members: [args[0]]
      );
      statisticsController.createStatistics(team.id);
      return right(teamRef.set(team.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Team>> getUserTeams(String uid) {
    return _teams.where('members', arrayContains: uid).snapshots().map((event) {
      List<Team> teams = [];
      for (var doc in event.docs){
        teams.add(Team.fromMap(doc.data() as Map<String, dynamic>));
      }
      return teams;
    });
  }

  Stream<Team> getTeamByUid(String uid){
    return _teams.doc(uid).snapshots().map((event) => Team.fromMap(event.data() as Map<String, dynamic>));
  }

  CollectionReference get _teams => _firestore.collection(FirebaseConstants.teamsCollection);
}