import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/screens/home_screen.dart';
import '/screens/game_screen.dart';

import '/utils/constants/route_constants.dart';

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
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      routes: {
        homeRoute: (context) => const HomeScreen(),
        gameRoute: (context) => const GameScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
