import '../../domain/entity/customer_entity.dart';

class ModifyCustomerDto extends CustomerEntity {
  ModifyCustomerDto({
    required super.bankAccountNumberValueObject,
    required super.dateOfBirthValueObject,
    required super.emailValueObject,
    required super.phoneNumberValueObject,
    required super.firstNameValueObject,
    required super.lastNameValueObject,
  });

  Map<String, dynamic> toJson(final String id) => {
        'bankAccountNumber': bankAccountNumberValueObject.number,
        'dateOfBirth': dateOfBirthValueObject.dateOfBirth,
        'id': id,
        'email': emailValueObject.email,
        'phoneNumber': {
          'phoneNumber': phoneNumberValueObject.phoneNumber,
          'countryCode': phoneNumberValueObject.countryCode,
        },
        'firstName': firstNameValueObject.firstName,
        'lastName': lastNameValueObject.lastName,
      };
}
