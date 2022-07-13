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
        winSerie: 4,
        fieldMulti: 5,
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
        checkIfGameIsFinished('X');
      }
    } else {
      if (setGamePieceToField(game.playerTwoGamePieces, game.playerTwoLevelMap, fieldNumber)) {
        checkIfGameIsFinished('O');
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

  void checkIfGameIsFinished(String checkedSymbol) {
    if (checkIfPlayerHasWon(checkedSymbol) == false) {
      if (game.gamePieceSelected) {
        game.gamePieceSelected = false;
        game.currentRound++;
      }
    }
    if (game.currentRound > game.maxRounds) {
      setState(() {
        game.gameIsFinished = true;
      });
    }
  }

  bool checkIfPlayerHasWon(String checkedSymbol) {
    int winStreak = 0;
    int lineBorder = game.fieldMultiplier;
    for (int i = 0; i < game.fields.length; i++) {
      if (game.fields[i].symbol == '') {
        continue;
      }
      int line = (i ~/ game.fieldMultiplier) + 1;
      lineBorder = line * game.fieldMultiplier;
      winStreak = 0;
      // Prüfe, ob genügend Symbole nebeneinander in einer Reihe sind
      for (int j = 0; j < game.winSeries; j++) {
        if (i + j < lineBorder && game.fields[i + j].symbol.contains(checkedSymbol)) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return true;
          }
        } else {
          break;
        }
      }
      winStreak = 0;
      // Prüfe, ob genügend Symbole nebeneinander in einer Zeile sind
      for (int j = 0; j < game.winSeries; j++) {
        if ((j * game.fieldMultiplier) + i < game.fields.length &&
            game.fields[(j * game.fieldMultiplier) + i].symbol.contains(checkedSymbol)) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return true;
          }
        } else {
          break;
        }
      }
      winStreak = 0;
      // Prüfe, ob genügend Symbole quer nach rechts sind
      for (int j = 0; j < game.winSeries; j++) {
        if ((j * game.fieldMultiplier) + i + j < game.fields.length &&
            game.fields[(j * game.fieldMultiplier) + i + j].symbol.contains(checkedSymbol)) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return true;
          }
        } else {
          break;
        }
      }
      winStreak = 0;
      // Prüfe, ob genügend Symbole quer nach links sind
      for (int j = 0; j < game.winSeries; j++) {
        if ((j * game.fieldMultiplier) + i - j < game.fields.length &&
            game.fields[(j * game.fieldMultiplier) + i - j].symbol.contains(checkedSymbol)) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return true;
          }
        } else {
          break;
        }
      }
    }
    return false;
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
