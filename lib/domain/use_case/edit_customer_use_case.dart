import 'package:dartz/dartz.dart';

import '../../application/utils/base_use_case/base_use_case.dart';
import '../../data/model/modify_customer_dto.dart';
import '../../shared/models/exception_model.dart';
import '../repository/customer_repository.dart';

class EditCustomerUseCase extends BaseUseCase<String, ModifyCustomerDto> {
  final CustomerRepository customerRepository;

  EditCustomerUseCase(this.customerRepository);

  @override
  Future<Either<ExceptionModel, String>> call(ModifyCustomerDto params) =>
      customerRepository.editCustomer(params);
}
