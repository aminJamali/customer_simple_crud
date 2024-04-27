import 'package:dartz/dartz.dart';

import '../../data/model/customer_model.dart';
import '../../data/model/modify_customer_dto.dart';
import '../../shared/models/exception_model.dart';

abstract class CustomerRepository {
  Future<Either<ExceptionModel, String>> addCustomer(
    final ModifyCustomerDto addCustomerDto,
  );

  Future<Either<ExceptionModel, List<CustomerModel>>> getAllCustomers();

  Future<Either<ExceptionModel, CustomerModel>> getCustomerById(
    final String id,
  );

  Future<Either<ExceptionModel, String>> editCustomer(
    final ModifyCustomerDto modifyCustomerDto,
  );
}
