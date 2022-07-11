import 'package:flutter/material.dart';

import '/models/game_model.dart';
import '/models/field_model.dart';
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
  late List<Field> fields;
  late bool gamePieceSelected;
  late Map playerOneLevelMap;
  late Map playerTwoLevelMap;
  late List<GamePiece> playerOneGamePieces;
  late List<GamePiece> playerTwoGamePieces;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    game = Game();
    // Spieler 1 Werte setzen
    playerOneGamePieces = List<GamePiece>.filled(6, GamePiece(0, ''), growable: false);
    playerOneGamePieces[0] = GamePiece(1, 'X');
    playerOneGamePieces[1] = GamePiece(1, 'X');
    playerOneGamePieces[2] = GamePiece(3, 'X');
    playerOneGamePieces[3] = GamePiece(3, 'X');
    playerOneGamePieces[4] = GamePiece(5, 'X');
    playerOneGamePieces[5] = GamePiece(5, 'X');
    playerOneLevelMap = {};
    for (int i = 0; i < playerOneGamePieces.length; i++) {
      if (playerOneLevelMap[playerOneGamePieces[i].level] == null) {
        playerOneLevelMap[playerOneGamePieces[i].level] = 0;
      }
      playerOneLevelMap[playerOneGamePieces[i].level]++;
    }
    // Spieler 2 Werte setzen
    playerTwoGamePieces = List<GamePiece>.filled(6, GamePiece(0, ''), growable: false);
    playerTwoGamePieces[0] = GamePiece(1, 'O');
    playerTwoGamePieces[1] = GamePiece(1, 'O');
    playerTwoGamePieces[2] = GamePiece(3, 'O');
    playerTwoGamePieces[3] = GamePiece(3, 'O');
    playerTwoGamePieces[4] = GamePiece(5, 'O');
    playerTwoGamePieces[5] = GamePiece(5, 'O');
    playerTwoLevelMap = {};
    for (int i = 0; i < playerTwoGamePieces.length; i++) {
      if (playerTwoLevelMap[playerTwoGamePieces[i].level] == null) {
        playerTwoLevelMap[playerTwoGamePieces[i].level] = 0;
      }
      playerTwoLevelMap[playerTwoGamePieces[i].level]++;
    }
    gamePieceSelected = false;
    setState(() {
      fields = List<Field>.generate(9, (i) => (Field(i)));
    });
  }

  void setField(final int fieldNumber) {
    for (int i = 0; i < playerOneGamePieces.length; i++) {
      if (playerOneGamePieces[i].isSelected || playerTwoGamePieces[i].isSelected) {
        gamePieceSelected = true;
        break;
      }
    }
    if (game.round % 2 == 0) {
      if (setGamePieceToField(playerOneGamePieces, playerOneLevelMap, fieldNumber)) {
        if (isGameFinished() == false) {
          if (gamePieceSelected) {
            gamePieceSelected = false;
            game.round++;
          }
        }
      }
    } else {
      if (setGamePieceToField(playerTwoGamePieces, playerTwoLevelMap, fieldNumber)) {
        if (isGameFinished() == false) {
          if (gamePieceSelected) {
            gamePieceSelected = false;
            game.round++;
          }
        }
      }
    }
    setState(() {});
  }

  bool setGamePieceToField(List<GamePiece> gamePieceList, Map levelMap, final int fieldNumber) {
    for (int i = 0; i < gamePieceList.length; i++) {
      if (gamePieceList[i].isSelected) {
        if (levelMap.keys.elementAt(i) > fields[fieldNumber].currentLevel) {
          fields[fieldNumber].symbol = gamePieceList[i].symbol;
          gamePieceList[i].isSelected = false;
          fields[fieldNumber].currentLevel = levelMap.keys.elementAt(i);
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

  bool isGameFinished() {
    if (fields[0].symbol.contains('X') && fields[1].symbol.contains('X') && fields[2].symbol.contains('X') ||
        fields[0].symbol.contains('O') && fields[1].symbol.contains('O') && fields[2].symbol.contains('O') ||
        fields[3].symbol.contains('X') && fields[4].symbol.contains('X') && fields[5].symbol.contains('X') ||
        fields[3].symbol.contains('O') && fields[4].symbol.contains('O') && fields[5].symbol.contains('O') ||
        fields[6].symbol.contains('X') && fields[7].symbol.contains('X') && fields[8].symbol.contains('X') ||
        fields[6].symbol.contains('O') && fields[7].symbol.contains('O') && fields[8].symbol.contains('O') ||
        fields[0].symbol.contains('X') && fields[3].symbol.contains('X') && fields[6].symbol.contains('X') ||
        fields[0].symbol.contains('O') && fields[3].symbol.contains('O') && fields[6].symbol.contains('O') ||
        fields[1].symbol.contains('X') && fields[4].symbol.contains('X') && fields[7].symbol.contains('X') ||
        fields[1].symbol.contains('O') && fields[4].symbol.contains('O') && fields[7].symbol.contains('O') ||
        fields[2].symbol.contains('X') && fields[5].symbol.contains('X') && fields[8].symbol.contains('X') ||
        fields[2].symbol.contains('O') && fields[5].symbol.contains('O') && fields[8].symbol.contains('O') ||
        fields[0].symbol.contains('X') && fields[4].symbol.contains('X') && fields[8].symbol.contains('X') ||
        fields[0].symbol.contains('O') && fields[4].symbol.contains('O') && fields[8].symbol.contains('O') ||
        fields[2].symbol.contains('X') && fields[4].symbol.contains('X') && fields[6].symbol.contains('X') ||
        fields[2].symbol.contains('O') && fields[4].symbol.contains('O') && fields[6].symbol.contains('O')) {
      setState(() {
        game.gameIsFinished = true;
        game.playerHasWon = true;
      });
      return true;
    } else if (game.round == playerOneGamePieces.length + playerTwoGamePieces.length) {
      setState(() {
        game.gameIsFinished = true;
      });
      return true;
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
              gamePieceList: playerOneGamePieces,
              activePlayer: game.round % 2 == 0,
              levelMap: playerOneLevelMap,
            ),
            GameBoard(
              fields: fields,
              onTap: setField,
            ),
            GamePieceList(
              gamePieceList: playerTwoGamePieces,
              activePlayer: game.round % 2 == 1,
              levelMap: playerTwoLevelMap,
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
