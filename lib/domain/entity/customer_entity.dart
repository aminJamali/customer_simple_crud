import '../value_object/bank_account_number_value_object.dart';
import '../value_object/date_of_birth_value_object.dart';
import '../value_object/email_value_object.dart';
import '../value_object/first_name_value_object.dart';
import '../value_object/last_name_value_object.dart';
import '../value_object/phone_number_value_object.dart';

class CustomerEntity {
  final BankAccountNumberValueObject bankAccountNumberValueObject;
  final DateOfBirthValueObject dateOfBirthValueObject;
  final EmailValueObject emailValueObject;
  final PhoneNumberValueObject phoneNumberValueObject;
  final FirstNameValueObject firstNameValueObject;
  final LastNameValueObject lastNameValueObject;

  CustomerEntity({
    required this.bankAccountNumberValueObject,
    required this.dateOfBirthValueObject,
    required this.emailValueObject,
    required this.phoneNumberValueObject,
    required this.firstNameValueObject,
    required this.lastNameValueObject,
  });
}
