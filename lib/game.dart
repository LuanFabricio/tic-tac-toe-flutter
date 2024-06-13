import 'package:flutter/material.dart';

class TicTacToe {
  ///  3 estados -> vazio, x, o
  ///  00 -> vazio
  ///  01 -> x
  ///  10 -> o
  ///  11 -> vazio (no futuro pode indicar se a o jogador ganhou ou nao
  ///  9  2bits = 18 bits => 2 bytes 2 bits => 3 bytes)

  /// 0 -> 0b11
  /// 1 -> 0b11 << 2
  // Uint8List board = Uint8List(3);
  int board = 0;
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
    int val = (board & _indexMask(index)) >> _indexShift(index);

    var boardStr = board.toRadixString(2).padLeft(32, "0");
    debugPrint("Board: 0b$boardStr");
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

  /// index: Column index [0, 1, 2].
  bool columnWin(int columnIndex) {
    /*
       01 00 00
       01 00 00
       01 00 00

       pivot = 01 = (board & 11)
       if pivot == (00 | 11) return false;

       mask = (pivot) | (pivot << (2*1)) | (pivot << (2*2))
       return (mask & board) != 0;
     */
    int pivot = (board & _indexMask(columnIndex)) >> _indexShift(columnIndex);
    if (pivot != oBits && pivot != xBits) return false;

    int mask = (pivot) << _indexShift(columnIndex) |
        (pivot << _indexShift(columnIndex + 3)) |
        (pivot << _indexShift(columnIndex + 6));
    var boardStr = board.toRadixString(2).padLeft(32, "0");
    debugPrint("[Col] Board:\t\t0b$boardStr");
    var maskStr = mask.toRadixString(2).padLeft(32, "0");
    debugPrint("[Col] Mask:\t\t0b$maskStr");
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
    var boardStr = board.toRadixString(2).padLeft(32, "0");
    debugPrint("[Row] Board:\t\t0b$boardStr");
    var maskStr = mask.toRadixString(2).padLeft(32, "0");
    debugPrint("[Row] Mask:\t\t0b$maskStr");
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
