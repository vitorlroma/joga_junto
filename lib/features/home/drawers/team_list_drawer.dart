import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      backgroundColor: Pallete.greyColor,
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Criar equipe!'),
              leading: const Icon(Icons.add),
              onTap: () => navigateToCreateTeam(context),
            )
          ],
        ),
      ),
    );
  }
}