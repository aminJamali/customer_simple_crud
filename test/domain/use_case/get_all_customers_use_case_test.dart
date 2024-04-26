import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
import 'package:mc_crud_test/domain/repository/customer_repository.dart';
import 'package:mc_crud_test/domain/use_case/get_all_customers_use_case.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';
import 'package:mocktail/mocktail.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late MockCustomerRepository mockCustomerRepository;
  late GetAllCustomersUseCase getAllCustomerUseCase;

  setUp(
    () {
      mockCustomerRepository = MockCustomerRepository();
      getAllCustomerUseCase = GetAllCustomersUseCase(mockCustomerRepository);
    },
  );
  group('get all customers use case tests', () {
    test(
      'should return a valid customer list with one item',
      () async {
        when(
          () => mockCustomerRepository.getAllCustomers(),
        ).thenAnswer(
          (_) async => Right(_fakeCustomerList),
        );

        final result = await getAllCustomerUseCase.call(null);

        result.fold(
          (l) => null,
          (r) => expect(r.length, 1),
        );
      },
    );

    test(
      'should return exception',
      () async {
        when(
          () => mockCustomerRepository.getAllCustomers(),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result = await getAllCustomerUseCase.call(null);

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

final _fakeCustomerList = [
  CustomerModel(
    bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
    dateOfBirthValueObject:
        DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
    id: '1',
    emailValueObject: EmailValueObject('amin@gmail.com'),
    phoneNumberValueObject: PhoneNumberValueObject('9014523821', '98'),
    firstNameValueObject: FirstNameValueObject('amin'),
    lastNameValueObject: LastNameValueObject('jamali'),
  ),
];
