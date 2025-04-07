import "package:flutter/material.dart";
import "package:numly/static/styles.dart";

class VirtualKey extends StatelessWidget {
  final bool disabled;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final Widget child;

  const VirtualKey({
    super.key,
    this.disabled = false,
    this.onLongPress,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final content = SizedBox(
      height: 50,
      child: Center(
        child: child,
      ),
    );

    final button = ElevatedButton(
      onPressed: disabled ? null : onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        backgroundColor: Styles.foregroundColor,
        foregroundColor: Styles.backgroundColor,
      ),
      child: content,
    );

    return Expanded(
      child: button,
    );
  }
}
