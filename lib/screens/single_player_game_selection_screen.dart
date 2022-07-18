import 'package:flutter/material.dart';

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';

import '/widgets/lists/game_piece_list.dart';

import '/models/game_model.dart';
import '/models/screen_arguments/game_screen_arguments.dart';

import '/utils/constants/route_constants.dart';

class SinglePlayerGameSelectionScreen extends StatefulWidget {
  final bool activateArtificialIntelligence;

  const SinglePlayerGameSelectionScreen({
    Key? key,
    required this.activateArtificialIntelligence,
  }) : super(key: key);

  @override
  State<SinglePlayerGameSelectionScreen> createState() => _SinglePlayerGameSelectionScreenState();
}

class _SinglePlayerGameSelectionScreenState extends State<SinglePlayerGameSelectionScreen> {
  final List<Game> gameList = [
    Game(
      winSerie: 3,
      fieldMulti: 3,
      playerOneGamePieceLvl: [1, 1, 2, 2, 3, 3],
      playerTwoGamePieceLvl: [1, 1, 2, 2, 3, 3],
    ),
    Game(
      winSerie: 4,
      fieldMulti: 5,
      playerOneGamePieceLvl: [1, 1, 3, 3, 5, 5],
      playerTwoGamePieceLvl: [1, 1, 3, 3, 5, 5],
    ),
    Game(
      winSerie: 5,
      fieldMulti: 7,
      playerOneGamePieceLvl: [1, 1, 3, 3, 5, 5],
      playerTwoGamePieceLvl: [1, 1, 3, 3, 5, 5],
    ),
  ];

  void selectGame(Game game) {
    Future.delayed(Duration.zero, () async {
      Navigator.pushNamed(
        context,
        gameRoute,
        arguments: GameScreenArguments(
          winSerie: game.winSeries,
          fieldMultiplier: game.fieldMultiplier,
          playerOneGamePieceLevel: game.playerOneGamePieceLevel,
          playerTwoGamePieceLevel: game.playerTwoGamePieceLevel,
          activateArtificialIntelligence: widget.activateArtificialIntelligence,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
            ),
            items: gameList
                .map(
                  (gameItem) => GestureDetector(
                    onTap: () => selectGame(gameItem),
                    child: Container(
                      margin: const EdgeInsets.all(7.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (int i = 0; i < gameItem.winSeries; i++)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4.0, right: 4.0, top: 32.0, bottom: 8.0),
                                    child: Text(
                                      'X',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          Expanded(
                            child: GridView.count(
                              crossAxisCount: gameItem.fields.length,
                              shrinkWrap: true,
                              children: [
                                for (int row = 0; row < gameItem.fields.length; row++)
                                  for (int col = 0; col < gameItem.fields[0].length; col++)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white54),
                                      ),
                                    ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${gameItem.fieldMultiplier} x ${gameItem.fieldMultiplier}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GamePieceList(
                                gamePieceList: gameItem.playerOneGamePieces,
                                activePlayer: false,
                                levelMap: gameItem.playerOneLevelMap,
                                gamePieceWidthOffset: 30,
                              ),
                              GamePieceList(
                                gamePieceList: gameItem.playerTwoGamePieces,
                                activePlayer: false,
                                levelMap: gameItem.playerTwoLevelMap,
                                gamePieceWidthOffset: 30,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
