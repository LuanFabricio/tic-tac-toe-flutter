import 'package:tic_tac_toe_app/game.dart';
import 'package:test/test.dart';

void main() {
  group("Constructor", () {
    test("The default constructor should initialize the board with 0", () {
      final game = TicTacToe();

      const expectedBoardValue = 0;
      expect(game.board, expectedBoardValue);
    });

    test(
        "The optional constructor should initialize the board with the argument",
        () {
      const boardValue = 42;
      final game = TicTacToe.optional(42);

      expect(game.board, boardValue);
    });
  });

  group("getValue", () {
    test("getValue should return the content of a cell", () {
      // Starts with the grid equal to x (from top left to bottom right)
      final game = TicTacToe.optional(TicTacToe.xBits);

      const expectedValue = 1;
      expect(game.getValue(0), expectedValue);
    });
  });

  group("insert", () {
    test(
        "If the grid is empty, the insert method should update the board and return true",
        () {
      final game = TicTacToe();

      const gridPosition = 0;
      const gridValue = TicTacToe.xBits;
      bool res = game.insert(gridPosition, gridValue);

      bool expectedRes = true;
      expect(res, expectedRes);

      const expectedGridValue = gridValue;
      expect(game.getValue(gridPosition), expectedGridValue);
    });

    test(
        "If the grid have something, the insert method should'nt update the board and return false",
        () {
      const gridValue = TicTacToe.xBits;
      final game = TicTacToe.optional(gridValue);

      const gridPosition = 0;
      const insertedGridValue = TicTacToe.oBits;
      bool res = game.insert(gridPosition, insertedGridValue);

      bool expectedRes = false;
      expect(res, expectedRes);

      const expectedGridValue = gridValue;
      expect(game.getValue(gridPosition), expectedGridValue);
    });
  });

  group("Game finished", () {
    group("rowWin", () {});
  });
}
