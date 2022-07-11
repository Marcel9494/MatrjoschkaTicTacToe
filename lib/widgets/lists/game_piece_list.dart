import 'package:flutter/material.dart';

import '../../models/game_piece_model.dart';
import '../components/game_piece_component.dart';

class GamePieceList extends StatefulWidget {
  final List<GamePiece> gamePieceList;
  final bool activePlayer;
  final Map levelMap;

  const GamePieceList({
    Key? key,
    required this.gamePieceList,
    required this.activePlayer,
    required this.levelMap,
  }) : super(key: key);

  @override
  State<GamePieceList> createState() => _GamePieceListState();
}

class _GamePieceListState extends State<GamePieceList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          for (int i = 0; i < widget.levelMap.length; i++)
            Column(
              children: [
                Text(
                  widget.levelMap.values.elementAt(i).toString(),
                  style: const TextStyle(fontSize: 18.0),
                ),
                GamePieceFieldComponent(
                  gamePiece: widget.gamePieceList[i],
                  width: MediaQuery.of(context).size.width / widget.levelMap.length,
                  activePlayer: widget.activePlayer,
                  levelSize: widget.levelMap.keys.elementAt(i),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
