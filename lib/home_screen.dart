import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onTapFn});
  final Function onTapFn;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropdownval = "X";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/TicTacToe.png",
              height: 250,
              width: 250,
            ),
            const Text(
              "Tic Tac Toe",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Select your symbol: "),
                DropdownButton(
                    value: dropdownval,
                    items: const [
                      DropdownMenuItem(
                        value: "0",
                        child: Text("0"),
                      ),
                      DropdownMenuItem(value: "X", child: Text("X"))
                    ],
                    onChanged: (value) {
                      setState(() {
                        dropdownval = value.toString();
                      });
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      widget.onTapFn(dropdownval,"Vs Computer");
                    },
                    child: const Text("Vs Computer")),
                const SizedBox(width: 20),
                OutlinedButton(
                    onPressed: () {
                      widget.onTapFn(dropdownval,"Vs Player");
                    },
                    child: const Text("Vs Player")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
