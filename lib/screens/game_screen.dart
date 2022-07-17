import 'package:flutter/material.dart';

import 'dart:math';

import '/models/field_model.dart';
import '/models/game_model.dart';
import '/models/game_piece_model.dart';

import '/widgets/lists/game_piece_list.dart';

class GameScreen extends StatefulWidget {
  final int winSerie;
  final int fieldMultiplier;
  final List<int> playerOneGamePieceLevel;
  final List<int> playerTwoGamePieceLevel;
  final bool activateArtificialIntelligence;

  const GameScreen({
    Key? key,
    required this.winSerie,
    required this.fieldMultiplier,
    required this.playerOneGamePieceLevel,
    required this.playerTwoGamePieceLevel,
    required this.activateArtificialIntelligence,
  }) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Game game;

  @override
  void initState() {
    super.initState();
    startNewGame();
    if (widget.activateArtificialIntelligence) {
      miniMax(game.fields, 1, false);
    }
  }

  void startNewGame() {
    setState(() {
      game = Game(
        winSerie: widget.winSerie,
        fieldMulti: widget.fieldMultiplier,
        playerOneGamePieceLvl: widget.playerOneGamePieceLevel,
        playerTwoGamePieceLvl: widget.playerTwoGamePieceLevel,
      );
    });
  }

  void miniMax(List<Field> board, int depth, bool isMax) {
    int score = evaluate(board);
  }

  int evaluate(List<Field> board) {
    return 0;
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
        setState(() {
          game.gamePieceSelected = false;
          game.currentRound++;
        });
      }
    }
    if (game.currentRound > game.maxRounds) {
      setState(() {
        game.gameIsFinished = true;
      });
    }
    setState(() {});
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Center(
                  child: Column(
                    children: [
                      GamePieceList(
                        gamePieceList: game.playerOneGamePieces,
                        activePlayer: game.currentRound % 2 == 0,
                        levelMap: game.playerOneLevelMap,
                      ),
                      GridView.count(
                        crossAxisCount: sqrt(game.fields.length).toInt(),
                        shrinkWrap: true,
                        children: [
                          for (int i = 0; i < game.fields.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white54),
                              ),
                              child: InkWell(
                                onTap: () => setField(i),
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
                      GamePieceList(
                        gamePieceList: game.playerTwoGamePieces,
                        activePlayer: game.currentRound % 2 == 1,
                        levelMap: game.playerTwoLevelMap,
                      ),
                      game.gameIsFinished
                          ? Column(
                              children: [
                                game.playerHasWon ? const Text('Gewonnen') : const Text('Unentschieden'),
                                ElevatedButton(
                                    onPressed: () => startNewGame(), child: const Text('Neues Spiel starten'))
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
