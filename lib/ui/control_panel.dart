import 'package:flutter/material.dart';
import '../game/direction.dart';

class ControlPanel extends StatelessWidget {
  final int score;
  final bool isPaused;
  final VoidCallback onPlay;
  final VoidCallback onPauseResume;
  final ValueChanged<Direction> onDirectionChanged;

  const ControlPanel({
    super.key,
    required this.isPaused,
    required this.onPlay,
    required this.onPauseResume,
    required this.onDirectionChanged,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPlay,
              child: const Text("START"),
            ),
            Text(
              "Score: $score",
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            ElevatedButton(
              onPressed: onPauseResume,
              child: Text(isPaused ? "RESUME" : "PAUSE"),
            ),
          ],
        ),
        Row(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_left,
                size: 40,
              ),
              onPressed: () => onDirectionChanged(Direction.left),
            ),
            Column(
              spacing: 50,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_drop_up,
                    size: 40,
                  ),
                  onPressed: () => onDirectionChanged(Direction.up),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                  ),
                  onPressed: () => onDirectionChanged(Direction.down),
                ),
              ],
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_right,
                size: 40,
              ),
              onPressed: () => onDirectionChanged(Direction.right),
            ),
          ],
        ),
      ],
    );
  }
}
