import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/error_text.dart';
import 'package:joga_junto/core/common/loader.dart';
import 'package:joga_junto/features/auth/controller/auth_controller.dart';
import 'package:joga_junto/features/team/controller/team_controller.dart';
import 'package:joga_junto/models/user_model.dart';
import 'package:joga_junto/theme/pallete.dart';

class CustomListTile<T> extends ConsumerWidget {
  const CustomListTile({
    super.key,
    required this.uid
    });

    final String uid;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(T == UserModel){
      return ref.read(getUserDataProvider(uid)).when(
        data: (user) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Pallete.orangeColor,
            backgroundImage: NetworkImage(user.profilePic),
          ),
          title: Text(user.email),
          onTap: () {},
        ), 
        error: (error, stackTrace) => ErrorText(
          error: error.toString()
        ), 
        loading: () => const Loader()
      );
    } else {
      return ref.read(getTeamByUid(uid)).when(
        data: (team) => ListTile(
          leading: CircleAvatar(
            backgroundColor: Pallete.orangeColor,
            backgroundImage: NetworkImage(team.avatar),
          ),
          title: Text(team.name),
          onTap: () {},
        ), 
        error: (error, stackTrace) => ErrorText(
          error: error.toString()
        ), 
        loading: () => const Loader()
      );
    }
  }
}