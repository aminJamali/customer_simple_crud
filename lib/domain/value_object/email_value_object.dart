


import '../failure/email_is_not_valid_failure.dart';
import '../failure/field_is_required_failure.dart';

class EmailValueObject {
  final String email;

  EmailValueObject(this.email) {
    _validateEmail(email);
  }

  void _validateEmail(final String? value) {
    if (value?.isNotEmpty ?? true) {
      const String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      final RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value!)) {
        throw EmailIsNotValidFailure('Email Address is not valid');
      }
    } else {
      throw FieldIsRequiredFailure('Email Address is required');
    }
  }
}
