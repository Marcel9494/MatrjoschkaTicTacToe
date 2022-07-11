import 'package:flutter/material.dart';

import '/models/game_piece_model.dart';

class GamePieceFieldComponent extends StatefulWidget {
  final GamePiece gamePiece;
  final double width;
  final bool activePlayer;
  final int levelSize;

  const GamePieceFieldComponent({
    Key? key,
    required this.gamePiece,
    required this.width,
    required this.activePlayer,
    required this.levelSize,
  }) : super(key: key);

  @override
  State<GamePieceFieldComponent> createState() => _GamePieceFieldComponentState();
}

class _GamePieceFieldComponentState extends State<GamePieceFieldComponent> {
  void selectField() {
    setState(() {
      widget.gamePiece.isSelected = !widget.gamePiece.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: widget.gamePiece.isSelected ? Colors.cyanAccent : Colors.transparent,
          border: Border.all(
              color: widget.activePlayer ? Colors.cyanAccent : Colors.black, width: widget.activePlayer ? 2.0 : 1.0),
        ),
        width: widget.width,
        child: InkWell(
          onTap: widget.activePlayer ? () => selectField() : null,
          child: Center(
            child: Text(
              widget.gamePiece.symbol,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12.0 * widget.levelSize),
            ),
          ),
        ),
      ),
    );
  }
}
