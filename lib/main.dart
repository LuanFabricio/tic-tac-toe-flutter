import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/game.dart';

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
  var tictactoe = TicTacToe();

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
                          TicTacToe.valueToString(tictactoe.getValue(index)),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        )),
                      ));
                })));
  }

  Future<void> _onRefresh() async {
    _refresh();
  }

  void _refresh() {
    setState(() {
      isX = false;
      tictactoe.reset();
    });
  }

  void _tapped(int index) {
    setState(() {
      final piece = isX ? TicTacToe.xBits : TicTacToe.oBits;

      if (tictactoe.insert(index, piece)) {
        isX = !isX;
      }

      if (_haveSomeOneWon()) {
        final winner = isX ? 'O' : 'X';
        debugPrint("Winner: $winner");

        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("We have a winner!"),
                  content: Text("The $winner player has won!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          _refresh();
                          Navigator.pop(context);
                        },
                        child: const Text("Ok")),
                  ],
                ));
      }
    });
  }

  bool _haveSomeOneWon() {
    if (tictactoe.columnWin(0) ||
        tictactoe.columnWin(1) ||
        tictactoe.columnWin(2)) {
      return true;
    }

    if (tictactoe.rowWin(0) || tictactoe.rowWin(1) || tictactoe.rowWin(2)) {
      return true;
    }

    return tictactoe.diagonalWin();
  }
}
