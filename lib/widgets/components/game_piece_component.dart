import 'package:flutter/material.dart';

import '/models/game_piece_model.dart';

class GamePieceFieldComponent extends StatefulWidget {
  final GamePiece gamePiece;
  final bool activePlayer;
  final int levelSize;
  final double gamePieceWidth;
  final Function onTap;

  const GamePieceFieldComponent({
    Key? key,
    required this.gamePiece,
    required this.activePlayer,
    required this.levelSize,
    required this.gamePieceWidth,
    required this.onTap,
  }) : super(key: key);

  @override
  State<GamePieceFieldComponent> createState() => _GamePieceFieldComponentState();
}

class _GamePieceFieldComponentState extends State<GamePieceFieldComponent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: widget.gamePiece.isSelected ? Colors.cyanAccent : Colors.transparent,
          border: Border.all(color: widget.activePlayer ? Colors.cyanAccent : Colors.white54),
        ),
        width: widget.gamePieceWidth,
        child: InkWell(
          onTap: widget.activePlayer ? () => widget.onTap() : null,
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
