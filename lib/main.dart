import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isX = false;
  List<String> board = List<String>.filled(9, '', growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: RefreshIndicator(
            onRefresh: _onRefresh,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        _tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Center(
                            child: Text(
                          board[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        )),
                      ));
                })));
  }

  Future<void> _onRefresh() async {
    setState(() {
      board = List<String>.filled(9, '', growable: false);
    });
  }

  void _tapped(int index) {
    setState(() {
      String piece = isX ? "x" : "o";

      if (_placePiece(index, piece)) {
        isX = !isX;
      }

      int winner = _haveSomeOneWon();
      if (winner != -1) {
        board = board.map((e) => winner.toString()).toList();
      }
    });
  }

  bool _placePiece(int index, String piece) {
    if (board[index].compareTo("") == 0) {
      board[index] = piece;
      return true;
    }
    return false;
  }

  int _haveSomeOneWon() {
    int winner = isX ? 0 : 1;

    if (_haveSameOnLine(0) || _haveSameOnLine(3) || _haveSameOnLine(6)) {
      return winner;
    }

    if (_haveSameOnColumn(0) || _haveSameOnColumn(1) || _haveSameOnColumn(2)) {
      return winner;
    }

    if (_haveSameOnDiagonalLeftRight() || _haveSameOnDiagonalRightLeft()) {
      return winner;
    }

    return -1;
  }

  bool _haveSameOnLine(int init) {
    bool line = true;
    int s, e;
    String cs, ce;
    for (int i = 0; i < 2; i++) {
      s = i + init;
      e = i + init + 1;
      cs = board[s];
      ce = board[e];
      line &= cs.compareTo(ce) == 0;
    }

    bool isNotEmpty = board[init].compareTo("") != 0;
    return line && isNotEmpty;
  }

  bool _haveSameOnColumn(int init) {
    bool column = true;
    int s, e;
    String cs, ce;
    for (int i = 0; i < 2; i++) {
      s = i * 3 + init;
      e = (i + 1) * 3 + init;
      cs = board[s];
      ce = board[e];
      column &= cs.compareTo(ce) == 0;
    }

    bool isNotEmpty = board[init].compareTo("") != 0;
    return column && isNotEmpty;
  }

  bool _haveSameOnDiagonalLeftRight() {
    return board[0].compareTo("") != 0 &&
        board[0].compareTo(board[4]) == 0 &&
        board[0].compareTo(board[8]) == 0;
  }

  bool _haveSameOnDiagonalRightLeft() {
    return board[2].compareTo("") != 0 &&
        board[2].compareTo(board[4]) == 0 &&
        board[2].compareTo(board[6]) == 0;
  }
}
