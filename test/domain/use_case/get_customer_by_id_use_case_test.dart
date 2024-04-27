import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
import 'package:mc_crud_test/domain/repository/customer_repository.dart';
import 'package:mc_crud_test/domain/use_case/get_customer_by_id_use_case.dart';
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
  late GetCustomerByIdUseCase getCustomerByIdUseCase;

  setUp(
    () {
      mockCustomerRepository = MockCustomerRepository();
      getCustomerByIdUseCase = GetCustomerByIdUseCase(mockCustomerRepository);
    },
  );

  group('get customer by id use case tests', () {
    test(
      'should return a valid customer model',
      () async {
        when(
          () => mockCustomerRepository.getCustomerById('1'),
        ).thenAnswer(
          (_) async => Right(_fakeCustomerModel),
        );

        final result = await getCustomerByIdUseCase.call('1');

        result.fold(
          (l) => null,
          (r) => expect(r, _fakeCustomerModel),
        );
      },
    );
    test(
      'should return exception',
      () async {
        when(
          () => mockCustomerRepository.getCustomerById('1'),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result = await getCustomerByIdUseCase.call('1');

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

CustomerModel _fakeCustomerModel = CustomerModel(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456787'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-01-23T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin22@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536522', '98'),
  firstNameValueObject: FirstNameValueObject('reza'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
