import '../../domain/entity/customer_entity.dart';
import '../../domain/value_object/bank_account_number_value_object.dart';
import '../../domain/value_object/date_of_birth_value_object.dart';
import '../../domain/value_object/email_value_object.dart';
import '../../domain/value_object/first_name_value_object.dart';
import '../../domain/value_object/last_name_value_object.dart';
import '../../domain/value_object/phone_number_value_object.dart';

class CustomerModel extends CustomerEntity {
  final String id;

  CustomerModel({
    required super.bankAccountNumberValueObject,
    required super.dateOfBirthValueObject,
    required this.id,
    required super.emailValueObject,
    required super.phoneNumberValueObject,
    required super.firstNameValueObject,
    required super.lastNameValueObject,
  });

  factory CustomerModel.fromJson(final Map<dynamic, dynamic> json) =>
      CustomerModel(
        id: json['id'],
        firstNameValueObject:
            FirstNameValueObject(json['firstName']),
        lastNameValueObject: LastNameValueObject(json['lastName']),
        bankAccountNumberValueObject:
            BankAccountNumberValueObject(json['bankAccountNumber']),
        dateOfBirthValueObject:
            DateOfBirthValueObject(json['dateOfBirth']),
        emailValueObject: EmailValueObject(json['email']),
        phoneNumberValueObject: PhoneNumberValueObject(
          json['phoneNumber']['phoneNumber'],
          json['phoneNumber']['countryCode'],
        ),
      );
}
