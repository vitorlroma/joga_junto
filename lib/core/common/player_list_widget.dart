import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:joga_junto/core/common/components.dart';
import 'package:joga_junto/models/user_model.dart';
import 'package:joga_junto/theme/pallete.dart';

class PlayerListScreen extends ConsumerWidget {
  final List<String> _players;
  const PlayerListScreen({
    super.key,
    required players
  }):_players = players;

  List<Widget> _getChildren() => List<Widget>.generate(
    _players.length-1, 
    (index) => CustomListTile<UserModel>(uid: _players[index])
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final children = _getChildren();
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 12, right: 12),
      child:  ExpansionTile(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 0.5,
            color: Pallete.orangeColor
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text(
          'Jogadores',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),
        children: <Widget>[
          Text(_players.length.toString()),
          Text(_getChildren().length.toString()),
          Column(children: children,)
        ],
      ),
    );
  }
}