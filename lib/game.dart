class TicTacToe {
  /// Every 2 bits have 3 states
  /// 01 -> x
  /// 10 -> o
  /// 00, 11 -> Empty
  int _board = 0;
  static const xBits = 1;
  static const oBits = 2;

  TicTacToe();

  int _indexShift(int index) {
    return (2 * index);
  }

  int _indexMask(int index) {
    return 3 << _indexShift(index); // 0b11 << _indexShift(index)
  }

  int getValue(int index) {
    int val = (_board & _indexMask(index)) >> _indexShift(index);
    return val;
  }

  String valuetToString(int value) {
    String valueString = '';
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
    int currentValue = _board & _indexMask(index);
    if (currentValue == xBits || currentValue == oBits) {
      return false;
    }

    _board |= value << _indexShift(index);
    return true;
  }

  bool someOneWon() {
    bool colWin = columnWin(0) || columnWin(1) || columnWin(2);
    if (colWin) {
      return true;
    }

    return false;
  }

  /// index: Column index [0, 1, 2].
  bool columnWin(int columnIndex) {
    int pivot = (_board & _indexMask(columnIndex)) >> _indexShift(columnIndex);
    if (pivot != oBits && pivot != xBits) return false;

    int mask = (pivot) << _indexShift(columnIndex) |
        (pivot << _indexShift(columnIndex + 3)) |
        (pivot << _indexShift(columnIndex + 6));
    return (_board & mask) == mask;
  }

  /// index: Row index [0, 1, 2].
  bool rowWin(int rowIndex) {
    int index = rowIndex * 3;
    int pivot = (_board & _indexMask(index)) >> _indexShift(index);
    if (pivot != oBits && pivot != xBits) return false;

    int mask = (pivot) << _indexShift(index) |
        (pivot << _indexShift(index + 1)) |
        (pivot << _indexShift(index + 2));
    return (_board & mask) == mask;
  }

  bool diagonalWin() {
    int index = 0;
    int pivot = (_board & _indexMask(index)) >> _indexShift(index);
    bool won = pivot != oBits && pivot != xBits;

    int mask = (pivot << _indexShift(index)) |
        (pivot << _indexShift(index + 4)) |
        (pivot << _indexShift(index + 8));
    won = !won && ((mask & _board) == mask);
    if (won) return true;

    index = 2;
    pivot = (_board & _indexMask(index)) >> _indexShift(index);
    if (pivot != oBits && pivot != xBits) return false;
    mask = (pivot << _indexShift(index)) |
        (pivot << _indexShift(index + 2)) |
        (pivot << _indexShift(index + 4));

    return (mask & _board) == mask;
  }
}
