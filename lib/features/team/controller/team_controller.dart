import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/utils.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/features/statistics/controller/statistics_controller.dart';
import 'package:joga_junto/features/team/repository/team_repository.dart';
import 'package:joga_junto/models/team_model.dart';
import 'package:routemaster/routemaster.dart';

final userTeamsProvider = StreamProvider((ref) {
  final teamController = ref.watch(teamControllerProvider.notifier);
  return teamController.getUserTeams();
}); 

final teamControllerProvider = StateNotifierProvider<TeamController, bool>((ref) {
  final teamRepository = ref.watch(teamRepositoryProvider);
  final statisticsController = ref.watch(statisticsControllerProvider.notifier);
  return TeamController(teamRepository: teamRepository, statisticsController: statisticsController, ref: ref);
});

final getTeamByUid = StreamProvider.family((ref, String uid) {
  return ref.read(teamControllerProvider.notifier).getTeamByUid(uid);
});

class TeamController extends StateNotifier<bool>{
  final TeamRepository _teamRepository;
  final StatisticsController _statisticsController;
  final Ref _ref;
  TeamController({
    required TeamRepository teamRepository,
    required StatisticsController statisticsController,
    required Ref ref,
    }): _teamRepository = teamRepository,
    _statisticsController = statisticsController,
    _ref = ref,
    super(false);
  
  void createTeam(String name, BuildContext context) async {
    state = true;
    final uid = _ref.read(userProvider)?.uid ?? '';
    final res = await _teamRepository.createTeam([uid, name], _statisticsController);
    state = false;
    res.fold((l) => showSnackBar(context, l.message), (r) {
      showSnackBar(context, 'Community created successfully!');
      Routemaster.of(context).pop();
    });
  }

  Stream<List<Team>> getUserTeams() {
    final uid = _ref.read(userProvider)!.uid;
    return _teamRepository.getUserTeams(uid);
  }

  Stream<Team> getTeamByUid(String uid){
    return _teamRepository.getTeamByUid(uid);
  }
}