extension RemoveAll on String {
  String removeAll(Pattern pattern) => replaceAll(pattern, "");
}
