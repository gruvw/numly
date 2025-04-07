import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";

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
        disabledBackgroundColor: Styles.foregroundColor.lighten(0.3),
        foregroundColor: Styles.backgroundColor,
        disabledForegroundColor: Styles.backgroundColor.darken(0.2),
      ),
      child: content,
    );

    return Expanded(
      child: button,
    );
  }
}
