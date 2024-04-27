import 'package:dartz/dartz.dart';

import '../../application/utils/base_use_case/base_use_case.dart';
import '../../data/model/customer_model.dart';
import '../../shared/models/exception_model.dart';
import '../repository/customer_repository.dart';

class GetCustomerByIdUseCase extends BaseUseCase<CustomerModel, String> {
  final CustomerRepository customerRepository;

  GetCustomerByIdUseCase(this.customerRepository);

  @override
  Future<Either<ExceptionModel, CustomerModel>> call(String params) =>
      customerRepository.getCustomerById(params);
}
