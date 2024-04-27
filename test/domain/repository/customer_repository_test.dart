import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/data_source/local_data_source.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
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
        when(
          () => mockAddCustomerDataSource.addCustomer(
            _modifyCustomerFakeDto,
          ),
        ).thenAnswer(
          (_) async => const Right('1'),
        );

        final result =
            await customerRepository.addCustomer(_modifyCustomerFakeDto);

        result.fold(
          (l) => null,
          (r) => expect(r, '1'),
        );
      },
    );
    test(
      'add customer repository should return exception',
      () async {
        when(
          () => mockAddCustomerDataSource.addCustomer(
            _modifyCustomerFakeDto,
          ),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result =
            await customerRepository.addCustomer(_modifyCustomerFakeDto);

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

  group('get all customers repository tests', () {
    test(
      'should return a valid customer list with one item',
      () async {
        when(
          () => mockAddCustomerDataSource.getAllCustomers(),
        ).thenAnswer(
          (_) async => Right(_fakeMap),
        );

        final result = await customerRepository.getAllCustomers();

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
          () => mockAddCustomerDataSource.getAllCustomers(),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result = await customerRepository.getAllCustomers();

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

  group('edit customer repository tests', () {
    test(
      'edit customer should return edited customer id',
      () async {
        when(
          () => mockAddCustomerDataSource.editCustomer(_modifyCustomerFakeDto),
        ).thenAnswer(
          (_) async => const Right('1'),
        );
        final result =
            await customerRepository.editCustomer(_modifyCustomerFakeDto);

        result.fold(
          (l) => null,
          (r) => expect(r, '1'),
        );
      },
    );
    test(
      'edit customer should return exception',
      () async {
        when(
          () => mockAddCustomerDataSource.editCustomer(_modifyCustomerFakeDto),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );
        final result =
            await customerRepository.editCustomer(_modifyCustomerFakeDto);

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

  group('get customer by id tests', () {
    test(
      'should return a valid customer model',
      () async {
        when(
          () => mockAddCustomerDataSource.getCustomerById('1'),
        ).thenAnswer(
          (_) async => Right(_fakeSingleValue),
        );

        final result = await customerRepository.getCustomerById('1');

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
          () => mockAddCustomerDataSource.getCustomerById('1'),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );

        final result = await customerRepository.getCustomerById('1');

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

final Map<dynamic, dynamic> _fakeSingleValue = {
  'id': '1',
  'bankAccountNumber': '123456789',
  'dateOfBirth': '2024-04-25T10:24:16.642479',
  'email': 'amin@gmail.com',
  'phoneNumber': {
    'phoneNumber': '9014536521',
    'countryCode': '98',
  },
  'firstName': 'amin',
  'lastName': 'jamali',
};

final _fakeCustomerModel = CustomerModel(
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
  id: '1',
);

final _fakeMap = {
  '123': {
    'id': '1',
    'bankAccountNumber': '123456789',
    'dateOfBirth': '2024-04-25T10:24:16.642479',
    'email': 'amin@gmail.com',
    'phoneNumber': {
      'phoneNumber': '9014536521',
      'countryCode': '98',
    },
    'firstName': 'amin',
    'lastName': 'jamali',
  },
};

final _modifyCustomerFakeDto = ModifyCustomerDto(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
