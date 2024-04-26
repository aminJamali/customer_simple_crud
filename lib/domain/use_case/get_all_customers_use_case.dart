import 'package:dartz/dartz.dart';

import '../../application/utils/base_use_case/base_use_case.dart';
import '../../data/model/customer_model.dart';
import '../../shared/models/exception_model.dart';
import '../repository/customer_repository.dart';

class GetAllCustomersUseCase extends BaseUseCase<List<CustomerModel>, void> {
  final CustomerRepository customerRepository;

  GetAllCustomersUseCase(this.customerRepository);

  @override
  Future<Either<ExceptionModel, List<CustomerModel>>> call(void params) =>
      customerRepository.getAllCustomers();
}
