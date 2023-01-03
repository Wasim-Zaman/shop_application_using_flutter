class NoProductsException implements Exception {
  final String message;
  NoProductsException(this.message);

  @override
  String toString() {
    return message;
  }
}
