import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/domain/validators/mobile_number_validator.dart';

void main() {
  setUp(
    () async {

    },
  );

  test(
    'valid iranian mobile number must return true +98 901 452 3821',
    () async {
      final result = await MobileNumberValidator.validatePhoneNumber(
        phoneNumber: '+989121234567',
      );
      expect(result, true);
    },
  );


  test(
    'invalid iranian mobile number must return false +982188776655',
        () async {
      final result = await MobileNumberValidator.validatePhoneNumber(
        phoneNumber: '+982188776655',
      );
      expect(result, false);
    },
  );


}
