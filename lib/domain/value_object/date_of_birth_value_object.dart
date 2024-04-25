import '../failure/field_is_required_failure.dart';

class DateOfBirthValueObject {
  final String dateOfBirth;

  DateOfBirthValueObject(this.dateOfBirth) {
    if (dateOfBirth.isEmpty) {
      throw const FieldIsRequiredFailure('DateOfBirth is required');
    }
  }
}
