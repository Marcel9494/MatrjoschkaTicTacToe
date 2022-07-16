import 'package:flutter/material.dart';
import 'package:matrjoschka_tictactoe/models/screen_arguments/game_screen_arguments.dart';

import '../utils/constants/route_constants.dart';

class SinglePlayerGameSelectionScreen extends StatefulWidget {
  const SinglePlayerGameSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SinglePlayerGameSelectionScreen> createState() => _SinglePlayerGameSelectionScreenState();
}

class _SinglePlayerGameSelectionScreenState extends State<SinglePlayerGameSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  gameRoute,
                  arguments: GameScreenArguments(
                    winSerie: 3,
                    fieldMultiplier: 3,
                    playerOneGamePieceLevel: [1, 1, 3, 3, 5, 5],
                    playerTwoGamePieceLevel: [1, 1, 3, 3, 5, 5],
                  ),
                ),
                child: const Text('3 x 3'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  gameRoute,
                  arguments: GameScreenArguments(
                    winSerie: 4,
                    fieldMultiplier: 5,
                    playerOneGamePieceLevel: [1, 1, 3, 3, 5, 5],
                    playerTwoGamePieceLevel: [1, 1, 3, 3, 5, 5],
                  ),
                ),
                child: const Text('5 x 5'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  gameRoute,
                  arguments: GameScreenArguments(
                    winSerie: 7,
                    fieldMultiplier: 7,
                    playerOneGamePieceLevel: [1, 1, 3, 3, 5, 5],
                    playerTwoGamePieceLevel: [1, 1, 3, 3, 5, 5],
                  ),
                ),
                child: const Text('7 x 7'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
