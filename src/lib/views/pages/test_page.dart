import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/static/values.dart";

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Values.applicationTitle,),
        backgroundColor: Styles.black,
        foregroundColor: Styles.white,
      ),
      // body: ,
    );
  }
}
