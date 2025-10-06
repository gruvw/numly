import "package:flutter/material.dart";

class WidgetSymmetricPadding extends StatelessWidget {
  final Widget paddingWidget;
  final Widget child;

  const WidgetSymmetricPadding({
    super.key,
    required this.paddingWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final perfectPadding = Visibility(
      visible: false,
      maintainState: true,
      maintainAnimation: true,
      maintainSize: true,
      child: paddingWidget,
    );

    return Row(
      children: [
        perfectPadding,
        Expanded(child: child),
        perfectPadding,
      ],
    );
  }
}
