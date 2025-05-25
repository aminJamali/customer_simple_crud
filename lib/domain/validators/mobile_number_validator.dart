// import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class MobileNumberValidator {
  static Future<bool> validatePhoneNumber({
    required final String phoneNumber,
  }) async {
    try {
      final parsedNumber = PhoneNumber.parse(phoneNumber);
      return parsedNumber.isValid(type: PhoneNumberType.mobile);
    } catch (e) {
      return false;
    }
  }
}
