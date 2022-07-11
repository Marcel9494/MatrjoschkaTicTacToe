import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matrjoschka_tictactoe/screens/game_screen.dart';

import '/screens/home_screen.dart';

void main() {
  runApp(const MatrjoschkaTicTacToe());
}

class MatrjoschkaTicTacToe extends StatelessWidget {
  const MatrjoschkaTicTacToe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Matrjoschka Tic Tac Toe',
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/game': (context) => const GameScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
