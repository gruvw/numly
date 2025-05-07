import "package:flutter/material.dart";

class Trainnings extends StatelessWidget {
  final String category;

  const Trainnings({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Trainning $category");
  }
}
