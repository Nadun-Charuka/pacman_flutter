import 'package:flutter/material.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.yellow,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
