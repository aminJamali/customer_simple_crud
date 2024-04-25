import 'package:equatable/equatable.dart';

import '../../../shared/models/exception_model.dart';

abstract class AddCustomerState extends Equatable {}

class AddCustomerDoneState extends AddCustomerState {
  final String id;

  AddCustomerDoneState(this.id);

  @override
  List<Object?> get props => [];
}

class AddCustomerExceptionState extends AddCustomerState {
  final ExceptionModel exceptionModel;

  AddCustomerExceptionState(this.exceptionModel);

  @override
  List<Object?> get props => [];
}

class AddCustomerInitialState extends AddCustomerState {
  @override
  List<Object?> get props => [];
}

class AddCustomerLoadingState extends AddCustomerState {
  @override
  List<Object?> get props => [];
}
