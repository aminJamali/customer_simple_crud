import 'package:dartz/dartz.dart';

import '../../data/model/modify_customer_dto.dart';
import '../../shared/models/exception_model.dart';

abstract class CustomerRepository {
  Future<Either<ExceptionModel, String>> addCustomer(
    final AddCustomerDto addCustomerDto,
  );
}
