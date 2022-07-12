import 'package:flutter/material.dart';

import '../utils/constants/route_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pushNamed(gameRoute),
          child: const Text('Spieler vs. Spieler'),
        ),
      ),
    );
  }
}
