class GamePiece {
  late final int level;
  late String symbol;
  late bool isSelected;

  GamePiece(int lvl, String sym) {
    level = lvl;
    symbol = sym;
    isSelected = false;
  }
}
