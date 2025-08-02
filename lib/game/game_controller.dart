import 'dart:async';
import 'package:flutter/material.dart';
import '../ui/game_board.dart';
import '../ui/control_panel.dart';
import 'game_state.dart';
import 'direction.dart';

class GameController extends StatefulWidget {
  const GameController({super.key});

  @override
  State<GameController> createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> {
  final GameState _gameState = GameState();
  Timer? _gameLoopTimer;
  bool _gameStarted = false;

  @override
  void dispose() {
    _gameLoopTimer?.cancel();
    super.dispose();
  }

  void _startGame() {
    if (_gameStarted) return;

    _gameStarted = true;
    _gameLoopTimer = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (_gameState.isPaused) return;

      setState(() {
        _movePlayer();
        _checkFoodCollision();
        _moveGhosts();
        _checkGhostCollision();
      });
    });
  }

  void _pauseResumeGame() {
    setState(() {
      _gameState.isPaused = !_gameState.isPaused;
    });
  }

  void _movePlayer() {
    int next = _nextTile(_gameState.playerPos, _gameState.playerDirection);
    if (!_gameState.wallTiles.contains(next)) {
      _gameState.playerPos = next;
    }
  }

  void _checkFoodCollision() {
    if (_gameState.foodTiles.contains(_gameState.playerPos)) {
      _gameState.foodTiles.remove(_gameState.playerPos);
      _gameState.score += 1;
    }
  }

  void _moveGhosts() {
    for (int i = 0; i < _gameState.ghostPositions.length; i++) {
      int current = _gameState.ghostPositions[i];
      List<Direction> dirs = Direction.values.toList()..shuffle();
      for (Direction d in dirs) {
        int next = _nextTile(current, d);
        if (!_gameState.wallTiles.contains(next)) {
          _gameState.ghostPositions[i] = next;
          break;
        }
      }
    }
  }

  void _checkGhostCollision() {
    if (_gameState.ghostPositions.contains(_gameState.playerPos)) {
      _gameOver();
    }
  }

  void _gameOver() {
    _gameLoopTimer?.cancel();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Game Over"),
        content: Text("Your Score: ${_gameState.score}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartGame();
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }

  void _restartGame() {
    setState(() {
      _gameLoopTimer?.cancel();
      _gameStarted = false;
      _gameState
        ..playerPos = 141
        ..ghostPositions = [19, 87, 111]
        ..score = 0
        ..isPaused = false
        ..playerDirection = Direction.right
        ..foodTiles.clear()
        ..generateFood();
    });
  }

  void _onDirectionChanged(Direction dir) {
    setState(() {
      _gameState.playerDirection = dir;
    });
  }

  int _nextTile(int pos, Direction dir) {
    int row = pos ~/ _gameState.cols;
    int col = pos % _gameState.cols;

    switch (dir) {
      case Direction.up:
        row--;
        break;
      case Direction.down:
        row++;
        break;
      case Direction.left:
        col--;
        break;
      case Direction.right:
        col++;
        break;
    }

    if (row < 0 ||
        row >= _gameState.rows ||
        col < 0 ||
        col >= _gameState.cols) {
      return pos; // stay in place
    }

    return row * _gameState.cols + col;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GameBoard(gameState: _gameState),
              ControlPanel(
                isPaused: _gameState.isPaused,
                onPlay: _startGame,
                onPauseResume: _pauseResumeGame,
                onDirectionChanged: _onDirectionChanged,
                score: _gameState.score,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
