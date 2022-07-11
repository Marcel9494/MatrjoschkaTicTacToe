class Field {
  late final int _fieldNumber;
  late int currentLevel;
  late bool isOccupied;
  late String symbol;

  Field(int fieldNum) {
    _fieldNumber = fieldNum;
    currentLevel = 0;
    isOccupied = false;
    symbol = '';
  }

  int get fieldNumber => _fieldNumber;
}
