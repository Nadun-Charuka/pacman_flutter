import 'direction.dart';

class GameState {
  final int rows = 15;
  final int cols = 11;

  // Game entities
  int playerPos = 141; // starting position
  List<int> ghostPositions = [19, 87, 111];
  List<int> wallTiles = [];
  List<int> foodTiles = [];

  // Score
  int score = 0;

  // Game status
  bool isPaused = false;
  Direction playerDirection = Direction.right;

  GameState() {
    _generateWalls();
    generateFood();
  }

  void _generateWalls() {
    wallTiles.clear();
    for (int i = 0; i < cols; i++) {
      wallTiles.add(i); // Top row
      wallTiles.add((rows - 1) * cols + i); // Bottom row
    }
    for (int i = 0; i < rows; i++) {
      wallTiles.add(i * cols); // Left column
      wallTiles.add(i * cols + cols - 1); // Right column
    }

    // You can customize more internal walls later if needed
  }

  void generateFood() {
    foodTiles.clear();
    int total = rows * cols;
    for (int i = 0; i < total; i++) {
      if (!wallTiles.contains(i) && !ghostPositions.contains(i)) {
        foodTiles.add(i);
      }
    }
  }

  bool isFood(int index) => foodTiles.contains(index);
  bool isWall(int index) => wallTiles.contains(index);
  bool isGhost(int index) => ghostPositions.contains(index);
}
