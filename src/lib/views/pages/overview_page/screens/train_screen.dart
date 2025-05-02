import "package:flutter/material.dart";
import "package:numly/views/pages/overview_page/screens/components/category_item.dart";

class TrainScreen extends StatelessWidget {
  const TrainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      CategoryItem(),
      CategoryItem(),
      CategoryItem(),
      CategoryItem(),
      CategoryItem(),
      CategoryItem(),
      CategoryItem(),
    ];

    return SingleChildScrollView(
      child: Column(
        children: items.map((item) {
          return Column(
            children: [
              item,
              Divider(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
