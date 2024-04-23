import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../failure/field_is_required_failure.dart';

class PhoneNumberValueObject {
  final String phoneNumber;
  final CountryWithPhoneCode code;

  PhoneNumberValueObject(this.phoneNumber, this.code) {
    _validate();
  }

  void _validate() {
    if (phoneNumber.isEmpty) {
      throw FieldIsRequiredFailure('PhoneNumber is required');
    }
  }
}
