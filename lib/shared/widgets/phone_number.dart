import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../../application/utils/utils.dart';

class PhoneNumber extends StatefulWidget {
  final void Function(CountryWithPhoneCode country, String phoneNumber)
      onPhoneNumberChanged;

  const PhoneNumber({required this.onPhoneNumberChanged, Key? key})
      : super(key: key);

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
    getAllSupportedRegionsFromLibPhone();
    super.initState();
  }

  Future<void> getAllSupportedRegionsFromLibPhone() async {
    supportedRegions = await getAllSupportedRegions();
    print(supportedRegions);
    setState(() {});
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
                validator: (final value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  if (!_isPhoneNumberValid) {
                    return 'Phone number is not valid';
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
