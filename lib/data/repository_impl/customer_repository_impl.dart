import 'package:dartz/dartz.dart';

import '../../domain/repository/customer_repository.dart';
import '../../shared/models/exception_model.dart';
import '../data_source/local_data_source.dart';
import '../model/modify_customer_dto.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final LocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<Either<ExceptionModel, String>> addCustomer(
    AddCustomerDto addCustomerDto,
  ) =>
      localDataSource.addCustomer(addCustomerDto);
}
