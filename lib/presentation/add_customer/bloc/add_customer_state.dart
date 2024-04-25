import '../../../shared/models/exception_model.dart';

abstract class AddCustomerState {}

class AddCustomerDoneState extends AddCustomerState {
  final String id;

  AddCustomerDoneState(this.id);
}

class AddCustomerExceptionState extends AddCustomerState {
  final ExceptionModel exceptionModel;

  AddCustomerExceptionState(this.exceptionModel);
}

class AddCustomerInitialState extends AddCustomerState {}

class AddCustomerLoadingState extends AddCustomerState {}
