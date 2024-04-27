import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/domain/failure/bank_account_number_is_not_valid_failure.dart';
import 'package:mc_crud_test/domain/failure/base_failure.dart';
import 'package:mc_crud_test/domain/failure/email_is_not_valid_failure.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';

void main() {
  group('modify customer dto tests', () {});
  test(
    'should return expected json of modify customer',
    () {
      final json = ModifyCustomerDto(
        id: '1',
        bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
        dateOfBirthValueObject:
            DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
        emailValueObject: EmailValueObject('amin@gmail.com'),
        phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
        firstNameValueObject: FirstNameValueObject('amin'),
        lastNameValueObject: LastNameValueObject('jamali'),
      ).toJson();
      expect(
        _fakeJson,
        json,
      );
    },
  );
  test(
    'should throw EmailIsNotValid failure',
    () {
      try {
        ModifyCustomerDto(
          id: '1',
          bankAccountNumberValueObject:
              BankAccountNumberValueObject('123456789'),
          dateOfBirthValueObject:
              DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
          emailValueObject: EmailValueObject('amingmail'),
          phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
          firstNameValueObject: FirstNameValueObject('amin'),
          lastNameValueObject: LastNameValueObject('jamali'),
        );
      } on BaseFailure catch (e) {
        expect(_emailIsNotValidFailure, e);
      }
    },
  );
  test(
    'should throw BankAccount Number is not valid failure',
    () {
      try {
        ModifyCustomerDto(
          id: '2',
          bankAccountNumberValueObject: BankAccountNumberValueObject('12345'),
          dateOfBirthValueObject:
              DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
          emailValueObject: EmailValueObject('amin@gmail.com'),
          phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
          firstNameValueObject: FirstNameValueObject('amin'),
          lastNameValueObject: LastNameValueObject('jamali'),
        );
      } on BaseFailure catch (e) {
        expect(_bankAccountNumberIsNotValidFailure, e);
      }
    },
  );
}

const _bankAccountNumberIsNotValidFailure = BankAccountNumberIsNotValidFailure(
  'Bank Account Number is not valid',
);

const _emailIsNotValidFailure =
    EmailIsNotValidFailure('Email Address is not valid');

final _fakeJson = {
  'bankAccountNumber': '123456789',
  'id': '1',
  'dateOfBirth': '2024-04-25T10:24:16.642479',
  'email': 'amin@gmail.com',
  'phoneNumber': {
    'phoneNumber': '9014536521',
    'countryCode': '98',
  },
  'firstName': 'amin',
  'lastName': 'jamali',
};
