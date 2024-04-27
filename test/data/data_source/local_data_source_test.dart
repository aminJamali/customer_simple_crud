import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mc_crud_test/data/data_source/local_data_source.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';

const mockStorage = './test/fixtures/core';
const channel = MethodChannel(
  'plugins.flutter.io/path_provider',
);

void main() {
  late LocalDataSource localCustomerDataSource;

  setUp(
    () {
      TestWidgetsFlutterBinding.ensureInitialized();
      localCustomerDataSource = LocalDataSource();
      channel.setMockMethodCallHandler((methodCall) async => mockStorage);
    },
  );

  group('add customer data source tests', () {
    test(
      'add customer data source should return added customer\'s id',
      () async {
        final result =
            await localCustomerDataSource.addCustomer(_addCustomerFakeDto);

        result.fold(
          (l) => null,
          (r) => expect(r.runtimeType, String),
        );
      },
    );
    test(
      'add customer data source should return customer is duplicate exception',
      () async {
        await localCustomerDataSource.addCustomer(_addCustomerFakeDto);
        final result =
            await localCustomerDataSource.addCustomer(_addCustomerFakeDto);

        result.fold(
          (l) => expect(
            l,
            const ExceptionModel(message: 'Customer is duplicate'),
          ),
          (r) => null,
        );
      },
    );
  });

  group('get all customers data source tests', () {
    test(
      'should return a map with two items',
      () async {
        await localCustomerDataSource.addCustomer(_secondCustomerFakeDto);

        final result = await localCustomerDataSource.getAllCustomers();

        result.fold(
          (l) => null,
          (r) => expect(r.length, 2),
        );
      },
    );
  });
}

final _addCustomerFakeDto = ModifyCustomerDto(
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);


final _secondCustomerFakeDto = ModifyCustomerDto(
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456788'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-02-23T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin2@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536522', '98'),
  firstNameValueObject: FirstNameValueObject('ali'),
  lastNameValueObject: LastNameValueObject('jamali'),
);


