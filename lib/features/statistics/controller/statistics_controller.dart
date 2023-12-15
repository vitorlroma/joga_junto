import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/features/statistics/repository/statistics_repository.dart';
import 'package:joga_junto/models/statistics_model.dart';

final statisticsProvider = FutureProvider.family((ref, String uid) {
  final statisticsController = ref.watch(statisticsControllerProvider.notifier);
  return statisticsController.getStatistics(uid);
});

final statisticsControllerProvider = StateNotifierProvider<StatisticsController, bool>((ref) {
  final statisticsRepository = ref.watch(statisticsRepositoryProvider);
  return StatisticsController(statisticsRepository: statisticsRepository, ref: ref);
});

class StatisticsController extends StateNotifier<bool> {
  final StatisticsRepository _statisticsRepository;
  // ignore: unused_field
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

  Future<Statistics> getStatistics(String uid) async {
    return await _statisticsRepository.getStatistics(uid);
  }
}
