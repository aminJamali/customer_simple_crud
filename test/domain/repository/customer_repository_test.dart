import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/data_source/local_data_source.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/data/repository_impl/customer_repository_impl.dart';
import 'package:mc_crud_test/domain/repository/customer_repository.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCustomerDataSource extends Mock implements LocalDataSource {}

void main() {
  late MockAddCustomerDataSource mockAddCustomerDataSource;
  late CustomerRepository customerRepository;

  setUp(
    () {
      mockAddCustomerDataSource = MockAddCustomerDataSource();
      customerRepository = CustomerRepositoryImpl(mockAddCustomerDataSource);
    },
  );

  group('add customer repository tests', () {
    test(
      'add customer repository should return added customer\'s id',
      () async {
        when(() => mockAddCustomerDataSource.addCustomer(_addCustomerFakeDto))
            .thenAnswer(
          (_) async => const Right('1'),
        );

        final result =
            await customerRepository.addCustomer(_addCustomerFakeDto);

        result.fold(
          (l) => null,
          (r) => expect(r, '1'),
        );
      },
    );
    test(
      'add customer repository should return exception',
      () async {
        when(() => mockAddCustomerDataSource.addCustomer(_addCustomerFakeDto))
            .thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result =
            await customerRepository.addCustomer(_addCustomerFakeDto);

        result.fold(
          (l) => expect(
            l,
            const ExceptionModel(message: 'exception'),
          ),
          (r) => null,
        );
      },
    );
  });
}

final _addCustomerFakeDto = AddCustomerDto(
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
