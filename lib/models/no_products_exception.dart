class NoProductsException implements Exception {
  final message;
  NoProductsException(this.message);

  @override
  String toString() {
    return message;
  }
}
