import '../../domain/entity/customer_entity.dart';

class ModifyCustomerDto extends CustomerEntity {
  final String id;

  ModifyCustomerDto({
    required super.bankAccountNumberValueObject,
    required super.dateOfBirthValueObject,
    required super.emailValueObject,
    required super.phoneNumberValueObject,
    required super.firstNameValueObject,
    required super.lastNameValueObject,
    required this.id,
  });


  Map<String, dynamic> toJson() => {
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
