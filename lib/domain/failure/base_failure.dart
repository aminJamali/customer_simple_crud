abstract class BaseFailure implements Exception {
  final String message;

  BaseFailure(this.message);
}
