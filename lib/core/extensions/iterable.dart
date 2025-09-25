extension IterableExtension on Iterable<dynamic>? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}
