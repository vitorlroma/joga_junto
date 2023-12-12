import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/features/statistics/repository/statistics_repository.dart';
import 'package:joga_junto/models/statistics_model.dart';

final userStatisticsProvider = FutureProvider((ref) {
  final statisticsController = ref.watch(statisticsControllerProvider.notifier);
  return statisticsController.getUserStatistics();
});

final statisticsControllerProvider = StateNotifierProvider<StatisticsController, bool>((ref) {
  final statisticsRepository = ref.watch(statisticsRepositoryProvider);
  return StatisticsController(statisticsRepository: statisticsRepository, ref: ref);
});

class StatisticsController extends StateNotifier<bool> {
  final StatisticsRepository _statisticsRepository;
  final Ref _ref;
  StatisticsController({
    required statisticsRepository,
    required ref,
  }): _statisticsRepository = statisticsRepository,
  _ref = ref,
  super(false);
  
  void createStatistics (String uid) async {
    state = true;
    _statisticsRepository.createStatistics(uid);
    state = false;
  }

  Future<Statistics> getUserStatistics() async {
    final uid = _ref.read(userProvider)!.uid;
    return await _statisticsRepository.getStatistics(uid);
  }
}
