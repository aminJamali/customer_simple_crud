import '../failure/field_is_required_failure.dart';

class FirstNameValueObject {
  final String firstName;

  FirstNameValueObject(this.firstName) {
    if (firstName.isEmpty) {
      throw FieldIsRequiredFailure('FirstName is required');
    }
  }
}
