import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../../application/utils/utils.dart';
import '../../domain/entity/customer_entity.dart';
import '../../domain/failure/base_failure.dart';
import '../../domain/value_object/bank_account_number_value_object.dart';
import '../../domain/value_object/date_of_birth_value_object.dart';
import '../../domain/value_object/email_value_object.dart';
import '../../domain/value_object/first_name_value_object.dart';
import '../../domain/value_object/last_name_value_object.dart';
import '../../domain/value_object/phone_number_value_object.dart';
import '../../shared/widgets/phone_number.dart';
import '../../shared/widgets/select_date_widget.dart';

class ModifyCustomerScreen extends StatefulWidget {
  const ModifyCustomerScreen({Key? key}) : super(key: key);

  @override
  State<ModifyCustomerScreen> createState() => _ModifyCustomerScreenState();
}

class _ModifyCustomerScreenState extends State<ModifyCustomerScreen> {
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController accountNumberTextController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  DateTime? selectedDateOfBirth;
  late String phoneNumber;
  late CountryWithPhoneCode selectedCountry;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add Customer'),
        ),
        body: SafeArea(
          child: Padding(
            padding: Utils.largePadding,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Utils.largeVerticalSpacer,
                    TextFormField(
                      validator: (final value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      controller: firstNameTextController,
                      decoration: const InputDecoration(
                        label: Text('First Name'),
                      ),
                    ),
                    Utils.largeVerticalSpacer,
                    TextFormField(
                      validator: (final value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      controller: lastNameTextController,
                      decoration: const InputDecoration(
                        label: Text('Last Name'),
                      ),
                    ),
                    Utils.largeVerticalSpacer,
                    TextFormField(
                      validator: (final value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      controller: accountNumberTextController,
                      decoration: const InputDecoration(
                        label: Text('Bank Account Number'),
                      ),
                    ),
                    Utils.largeVerticalSpacer,
                    TextFormField(
                      validator: (final value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                      controller: emailTextController,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                      ),
                    ),
                    Utils.largeVerticalSpacer,
                    PhoneNumber(
                      onPhoneNumberChanged:
                          (final selectedCountry, final phoneNumber) {
                        this.phoneNumber = phoneNumber;
                        this.selectedCountry = selectedCountry;
                      },
                    ),
                    Utils.largeVerticalSpacer,
                    SelectDateWidget(
                      onDateSelected: (final value) {
                        selectedDateOfBirth = value;
                      },
                    ),
                    Utils.largeVerticalSpacer,
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (selectedDateOfBirth == null) {
                            BotToast.showText(
                              text: 'Date of birth is required',
                            );
                          }
                          try {
                            final model = CustomerEntity(
                              bankAccountNumberValueObject:
                                  BankAccountNumberValueObject(
                                accountNumberTextController.text,
                              ),
                              dateOfBirthValueObject: DateOfBirthValueObject(
                                selectedDateOfBirth.toString(),
                              ),
                              emailValueObject:
                                  EmailValueObject(emailTextController.text),
                              phoneNumberValueObject: PhoneNumberValueObject(
                                phoneNumber,
                                selectedCountry,
                              ),
                              firstNameValueObject: FirstNameValueObject(
                                firstNameTextController.text,
                              ),
                              lastNameValueObject: LastNameValueObject(
                                lastNameTextController.text,
                              ),
                            );
                          } on BaseFailure catch (e) {
                            BotToast.showText(text: e.message);
                          }
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
