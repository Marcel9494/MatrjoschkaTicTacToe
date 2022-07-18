import 'package:flutter/material.dart';

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

  void miniMax(List<List<Field>> board, int depth, bool isMax) {
    int score = evaluate(board);
    print('Score: ${score.toString()}');
  }

  int evaluate(List<List<Field>> board) {
    int winStreak = 0;
    // Prüfe, ob genügend Symbole nebeneinander in einer Reihe sind
    for (int row = 0; row < game.fieldMultiplier; row++) {
      for (int col = 0; col < game.fieldMultiplier; col++) {
        if (board[row][col].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          winStreak = 0;
        }
      }
    }
    winStreak = 0;
    // Prüfe, ob genügend Symbole nebeneinander in einer Zeile sind
    for (int col = 0; col < game.fieldMultiplier; col++) {
      for (int row = 0; row < game.fieldMultiplier; row++) {
        if (board[row][col].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          winStreak = 0;
        }
      }
    }
    winStreak = 0;
    // Prüfe mit Reihe, ob genügend Symbole quer nach rechts unten sind
    for (int row = 0; row < game.fieldMultiplier; row++) {
      for (int col = 0; col < game.fieldMultiplier; col++) {
        if (row + col < game.fieldMultiplier && board[col][col + row].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          winStreak = 0;
        }
      }
    }
    winStreak = 0;
    // Prüfe mit Zeile, ob genügend Symbole quer nach rechts unten sind
    for (int row = 0; row < game.fieldMultiplier; row++) {
      for (int col = 0; col < game.fieldMultiplier; col++) {
        if (row + col < game.fieldMultiplier && board[col + row][col].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          winStreak = 0;
        }
      }
    }
    winStreak = 0;
    // Prüfe mit Reihe, ob genügend Symbole quer nach links unten sind
    for (int row = 0; row < game.fieldMultiplier; row++) {
      for (int col = 0; col < game.fieldMultiplier; col++) {
        if (col - row >= 0 && board[row - col][row + col].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          winStreak = 0;
        }
      }
    }
    winStreak = 0;
    // Prüfe mit Zeile, ob genügend Symbole quer nach links unten sind
    for (int row = game.fieldMultiplier - 1; row >= 0; row--) {
      for (int col = game.fieldMultiplier - 1; col >= 0; col--) {
        if (board[col][col - row].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          winStreak = 0;
        }
      }
    }
    return 0;
    /*for (int i = 0; i < game.fields.length; i++) {
      if (game.fields[i].symbol == '') {
        continue;
      }
      int line = (i ~/ game.fieldMultiplier) + 1;
      lineBorder = line * game.fieldMultiplier;
      winStreak = 0;
      // Prüfe, ob genügend Symbole nebeneinander in einer Reihe sind
      for (int j = 0; j < game.winSeries; j++) {
        if (i + j < lineBorder && game.fields[i + j].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          break;
        }
      }
      winStreak = 0;
      // Prüfe, ob genügend Symbole nebeneinander in einer Zeile sind
      for (int j = 0; j < game.winSeries; j++) {
        if ((j * game.fieldMultiplier) + i < game.fields.length &&
            game.fields[(j * game.fieldMultiplier) + i].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          break;
        }
      }
      winStreak = 0;
      // Prüfe, ob genügend Symbole quer nach rechts sind
      for (int j = 0; j < game.winSeries; j++) {
        if ((j * game.fieldMultiplier) + i + j < game.fields.length &&
            game.fields[(j * game.fieldMultiplier) + i + j].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          break;
        }
      }
      winStreak = 0;
      // Prüfe, ob genügend Symbole quer nach links sind
      for (int j = 0; j < game.winSeries; j++) {
        if ((j * game.fieldMultiplier) + i - j < game.fields.length &&
            game.fields[(j * game.fieldMultiplier) + i - j].symbol.contains('X')) {
          winStreak++;
          if (game.winSeries == winStreak) {
            game.gameIsFinished = true;
            game.playerHasWon = true;
            return 10;
          }
        } else {
          break;
        }
      }
    }
    return 0;*/
  }

  void setField(final int row, final int col) {
    for (int i = 0; i < game.playerOneGamePieces.length; i++) {
      if (game.playerOneGamePieces[i].isSelected || game.playerTwoGamePieces[i].isSelected) {
        game.gamePieceSelected = true;
        break;
      }
    }
    if (game.currentRound % 2 == 0) {
      if (setGamePieceToField(game.playerOneGamePieces, game.playerOneLevelMap, row, col)) {
        checkIfGameIsFinished('X');
      }
    } else {
      if (setGamePieceToField(game.playerTwoGamePieces, game.playerTwoLevelMap, row, col)) {
        checkIfGameIsFinished('O');
      }
    }
    if (widget.activateArtificialIntelligence) {
      miniMax(game.fields, 1, false);
    }
  }

  bool setGamePieceToField(List<GamePiece> gamePieceList, Map levelMap, final int row, final int col) {
    for (int i = 0; i < gamePieceList.length; i++) {
      if (gamePieceList[i].isSelected) {
        if (levelMap.keys.elementAt(i) > game.fields[row][col].currentLevel) {
          game.fields[row][col].symbol = gamePieceList[i].symbol;
          gamePieceList[i].isSelected = false;
          game.fields[row][col].currentLevel = levelMap.keys.elementAt(i);
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
      if (game.fields[i][0].symbol == '') {
        continue;
      }
      int line = (i ~/ game.fieldMultiplier) + 1;
      lineBorder = line * game.fieldMultiplier;
      winStreak = 0;
      // Prüfe, ob genügend Symbole nebeneinander in einer Reihe sind
      for (int j = 0; j < game.winSeries; j++) {
        if (i + j < lineBorder && game.fields[i + j][0].symbol.contains(checkedSymbol)) {
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
            game.fields[(j * game.fieldMultiplier) + i][0].symbol.contains(checkedSymbol)) {
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
            game.fields[(j * game.fieldMultiplier) + i + j][0].symbol.contains(checkedSymbol)) {
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
            game.fields[(j * game.fieldMultiplier) + i - j][0].symbol.contains(checkedSymbol)) {
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
                        crossAxisCount: game.fields.length,
                        shrinkWrap: true,
                        children: [
                          for (int row = 0; row < game.fields.length; row++)
                            for (int col = 0; col < game.fields[0].length; col++)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white54),
                                ),
                                child: InkWell(
                                  onTap: () => setField(row, col),
                                  child: Center(
                                    child: Text(
                                      game.fields[row][col].symbol,
                                      style: TextStyle(fontSize: 12.0 * game.fields[row][col].currentLevel),
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
