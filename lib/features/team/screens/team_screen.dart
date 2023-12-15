import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/error_text.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/core/common/player_list_widget.dart';
import 'package:joga_junto/features/statistics/screens/statistics_screen.dart';
import 'package:joga_junto/features/team/controller/team_controller.dart';

class TeamScreen extends ConsumerWidget {
  final String _uid;
  const TeamScreen({
    super.key,
    required uid,
    }): _uid = uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getTeamByUid(_uid)).when(
        data: (team) => NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled){
            return [
              SliverAppBar(
                expandedHeight: 150,
                floating: true,
                snap: true,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        team.banner,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(team.avatar),
                          radius: 35,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            team.name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                      ),
                    ]
                  )
                )
              )
            ];
          },
          body: Column(
            children: [
              PlayerListScreen(players: team.members),
              StatisticsScreen(statisticsUid: _uid),
            ],
          ),
        ),
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader(),
      ),
    );
  }
}