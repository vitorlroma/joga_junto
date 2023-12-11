import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/error_text.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/statistics/controller/statistics_controller.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        ref.watch(userStatisticsProvider).when(
          data: (statistics) => Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {    
                  return ListTile(
                    title: Text(statistics.id),
                  );
                } else {
                  return ListTile(
                    title: Text(statistics.score as String),
                  );
                }
              },
            ),
          ),
          error: (error, stackTrace) => ErrorText(
            error: error.toString()
          ), 
          loading: () => const Loader()
        ),
      ],
    );
  }
}