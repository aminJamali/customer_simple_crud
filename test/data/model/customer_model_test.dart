import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';

void main() {
  test(
    'should return a valid customer model',
    () {
      final result = CustomerModel.fromJson(
        const {
          'bankAccountNumber': '123456789',
          'dateOfBirth': '2024-04-25T10:24:16.642479',
          'email': 'amin@gmail.com',
          'phoneNumber': {
            'phoneNumber': '9014536521',
            'countryCode': '98',
          },
          'firstName': 'amin',
          'lastName': 'jamali',
          'id': '1',
        },
      );

      expect(
        _fakeModel,
        result,
      );
    },
  );
}

final _fakeModel = CustomerModel(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
