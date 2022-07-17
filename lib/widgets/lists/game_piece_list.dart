import 'package:flutter/material.dart';

import '../../models/game_piece_model.dart';
import '../components/game_piece_component.dart';

class GamePieceList extends StatefulWidget {
  final List<GamePiece> gamePieceList;
  final bool activePlayer;
  final Map levelMap;
  final int gamePieceWidthOffset;

  const GamePieceList({
    Key? key,
    required this.gamePieceList,
    required this.activePlayer,
    required this.levelMap,
    this.gamePieceWidthOffset = 0,
  }) : super(key: key);

  @override
  State<GamePieceList> createState() => _GamePieceListState();
}

class _GamePieceListState extends State<GamePieceList> {
  void selectField(int fieldNumber) {
    for (int i = 0; i < widget.gamePieceList.length; i++) {
      if (widget.gamePieceList[i].isSelected) {
        widget.gamePieceList[i].isSelected = false;
      }
    }
    setState(() {
      widget.gamePieceList[fieldNumber].isSelected = !widget.gamePieceList[fieldNumber].isSelected;
    });
  }

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
                  style: const TextStyle(fontSize: 24.0),
                ),
                GamePieceFieldComponent(
                  gamePiece: widget.gamePieceList[i],
                  gamePieceWidth:
                      MediaQuery.of(context).size.width / widget.levelMap.length - widget.gamePieceWidthOffset,
                  activePlayer: widget.activePlayer,
                  levelSize: widget.levelMap.keys.elementAt(i),
                  onTap: () => selectField(i),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
