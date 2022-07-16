import 'field_model.dart';
import 'game_piece_model.dart';

class Game {
  late bool gamePieceSelected;
  late bool gameIsFinished;
  late bool playerHasWon;
  late int currentRound;
  late int maxRounds;
  late int winSeries;
  late int fieldMultiplier;
  late List<Field> fields;
  late List<int> playerOneGamePieceLevel;
  late List<int> playerTwoGamePieceLevel;
  late List<GamePiece> playerOneGamePieces;
  late List<GamePiece> playerTwoGamePieces;
  late Map playerOneLevelMap;
  late Map playerTwoLevelMap;

  Game({
    required int winSerie,
    required int fieldMulti,
    required List<int> playerOneGamePieceLvl,
    required List<int> playerTwoGamePieceLvl,
  }) {
    gamePieceSelected = false;
    gameIsFinished = false;
    playerHasWon = false;
    currentRound = 1;
    winSeries = winSerie;
    fieldMultiplier = fieldMulti;
    playerOneGamePieceLevel = playerOneGamePieceLvl;
    playerTwoGamePieceLevel = playerTwoGamePieceLvl;
    fields = List<Field>.generate(fieldMultiplier * fieldMultiplier, ((_) => (Field())));
    // Spieler 1 Werte setzen
    playerOneGamePieces = List<GamePiece>.filled(playerOneGamePieceLevel.length, GamePiece(0, ''), growable: false);
    playerOneLevelMap = {};
    for (int i = 0; i < playerOneGamePieceLevel.length; i++) {
      playerOneGamePieces[i] = GamePiece(playerOneGamePieceLevel[i], 'X');
      if (playerOneLevelMap[playerOneGamePieces[i].level] == null) {
        playerOneLevelMap[playerOneGamePieces[i].level] = 0;
      }
      playerOneLevelMap[playerOneGamePieces[i].level]++;
    }
    // Spieler 2 Werte setzen
    playerTwoGamePieces = List<GamePiece>.filled(playerTwoGamePieceLevel.length, GamePiece(0, ''), growable: false);
    playerTwoLevelMap = {};
    for (int i = 0; i < playerTwoGamePieceLevel.length; i++) {
      playerTwoGamePieces[i] = GamePiece(playerTwoGamePieceLevel[i], 'O');
      if (playerTwoLevelMap[playerTwoGamePieces[i].level] == null) {
        playerTwoLevelMap[playerTwoGamePieces[i].level] = 0;
      }
      playerTwoLevelMap[playerTwoGamePieces[i].level]++;
    }
    maxRounds = playerOneGamePieces.length + playerTwoGamePieces.length;
  }
}
