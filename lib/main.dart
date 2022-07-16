import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/screens/home_screen.dart';
import '/screens/single_player_game_selection_screen.dart';
import '/screens/game_screen.dart';

import '/models/screen_arguments/game_screen_arguments.dart';

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
        singlePlayerGameSelectionRoute: (context) => const SinglePlayerGameSelectionScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case gameRoute:
            final args = settings.arguments as GameScreenArguments;
            return MaterialPageRoute<String>(
              builder: (BuildContext context) => GameScreen(
                winSerie: args.winSerie,
                fieldMultiplier: args.fieldMultiplier,
                playerOneGamePieceLevel: args.playerOneGamePieceLevel,
                playerTwoGamePieceLevel: args.playerTwoGamePieceLevel,
              ),
              settings: settings,
            );
          default:
            return null;
        }
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
