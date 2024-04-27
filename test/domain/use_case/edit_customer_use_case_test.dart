import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/domain/repository/customer_repository.dart';
import 'package:mc_crud_test/domain/use_case/edit_customer_use_case.dart';
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
  late EditCustomerUseCase editCustomerUseCase;

  setUp(
    () {
      mockCustomerRepository = MockCustomerRepository();
      editCustomerUseCase = EditCustomerUseCase(mockCustomerRepository);
    },
  );

  group('edit customer use case tests', () {
    test(
      'should return edited customer id',
      () async {
        when(
          () => mockCustomerRepository.editCustomer(_modifyCustomerFakeDto),
        ).thenAnswer(
          (_) async => const Right('1'),
        );

        final result = await editCustomerUseCase.call(_modifyCustomerFakeDto);

        result.fold(
          (l) => null,
          (r) => expect(r, '1'),
        );
      },
    );

    test(
      'should return exception',
      () async {
        when(
          () => mockCustomerRepository.editCustomer(_modifyCustomerFakeDto),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result = await editCustomerUseCase.call(_modifyCustomerFakeDto);

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

final _modifyCustomerFakeDto = ModifyCustomerDto(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
