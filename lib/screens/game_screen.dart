import 'package:flutter/material.dart';

import '/models/game_model.dart';
import '/models/game_piece_model.dart';

import '/widgets/layouts/game_board.dart';
import '/widgets/lists/game_piece_list.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      game = Game(
        winSerie: 3,
        fieldMulti: 3,
        playerOneGamePieceLevel: [1, 1, 3, 3, 5, 5],
        playerTwoGamePieceLevel: [1, 1, 3, 3, 5, 5],
      );
    });
  }

  void setField(final int fieldNumber) {
    for (int i = 0; i < game.playerOneGamePieces.length; i++) {
      if (game.playerOneGamePieces[i].isSelected || game.playerTwoGamePieces[i].isSelected) {
        game.gamePieceSelected = true;
        break;
      }
    }
    if (game.currentRound % 2 == 0) {
      if (setGamePieceToField(game.playerOneGamePieces, game.playerOneLevelMap, fieldNumber)) {
        checkIfGameIsFinished();
      }
    } else {
      if (setGamePieceToField(game.playerTwoGamePieces, game.playerTwoLevelMap, fieldNumber)) {
        checkIfGameIsFinished();
      }
    }
    setState(() {});
  }

  bool setGamePieceToField(List<GamePiece> gamePieceList, Map levelMap, final int fieldNumber) {
    for (int i = 0; i < gamePieceList.length; i++) {
      if (gamePieceList[i].isSelected) {
        if (levelMap.keys.elementAt(i) > game.fields[fieldNumber].currentLevel) {
          game.fields[fieldNumber].symbol = gamePieceList[i].symbol;
          gamePieceList[i].isSelected = false;
          game.fields[fieldNumber].currentLevel = levelMap.keys.elementAt(i);
          levelMap[levelMap.keys.elementAt(i)]--;
          if (levelMap[levelMap.keys.elementAt(i)] == 0) {
            gamePieceList[i].symbol = '';
          }
          return true;
        }
      }
    }
    return false;
  }

  void checkIfGameIsFinished() {
    if (isGameFinished() == false) {
      if (game.gamePieceSelected) {
        game.gamePieceSelected = false;
        game.currentRound++;
      }
    }
  }

  bool isGameFinished() {
    int winStreak = 0;
    int lineNumber = 1;
    for (int i = 0; i < game.fields.length; i++) {
      if (game.fields[i].symbol == '') {
        continue;
      }
      winStreak = 0;
      for (int j = 0; j < game.winSeries; j++) {
        if (i + j < game.fields.length) {
          if (j < game.fieldMultiplier * lineNumber && game.fields[i + j].symbol.contains('X')) {
            winStreak++;
            if (game.winSeries == winStreak) {
              game.gameIsFinished = true;
              game.playerHasWon = true;
              return true;
            }
          }
        }
        if (j == game.winSeries) {
          lineNumber++;
        }
      }
    }
    // TODO hier weitermachen auf Zeilen Gewinn prüfen.
    return false;
    /*if (game.fields[0].symbol.contains('X') &&
            game.fields[1].symbol.contains('X') &&
            game.fields[2].symbol.contains('X') ||
        game.fields[0].symbol.contains('O') &&
            game.fields[1].symbol.contains('O') &&
            game.fields[2].symbol.contains('O') ||
        game.fields[3].symbol.contains('X') &&
            game.fields[4].symbol.contains('X') &&
            game.fields[5].symbol.contains('X') ||
        game.fields[3].symbol.contains('O') &&
            game.fields[4].symbol.contains('O') &&
            game.fields[5].symbol.contains('O') ||
        game.fields[6].symbol.contains('X') &&
            game.fields[7].symbol.contains('X') &&
            game.fields[8].symbol.contains('X') ||
        game.fields[6].symbol.contains('O') &&
            game.fields[7].symbol.contains('O') &&
            game.fields[8].symbol.contains('O') ||
        game.fields[0].symbol.contains('X') &&
            game.fields[3].symbol.contains('X') &&
            game.fields[6].symbol.contains('X') ||
        game.fields[0].symbol.contains('O') &&
            game.fields[3].symbol.contains('O') &&
            game.fields[6].symbol.contains('O') ||
        game.fields[1].symbol.contains('X') &&
            game.fields[4].symbol.contains('X') &&
            game.fields[7].symbol.contains('X') ||
        game.fields[1].symbol.contains('O') &&
            game.fields[4].symbol.contains('O') &&
            game.fields[7].symbol.contains('O') ||
        game.fields[2].symbol.contains('X') &&
            game.fields[5].symbol.contains('X') &&
            game.fields[8].symbol.contains('X') ||
        game.fields[2].symbol.contains('O') &&
            game.fields[5].symbol.contains('O') &&
            game.fields[8].symbol.contains('O') ||
        game.fields[0].symbol.contains('X') &&
            game.fields[4].symbol.contains('X') &&
            game.fields[8].symbol.contains('X') ||
        game.fields[0].symbol.contains('O') &&
            game.fields[4].symbol.contains('O') &&
            game.fields[8].symbol.contains('O') ||
        game.fields[2].symbol.contains('X') &&
            game.fields[4].symbol.contains('X') &&
            game.fields[6].symbol.contains('X') ||
        game.fields[2].symbol.contains('O') &&
            game.fields[4].symbol.contains('O') &&
            game.fields[6].symbol.contains('O')) {
      setState(() {
        game.gameIsFinished = true;
        game.playerHasWon = true;
      });
      return true;
    } else if (game.currentRound == game.maxRounds) {
      setState(() {
        game.gameIsFinished = true;
      });
      return true;
    }
    return false;*/
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            GamePieceList(
              gamePieceList: game.playerOneGamePieces,
              activePlayer: game.currentRound % 2 == 0,
              levelMap: game.playerOneLevelMap,
            ),
            GameBoard(
              game: game,
              onTap: setField,
            ),
            GamePieceList(
              gamePieceList: game.playerTwoGamePieces,
              activePlayer: game.currentRound % 2 == 1,
              levelMap: game.playerTwoLevelMap,
            ),
            game.gameIsFinished
                ? Column(
                    children: [
                      game.playerHasWon ? const Text('Gewonnen') : const Text('Unentschieden'),
                      ElevatedButton(onPressed: () => startNewGame(), child: const Text('Neues Spiel starten'))
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
