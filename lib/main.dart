import 'package:flutter/material.dart';
import 'package:pacman_flutter/game/game_controller.dart';

void main() {
  runApp(PacmanApp());
}

class PacmanApp extends StatelessWidget {
  const PacmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pacman Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: GameController(),
    );
  }
}
