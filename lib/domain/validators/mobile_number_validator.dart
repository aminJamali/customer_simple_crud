import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

class MobileNumberValidator {
  static Future<bool> validatePhoneNumber({
    required final String phoneNumber,
  }) async {
    try {
      final result = await parse(
        phoneNumber,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
