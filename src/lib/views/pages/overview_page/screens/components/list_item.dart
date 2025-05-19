import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/static/styles.dart";
import "package:numly/utils/language.dart";

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final VoidCallback? onTap;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  ListItem.favorites({
    super.key,
    required this.title,
    this.onTap,
  })  : leading = Icon(Symbols.star),
        trailing = Icon(Symbols.arrow_forward_ios),
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
      ),
    );
  }
}
