import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/error_text.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/team/controller/team_controller.dart';
import 'package:joga_junto/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class TeamListDrawer extends ConsumerWidget {
  const TeamListDrawer({super.key});

  void navigateToCreateTeam(BuildContext context) {
    Routemaster.of(context).push('/create-team');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Criar equipe!'),
              leading: const Icon(Icons.add),
              onTap: () => navigateToCreateTeam(context),
            ),
            ref.watch(userTeamsProvider).when(
              data: (teams) => Expanded(
                child: ListView.builder(
                  itemCount: teams.length,
                  itemBuilder: (BuildContext context, int index) {
                    final team = teams[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Pallete.orangeColor,
                        backgroundImage: NetworkImage(team.avatar),
                      ),
                      title: Text(team.name),
                      onTap: () {},
                    );
                  },
                ),
              ),
              error: (error, stackTrace) => ErrorText(
                error: error.toString()
              ), 
              loading: () => const Loader()
            ),
          ],
        ),
      ),
    );
  }
}