import "package:flutter/material.dart";

class Levels extends StatelessWidget {
  final String category;

  const Levels({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // TODO handle favorites
    return Scaffold(body: Center(child: Text("Level $category")));
  }
}
