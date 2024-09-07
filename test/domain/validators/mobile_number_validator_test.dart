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

      print('before init');
      await init();
      final supportedRegions = await getAllSupportedRegions();
      print(supportedRegions);


      print('inside the test');
      final result = await MobileNumberValidator.validatePhoneNumber(
        phoneNumber: '+989014523821',
      );
      expect(result, true);
    },
  );
}
