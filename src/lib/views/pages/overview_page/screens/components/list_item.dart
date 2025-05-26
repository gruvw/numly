import "package:flutter/material.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
  });

  ListItem.favorites({
    super.key,
    required this.title,
    this.onTap,
    this.onLongPress,
  })  : leading = Icon(Styles.iconFavorite),
        trailing = Icon(Styles.iconNext),
        subtitle = null;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        title: Text(title),
        tileColor: Styles.backgroundColor,
        subtitle: subtitle?.nmap((subtitle) => Text(subtitle)),
        leading: leading,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
