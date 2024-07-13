import 'dart:math';

import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({
    super.key,
    required this.onTapFn,
    required this.choice,
    required this.playMode,
  });
  final Function onTapFn;
  final String choice;
  final String playMode;

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List data = ["1", "2", "3", "4", "5", "6", "7", "8", "9"];

  List winPatterns = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  bool turnX = true;
  dynamic winner;
  dynamic count = 0;

  @override
  void initState() {
    super.initState();
    turnX = (widget.choice == "X") ? true : false;
  }

  checkWinner() {
    for (var i = 0; i < winPatterns.length; i++) {
      if (data[winPatterns[i][0]] == data[winPatterns[i][1]] &&
          data[winPatterns[i][1]] == data[winPatterns[i][2]]) {
        if (data[winPatterns[i][0]] == "X") {
          return "X";
        } else if (data[winPatterns[i][0]] == "0") {
          return "0";
        }
      }
    }
    return "";
  }

  cpuMove() {
    List<int> emptyCells = [];
    for (int i = 0; i < data.length; i++) {
      if (data[i] != "X" && data[i] != "0") {
        emptyCells.add(i);
      }
    }

    if (emptyCells.isNotEmpty) {

      int randomCell = emptyCells[Random().nextInt(emptyCells.length)];
      data[randomCell] = (widget.choice == "X") ? "0" : "X";
      (widget.choice == "X") ? turnX = true : turnX = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: Image.asset(
          "assets/images/TicTacToe.png",
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 49, 49, 49).withOpacity(0.5)),
            height: MediaQuery.of(context).size.height / 12,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Text("${turnX ? "X" : "0"}'s turn",
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white)),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            margin: const EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 3,
              children: [
                ...data.map((el) {
                  return InkWell(
                    onTap: () {
                      // PLAYER VS PLAYER MODE
                      if (widget.playMode == "Vs Player" &&
                          data[data.indexOf(el)] != "X" &&
                          data[data.indexOf(el)] != "0") {
                        setState(() {
                          if (turnX == true) {
                            data[data.indexOf(el)] = "X";
                            turnX = false;
                          } else {
                            data[data.indexOf(el)] = "0";
                            turnX = true;
                          }
                          winner = checkWinner();
                          count++;
                          if (winner != "" || count == 9) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        const Color.fromARGB(184, 0, 0, 0),
                                    content: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: 350,
                                          minHeight:
                                              250), // Set the minimum width and height of the dialog
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the contents vertically
                                        children: [
                                          Text(
                                            (winner == "")
                                                ? "Game Drawn!"
                                                : "$winner wins!",
                                            textAlign: TextAlign
                                                .center, // Center the text horizontally
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                              height: 40), // Add some spacing
                                          OutlinedButton(
                                            onPressed: () {
                                              //  play again login here // redirect to the home screen
                                              widget.onTapFn(widget.choice,
                                                  widget.playMode);
                                            },
                                            style: const ButtonStyle(
                                                padding: WidgetStatePropertyAll(
                                                    EdgeInsets.all(25)),
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 73, 73, 72),
                                                )),
                                            child: const Text(
                                              "Play Again!",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.amberAccent),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        });
                      }
                      // PLAYER VS CPU MODE
                      else if (widget.playMode == "Vs Computer" &&
                          data[data.indexOf(el)] != "X" &&
                          data[data.indexOf(el)] != "0") {
                        setState(() {
                          if (turnX == true) {
                            data[data.indexOf(el)] = "X";
                            turnX = false;
                          } else {
                            data[data.indexOf(el)] = "0";
                            turnX = true;
                          }

                          winner = checkWinner();
                          if (count < 9 && winner == "") {
                            cpuMove();
                          }
                          winner = checkWinner();

                          count++;
                          if (winner != "" || count == 9) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor:
                                        const Color.fromARGB(184, 0, 0, 0),
                                    content: ConstrainedBox(
                                      constraints: const BoxConstraints(
                                          minWidth: 350,
                                          minHeight:
                                              250), // Set the minimum width and height of the dialog
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Center the contents vertically
                                        children: [
                                          Text(
                                            (winner == "")
                                                ? "Game Drawn!"
                                                : (winner == widget.choice)
                                                    ? "Player Wins"
                                                    : "CPU Wins",
                                            textAlign: TextAlign
                                                .center, // Center the text horizontally
                                            style: const TextStyle(
                                                fontSize: 40,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                              height: 40), // Add some spacing
                                          OutlinedButton(
                                            onPressed: () {
                                              //  play again login here // redirect to the home screen
                                              widget.onTapFn(widget.choice,
                                                  widget.playMode);
                                              Navigator.pop(context);
                                            },
                                            style: const ButtonStyle(
                                                padding: WidgetStatePropertyAll(
                                                    EdgeInsets.all(25)),
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 73, 73, 72),
                                                )),
                                            child: const Text(
                                              "Play Again!",
                                              style: TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.amberAccent),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }
                        });
                      } else
                        () {};
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                          color: const Color.fromARGB(255, 16, 0, 81),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              borderRadius: BorderRadius.circular(30))),
                      child: Text(el,
                          style: const TextStyle(
                              fontSize: 30, color: Colors.white)),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
