import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/error_text.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/statistics/controller/statistics_controller.dart';
import 'package:joga_junto/models/statistics_model.dart';
import 'package:joga_junto/theme/pallete.dart';

class StatisticsScreen extends ConsumerWidget {
  final String _statisticsUid;
  const StatisticsScreen({
    super.key, 
    required String statisticsUid
    }): _statisticsUid = statisticsUid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: ref.read(statisticsProvider(_statisticsUid)).when(
          data: (statistics) => Builder(
            builder: (BuildContext context) {
              final statistic = _getAttributes(statistics);
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Pallete.orangeColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                      border: Border.symmetric(
                        vertical: BorderSide(
                          color: Pallete.orangeColor,
                          width: 2
                        ),
                        horizontal: BorderSide(
                          color: Pallete.orangeColor,
                          width: 2
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Estatísticas',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      statistic[0],
                      statistic[1],
                    ],
                  )
                ],
              );
            }
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString(), 
          ),
          loading: () => const Loader(),
        ),
      ),
    );
  }

  List<Container> _getAttributes(Statistics statistics){
    return [
      Container(
        width: 184.2,
        height: 60,
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
          border: Border.symmetric(
            vertical: BorderSide(
              color: Pallete.orangeColor,
              width: 0.5
            ),
            horizontal: BorderSide(
              color: Pallete.orangeColor,
              width: 0.5
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Text('Pontos marcados:',
                style: TextStyle(
                  fontSize: 12
                ),
              ), 
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(statistics.score.toString(),
                style: const TextStyle(
                  fontSize: 10
                ),
              ), 
            ),
          ],
        ),
      ),
      Container(
        width: 184.3,
        height: 60,
        decoration:const BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10)),
          border: Border.symmetric(
            vertical: BorderSide(
              color: Pallete.orangeColor,
              width: 0.5
            ),
            horizontal: BorderSide(
              color: Pallete.orangeColor,
              width: 0.5
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(4),
              child: Text('Assistências:',
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4),
              child: Text(statistics.assists.toString(),
                style: const TextStyle(
                  fontSize: 10
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }
}