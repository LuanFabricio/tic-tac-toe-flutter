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

  group("reset", () {
    test("Should reset board field to 0", () {
      final game = TicTacToe.optional(42);

      expect(game.board, isNot(0));

      game.reset();
      expect(game.board, 0);
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

  group("valueToString", () {
    test("Should cast xBits to 'x' string", () {
      String xString = TicTacToe.valuetToString(TicTacToe.xBits);
      expect(xString, 'x');
    });

    test("Should cast oBits to 'o' string", () {
      String oString = TicTacToe.valuetToString(TicTacToe.oBits);
      expect(oString, 'o');
    });

    test("Should cast other values empty string", () {
      String empty = TicTacToe.valuetToString(0); // 0b00
      expect(empty, '');

      empty = TicTacToe.valuetToString(3); // 0b11
      expect(empty, '');
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
    group("rowWin", () {
      test("X should can win", () {
        final game = TicTacToe();

        final rows = [0, 1, 2];
        final insertions = [
          [0, 1, 2],
          [3, 4, 5],
          [6, 7, 8],
        ];
        bool expectedResult;
        for (final (index, testingRow) in rows.indexed) {
          game.reset();
          expectedResult = false;
          for (final grid in insertions[index]) {
            expect(game.rowWin(testingRow), expectedResult);
            game.insert(grid, TicTacToe.xBits);
          }
          expectedResult = true;
          expect(game.rowWin(testingRow), expectedResult);
        }
      });

      test("O should can win", () {
        final game = TicTacToe();

        final rows = [0, 1, 2];
        final insertions = [
          [0, 1, 2],
          [3, 4, 5],
          [6, 7, 8],
        ];
        bool expectedResult;
        for (final (index, testingRow) in rows.indexed) {
          game.reset();
          expectedResult = false;
          for (final grid in insertions[index]) {
            expect(game.rowWin(testingRow), expectedResult);
            game.insert(grid, TicTacToe.oBits);
          }
          expectedResult = true;
          expect(game.rowWin(testingRow), expectedResult);
        }
      });
    });

    group("colWin", () {
      test("X should can win", () {
        final game = TicTacToe();

        final cols = [0, 1, 2];
        final insertions = [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8],
        ];
        bool expectedResult;
        for (final (index, testingCol) in cols.indexed) {
          game.reset();
          expectedResult = false;
          for (final grid in insertions[index]) {
            expect(game.columnWin(testingCol), expectedResult);
            game.insert(grid, TicTacToe.xBits);
          }
          expectedResult = true;
          expect(game.columnWin(testingCol), expectedResult);
        }
      });

      test("O should can win", () {
        final game = TicTacToe();

        final cols = [0, 1, 2];
        final insertions = [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8],
        ];
        bool expectedResult;
        for (final (index, testingCol) in cols.indexed) {
          game.reset();
          expectedResult = false;
          for (final grid in insertions[index]) {
            expect(game.columnWin(testingCol), expectedResult);
            game.insert(grid, TicTacToe.oBits);
          }
          expectedResult = true;
          expect(game.columnWin(testingCol), expectedResult);
        }
      });

      group("diagonalWin", () {
        test("X should can win", () {
          final game = TicTacToe();

          final insertions = [
            [0, 4, 8],
            [2, 4, 6],
          ];
          bool expectedResult;
          for (final testingValues in insertions) {
            game.reset();
            expectedResult = false;
            for (final grid in testingValues) {
              expect(game.diagonalWin(), expectedResult);
              game.insert(grid, TicTacToe.xBits);
            }
            expectedResult = true;
            expect(game.diagonalWin(), expectedResult);
          }
        });

        test("O should can win", () {
          final game = TicTacToe();

          final insertions = [
            [0, 4, 8],
            [2, 4, 6],
          ];
          bool expectedResult;
          for (final testingValues in insertions) {
            game.reset();
            expectedResult = false;
            for (final grid in testingValues) {
              expect(game.diagonalWin(), expectedResult);
              game.insert(grid, TicTacToe.oBits);
            }
            expectedResult = true;
            expect(game.diagonalWin(), expectedResult);
          }
        });
      });
    });
  });
}
