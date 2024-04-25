import 'package:equatable/equatable.dart';

class ExceptionModel extends Equatable implements Exception {
  final String message;

  const ExceptionModel({required this.message});

  @override
  List<Object?> get props => [];
}
