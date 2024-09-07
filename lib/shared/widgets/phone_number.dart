import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../../application/utils/utils.dart';
import '../../domain/validators/mobile_number_validator.dart';

class PhoneNumber extends StatefulWidget {
  final void Function(CountryWithPhoneCode country, String phoneNumber)
      onPhoneNumberChanged;
  final String? phoneNumber;
  final String? countryCode;

  const PhoneNumber({
    required this.onPhoneNumberChanged,
    this.phoneNumber,
    this.countryCode,
    super.key,
  });

  @override
  State<PhoneNumber> createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  final TextEditingController textController = TextEditingController();

  Map<String, CountryWithPhoneCode> supportedRegions = {};
  CountryWithPhoneCode selectedCountryCode = const CountryWithPhoneCode.us();
  bool _isPhoneNumberValid = false;

  @override
  void initState() {
    super.initState();
    getAllSupportedRegionsFromLibPhone();
  }

  Future<void> getAllSupportedRegionsFromLibPhone() async {
    supportedRegions = await getAllSupportedRegions();
    if (widget.phoneNumber != null) {
      textController.text = widget.phoneNumber!;
    }
    if (widget.countryCode != null) {
      supportedRegions.forEach((key, value) {
        if (value.phoneCode == widget.countryCode) {
          selectedCountryCode = value;
        }
      });
      _isPhoneNumberValid = true;
    }
    setState(() {});
  }

  @override
  void setState(void Function() s) {
    if (mounted) {
      super.setState(s);
    }
  }

  @override
  Widget build(BuildContext context) => supportedRegions.isNotEmpty
      ? Row(
          children: [
            Expanded(
              child: DropdownButton<String>(
                value: selectedCountryCode.countryCode,
                items: supportedRegions.values
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.countryCode,
                        child: Text(e.countryCode),
                      ),
                    )
                    .toList(),
                onChanged: (final value) async {
                  if (value != null) {
                    selectedCountryCode = supportedRegions[value]!;
                  }
                  await _validatePhoneNumber();
                  setState(() {});
                },
              ),
            ),
            Utils.mediumHorizontalSpacer,
            Expanded(
              flex: 4,
              child: TextFormField(
                key: const Key('mobileNumber'),
                validator: (final value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!_isPhoneNumberValid) {
                    return 'mobile number is not valid';
                  }

                  widget.onPhoneNumberChanged.call(
                    selectedCountryCode,
                    textController.text,
                  );
                  return null;
                },
                onChanged: (final value) async {
                  await _validatePhoneNumber();
                },
                controller: textController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: const Text('Phone Number'),
                  prefixText: '(+${selectedCountryCode.phoneCode}) ',
                ),
                inputFormatters: [
                  LibPhonenumberTextFormatter(
                    country: selectedCountryCode,
                  ),
                ],
              ),
            ),
          ],
        )
      : const SizedBox();

  Future<void> _validatePhoneNumber() async {
    final result = await getFormattedParseResult(
      textController.text,
      selectedCountryCode,
    );
    if (result == null) {
      _isPhoneNumberValid = false;
    } else {
      _isPhoneNumberValid = true;
    }
  }
}
