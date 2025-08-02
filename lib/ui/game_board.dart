import 'package:flutter/material.dart';
import '../game/game_state.dart';
import '../widgets/player_tile.dart';
import '../widgets/ghost_tile.dart';
import '../widgets/wall_tile.dart';
import '../widgets/food_tile.dart';
import '../widgets/empty_tile.dart';

class GameBoard extends StatelessWidget {
  final GameState gameState;

  const GameBoard({super.key, required this.gameState});

  @override
  Widget build(BuildContext context) {
    final totalTiles = gameState.rows * gameState.cols;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: totalTiles,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: gameState.cols,
      ),
      itemBuilder: (context, index) {
        if (index == gameState.playerPos) {
          return const PlayerTile();
        } else if (gameState.ghostPositions.contains(index)) {
          return const GhostTile();
        } else if (gameState.isWall(index)) {
          return const WallTile();
        } else if (gameState.isFood(index)) {
          return const FoodTile();
        } else {
          return const EmptyTile();
        }
      },
    );
  }
}
