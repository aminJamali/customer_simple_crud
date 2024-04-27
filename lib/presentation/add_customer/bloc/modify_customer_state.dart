import 'package:equatable/equatable.dart';

import '../../../data/model/customer_model.dart';
import '../../../shared/models/exception_model.dart';

abstract class ModifyCustomerState extends Equatable {}

class GetCustomerByIdDoneState extends ModifyCustomerState {
  final CustomerModel customerModel;

  GetCustomerByIdDoneState(this.customerModel);

  @override
  List<Object?> get props => [];
}

class EditCustomerDoneState extends ModifyCustomerState {
  final String id;

  EditCustomerDoneState(this.id);

  @override
  List<Object?> get props => [];
}

class GetCustomerByIdExceptionState extends ModifyCustomerState {
  final ExceptionModel exceptionModel;

  GetCustomerByIdExceptionState(this.exceptionModel);

  @override
  List<Object?> get props => [];
}

class GetCustomerByIdLoadingState extends ModifyCustomerState {
  @override
  List<Object?> get props => [];
}

class ModifyCustomerDoneState extends ModifyCustomerState {
  final String id;

  ModifyCustomerDoneState(this.id);

  @override
  List<Object?> get props => [];
}

class ModifyCustomerExceptionState extends ModifyCustomerState {
  final ExceptionModel exceptionModel;

  ModifyCustomerExceptionState(this.exceptionModel);

  @override
  List<Object?> get props => [];
}

class AddCustomerInitialState extends ModifyCustomerState {
  @override
  List<Object?> get props => [];
}

class ModifyCustomerLoadingState extends ModifyCustomerState {
  @override
  List<Object?> get props => [];
}
