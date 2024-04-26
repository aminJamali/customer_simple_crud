import 'package:equatable/equatable.dart';

import '../../../data/model/customer_model.dart';
import '../../../shared/models/exception_model.dart';

abstract class GetAllCustomersState extends Equatable {}

class GetAllCustomersLoadingState extends GetAllCustomersState {
  @override
  List<Object?> get props => [];
}

class GetAllCustomersDoneState extends GetAllCustomersState {
  final List<CustomerModel> customers;

  GetAllCustomersDoneState(this.customers);

  @override
  List<Object?> get props => [];
}

class GetAllCustomersEmptyState extends GetAllCustomersState {
  @override
  List<Object?> get props => [];
}

class GetAllCustomersExceptionState extends GetAllCustomersState {
  final ExceptionModel exceptionModel;

  GetAllCustomersExceptionState(this.exceptionModel);

  @override
  List<Object?> get props => [];
}
