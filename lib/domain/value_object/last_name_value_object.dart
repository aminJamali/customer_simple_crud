import '../failure/field_is_required_failure.dart';

class LastNameValueObject {
  final String lastName;

  LastNameValueObject(this.lastName) {
    if (lastName.isEmpty) {
      throw const FieldIsRequiredFailure('LastName is required');
    }
  }
}
