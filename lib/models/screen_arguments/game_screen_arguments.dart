class GameScreenArguments {
  final int winSerie;
  final int fieldMultiplier;
  final List<int> playerOneGamePieceLevel;
  final List<int> playerTwoGamePieceLevel;
  final bool activateArtificialIntelligence;

  GameScreenArguments({
    required this.winSerie,
    required this.fieldMultiplier,
    required this.playerOneGamePieceLevel,
    required this.playerTwoGamePieceLevel,
    required this.activateArtificialIntelligence,
  });
}
