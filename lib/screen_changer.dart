import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home_screen.dart';
import 'package:tic_tac_toe/tic_tac_toe.dart';

class ScreenChanger extends StatefulWidget {
  const ScreenChanger({super.key});

  @override
  State<ScreenChanger> createState() => _ScreenChangerState();
}

class _ScreenChangerState extends State<ScreenChanger> {
  // note that the screen changer approach is only good for small apps with 2 3 screens
  // for larger apps, use navigator
  var currScreen = "home";
  late String playerChoice;
  late String mode;

  screenChange(String symbol, String gameMode) {
    setState(() {
       playerChoice = symbol;
       mode = gameMode;
      (currScreen == "home") ? currScreen = "game" : currScreen = "home";
    });
  }

  @override
  Widget build(BuildContext context) {
    return (currScreen == "home")
        ? HomeScreen(onTapFn: screenChange)
        : TicTacToe(onTapFn: screenChange, choice : playerChoice, playMode: mode);
  }
}
