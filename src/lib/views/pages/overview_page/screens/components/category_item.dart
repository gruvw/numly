import "package:flutter/material.dart";
import "package:material_symbols_icons/symbols.dart";
import "package:numly/utils/language.dart";

class CategoryItem extends StatelessWidget {
  final String title;
  final String? subtitle;

  final Widget? leading;
  final Widget? trailing;

  final VoidCallback? onTap;

  const CategoryItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  factory CategoryItem.favorites({
    required String title,
    required List<Widget> favorites,
    VoidCallback? onTap,
  }) {
    return CategoryItem(
      title: title,
      leading: Icon(Symbols.star),
      trailing: Icon(Symbols.arrow_forward_ios),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle?.nmap((subtitle) => Text(subtitle)),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
