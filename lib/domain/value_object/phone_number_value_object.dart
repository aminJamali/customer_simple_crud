
import '../failure/field_is_required_failure.dart';

class PhoneNumberValueObject {
  final String phoneNumber;
  final String countryCode;

  PhoneNumberValueObject(this.phoneNumber, this.countryCode) {
    _validate();
  }

  void _validate() {
    if (phoneNumber.isEmpty) {
      throw FieldIsRequiredFailure('PhoneNumber is required');
    }
  }
}
