import 'package:equatable/equatable.dart';

abstract class BaseFailure extends Equatable implements Exception {
  final String message;

  const BaseFailure(this.message);
}
