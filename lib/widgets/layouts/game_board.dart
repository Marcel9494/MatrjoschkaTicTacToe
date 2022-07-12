import 'package:flutter/material.dart';

import 'dart:math';

import '../../models/game_model.dart';

class GameBoard extends StatelessWidget {
  final Game game;
  final Function onTap;

  const GameBoard({
    Key? key,
    required this.game,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Center(
          child: GridView.count(
            crossAxisCount: sqrt(game.fields.length).toInt(),
            shrinkWrap: true,
            children: [
              for (int i = 0; i < game.fields.length; i++)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                  ),
                  child: InkWell(
                    onTap: () => onTap(i),
                    child: Center(
                      child: Text(
                        game.fields[i].symbol,
                        style: TextStyle(fontSize: 12.0 * game.fields[i].currentLevel),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
