class TicTacToe {
  /// Every 2 bits have 3 states
  /// 01 -> x
  /// 10 -> o
  /// 00, 11 -> Empty
  int board = 0;
  static const xBits = 1;
  static const oBits = 2;

  TicTacToe();
  TicTacToe.optional([this.board = 0]);

  int _indexShift(int index) {
    return (2 * index);
  }

  int _indexMask(int index) {
    return 3 << _indexShift(index); // 0b11 << _indexShift(index)
  }

  void reset() {
    board = 0;
  }

  int getValue(int index) {
    int val = (board & _indexMask(index)) >> _indexShift(index);
    return val;
  }

  String boardToString() {
    String boardString = "";
    for (int i = 0; i < 9; i++) {
      boardString += valueToString(getValue(i));
    }
    return boardString;
  }

  static String valueToString(int value) {
    String valueString = ' ';
    switch (value) {
      case xBits:
        valueString = 'x';
        break;
      case oBits:
        valueString = 'o';
        break;
    }
    return valueString;
  }

  bool insert(int index, int value) {
    int currentValue = board & _indexMask(index);
    if (currentValue == xBits || currentValue == oBits) {
      return false;
    }

    board |= value << _indexShift(index);
    return true;
  }

  bool someOneWon() {
    bool colWin = columnWin(0) || columnWin(1) || columnWin(2);
    if (colWin) {
      return true;
    }

    return false;
  }

  bool gameWin() {
    bool win = columnWin(0) || columnWin(1) || columnWin(2);
    if (win) return win;

    win = rowWin(0) || rowWin(1) || rowWin(2);
    if (win) return win;

    return diagonalWin();
  }

  /// index: Column index [0, 1, 2].
  bool columnWin(int columnIndex) {
    int pivot = (board & _indexMask(columnIndex)) >> _indexShift(columnIndex);
    if (pivot != oBits && pivot != xBits) return false;

    int mask = (pivot) << _indexShift(columnIndex) |
        (pivot << _indexShift(columnIndex + 3)) |
        (pivot << _indexShift(columnIndex + 6));
    return (board & mask) == mask;
  }

  /// index: Row index [0, 1, 2].
  bool rowWin(int rowIndex) {
    int index = rowIndex * 3;
    int pivot = (board & _indexMask(index)) >> _indexShift(index);
    if (pivot != oBits && pivot != xBits) return false;

    int mask = (pivot) << _indexShift(index) |
        (pivot << _indexShift(index + 1)) |
        (pivot << _indexShift(index + 2));
    return (board & mask) == mask;
  }

  bool diagonalWin() {
    int index = 0;
    int pivot = (board & _indexMask(index)) >> _indexShift(index);
    bool won = pivot != oBits && pivot != xBits;

    int mask = (pivot << _indexShift(index)) |
        (pivot << _indexShift(index + 4)) |
        (pivot << _indexShift(index + 8));
    won = !won && ((mask & board) == mask);
    if (won) return true;

    index = 2;
    pivot = (board & _indexMask(index)) >> _indexShift(index);
    if (pivot != oBits && pivot != xBits) return false;
    mask = (pivot << _indexShift(index)) |
        (pivot << _indexShift(index + 2)) |
        (pivot << _indexShift(index + 4));

    return (mask & board) == mask;
  }
}
