import 'package:dartz/dartz.dart';

import '../../domain/repository/customer_repository.dart';
import '../../domain/value_object/bank_account_number_value_object.dart';
import '../../domain/value_object/date_of_birth_value_object.dart';
import '../../domain/value_object/email_value_object.dart';
import '../../domain/value_object/first_name_value_object.dart';
import '../../domain/value_object/last_name_value_object.dart';
import '../../domain/value_object/phone_number_value_object.dart';
import '../../shared/models/exception_model.dart';
import '../data_source/local_data_source.dart';
import '../model/customer_model.dart';
import '../model/modify_customer_dto.dart';

class CustomerRepositoryImpl extends CustomerRepository {
  final LocalDataSource localDataSource;

  CustomerRepositoryImpl(this.localDataSource);

  @override
  Future<Either<ExceptionModel, String>> addCustomer(
    ModifyCustomerDto addCustomerDto,
  ) =>
      localDataSource.addCustomer(addCustomerDto);

  @override
  Future<Either<ExceptionModel, List<CustomerModel>>> getAllCustomers() async {
    final result = await localDataSource.getAllCustomers();

    return result.fold(
      Left.new,
      (data) {
        final List<CustomerModel> customersList = [];
        data.forEach((key, value) {
          value as Map<dynamic, dynamic>;
          customersList.add(
            CustomerModel(
              id: value['id'],
              firstNameValueObject: FirstNameValueObject(value['firstName']),
              lastNameValueObject: LastNameValueObject(value['lastName']),
              bankAccountNumberValueObject: BankAccountNumberValueObject(
                value['bankAccountNumber'],
              ),
              dateOfBirthValueObject:
                  DateOfBirthValueObject(value['dateOfBirth']),
              emailValueObject: EmailValueObject(value['email']),
              phoneNumberValueObject: PhoneNumberValueObject(
                value['phoneNumber']['phoneNumber'],
                value['phoneNumber']['countryCode'],
              ),
            ),
          );
        });

        return Right(customersList);
      },
    );
  }

  @override
  Future<Either<ExceptionModel, CustomerModel>> getCustomerById(
    String id,
  ) async {
    final result = await localDataSource.getCustomerById(id);

    return result.fold(
      Left.new,
      (r) => Right(
        CustomerModel.fromJson(r),
      ),
    );
  }
}
