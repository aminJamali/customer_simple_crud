import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import '../../application/utils/utils.dart';
import '../../data/model/modify_customer_dto.dart';
import '../../domain/failure/base_failure.dart';
import '../../domain/value_object/bank_account_number_value_object.dart';
import '../../domain/value_object/date_of_birth_value_object.dart';
import '../../domain/value_object/email_value_object.dart';
import '../../domain/value_object/first_name_value_object.dart';
import '../../domain/value_object/last_name_value_object.dart';
import '../../domain/value_object/phone_number_value_object.dart';
import '../../shared/widgets/phone_number.dart';
import '../../shared/widgets/select_date_widget.dart';
import 'bloc/add_customer_bloc.dart';
import 'bloc/add_customer_event.dart';
import 'bloc/add_customer_state.dart';
import 'bloc/modify_customer_base_bloc.dart';

class ModifyCustomerScreen<T extends ModifyCustomerBaseBloc>
    extends StatefulWidget {
  const ModifyCustomerScreen({super.key});

  @override
  State<ModifyCustomerScreen> createState() => _ModifyCustomerScreenState<T>();
}

class _ModifyCustomerScreenState<T extends ModifyCustomerBaseBloc>
    extends State<ModifyCustomerScreen> {
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
                child: _body(context),
              ),
            ),
          ),
        ),
      );

  Widget _body(BuildContext context) => Column(
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
            onPhoneNumberChanged: (final selectedCountry, final phoneNumber) {
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
          BlocConsumer<T, AddCustomerState>(
            listener: (final _, final state) {
              if (state is AddCustomerExceptionState) {
                _onAddCustomerException(state);
              }
              if (state is AddCustomerDoneState) {
                _onAddCustomerDone();
              }
            },
            builder: (final _, final state) => _submit(context, state),
          ),
        ],
      );

  Widget _submit(BuildContext context, Object? state) => ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            if (selectedDateOfBirth == null) {
              BotToast.showText(
                text: 'Date of birth is required',
              );
            }
            try {
              final addCustomerDto = AddCustomerDto(
                bankAccountNumberValueObject: BankAccountNumberValueObject(
                  accountNumberTextController.text,
                ),
                dateOfBirthValueObject: DateOfBirthValueObject(
                  selectedDateOfBirth.toString(),
                ),
                emailValueObject: EmailValueObject(emailTextController.text),
                phoneNumberValueObject: PhoneNumberValueObject(
                  phoneNumber,
                  selectedCountry.countryCode,
                ),
                firstNameValueObject: FirstNameValueObject(
                  firstNameTextController.text,
                ),
                lastNameValueObject: LastNameValueObject(
                  lastNameTextController.text,
                ),
              );
              context.read<AddCustomerBloc>().add(
                    AddCustomerEvent(addCustomerDto),
                  );
            } on BaseFailure catch (e) {
              BotToast.showText(text: e.message);
            }
          }
        },
        child: state is AddCustomerLoadingState
            ? const CircularProgressIndicator()
            : const Text('Submit'),
      );

  void _onAddCustomerException(final AddCustomerExceptionState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(state.exceptionModel.message),
        ),
      ),
    );
  }

  void _onAddCustomerDone() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text('Successfully Submitted!'),
        ),
      ),
    );
    // Navigator.pop(context);
  }
}
