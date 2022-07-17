import 'package:flutter/material.dart';

import '/models/screen_arguments/single_player_game_selection_screen_arguments.dart';

import '/utils/constants/route_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                singlePlayerGameSelectionRoute,
                arguments: SinglePlayerGameSelectionScreenArguments(
                  activateArtificialIntelligence: false,
                ),
              ),
              child: const Text('Spieler vs. Spieler'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                singlePlayerGameSelectionRoute,
                arguments: SinglePlayerGameSelectionScreenArguments(
                  activateArtificialIntelligence: true,
                ),
              ),
              child: const Text('Spieler vs. Computer'),
            ),
          ),
        ],
      ),
    );
  }
}
