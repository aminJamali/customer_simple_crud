import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:uuid/uuid.dart';

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
import 'bloc/modify_customer_base_bloc.dart';
import 'bloc/modify_customer_event.dart';
import 'bloc/modify_customer_state.dart';

class ModifyCustomerScreen<B extends ModifyCustomerBaseBloc>
    extends StatefulWidget {
  final String screenTitle;
  final String? customerId;

  const ModifyCustomerScreen({
    required this.screenTitle,
    this.customerId,
    super.key,
  });

  @override
  State<ModifyCustomerScreen> createState() => _ModifyCustomerScreenState<B>();
}

class _ModifyCustomerScreenState<B extends ModifyCustomerBaseBloc>
    extends State<ModifyCustomerScreen> {
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController accountNumberTextController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  DateTime? selectedDateOfBirth;
  String? phoneNumber;
  CountryWithPhoneCode? selectedCountry;
  String? selectedCountryCode;

  @override
  void initState() {
    if (widget.customerId != null) {
      context.read<B>().add(
            GetCustomerByIdEvent(widget.customerId!),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.screenTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: Utils.largePadding,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: BlocConsumer<B, ModifyCustomerState>(
                  listener: (final _, final state) {
                    if (state is ModifyCustomerExceptionState) {
                      _onAddCustomerException(state);
                    }

                    if (state is ModifyCustomerDoneState) {
                      _onModifyCustomerDone(state.id);
                    }
                    if (state is GetCustomerByIdDoneState) {
                      _onGetCustomerByIdDoneState(state);
                    }
                  },
                  builder: (final _, final state) {
                    if (state is GetCustomerByIdLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is GetCustomerByIdExceptionState) {
                      return _retry(context, state);
                    }
                    return _body(context);
                  },
                ),
              ),
            ),
          ),
        ),
      );

  Widget _retry(BuildContext context, GetCustomerByIdExceptionState state) =>
      Center(
        child: ElevatedButton(
          onPressed: () => context.read<B>().add(
                GetCustomerByIdEvent(widget.customerId!),
              ),
          child: const Text('Try again'),
        ),
      );

  Widget _body(BuildContext context) => Column(
        children: [
          Utils.largeVerticalSpacer,
          TextFormField(
            key: const Key('firstName'),
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
            key: const Key('lastName'),
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
            key: const Key('bankAccountNumber'),
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
            key: const Key('email'),
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
            countryCode: selectedCountryCode,
            phoneNumber: phoneNumber,
            onPhoneNumberChanged: (final selectedCountry, final phoneNumber) {
              this.phoneNumber = phoneNumber;
              this.selectedCountry = selectedCountry;
              this.selectedCountryCode = selectedCountry.phoneCode;
            },
          ),
          Utils.largeVerticalSpacer,
          SelectDateWidget(
            selectedDate: selectedDateOfBirth,
            onDateSelected: (final value) {
              selectedDateOfBirth = value;
            },
          ),
          Utils.largeVerticalSpacer,
          BlocBuilder<B, ModifyCustomerState>(
            builder: (final _, final state) => _submit(context, state),
          ),
        ],
      );

  Widget _submit(BuildContext context, Object? state) => ElevatedButton(
        onPressed: _onSubmit,
        key: const Key('submit'),
        child: state is ModifyCustomerLoadingState
            ? const CircularProgressIndicator()
            : const Text('Submit'),
      );

  void _onGetCustomerByIdDoneState(
    final GetCustomerByIdDoneState state,
  ) {
    selectedDateOfBirth =
        DateTime.parse(state.customerModel.dateOfBirthValueObject.dateOfBirth);
    firstNameTextController.text =
        state.customerModel.firstNameValueObject.firstName;
    lastNameTextController.text =
        state.customerModel.lastNameValueObject.lastName;
    accountNumberTextController.text =
        state.customerModel.bankAccountNumberValueObject.number;
    emailTextController.text = state.customerModel.emailValueObject.email;
    phoneNumber = state.customerModel.phoneNumberValueObject.phoneNumber;
    selectedCountryCode =
        state.customerModel.phoneNumberValueObject.countryCode;
  }

  void _onAddCustomerException(final ModifyCustomerExceptionState state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text(state.exceptionModel.message),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (formKey.currentState!.validate()) {
      if (selectedDateOfBirth == null) {
        BotToast.showText(
          text: 'Date of birth is required',
        );
        return;
      }
      try {
        final modifyCustomerDto = ModifyCustomerDto(
          id: widget.customerId ?? const Uuid().v1(),
          bankAccountNumberValueObject: BankAccountNumberValueObject(
            accountNumberTextController.text,
          ),
          dateOfBirthValueObject: DateOfBirthValueObject(
            selectedDateOfBirth.toString(),
          ),
          emailValueObject: EmailValueObject(emailTextController.text),
          phoneNumberValueObject: PhoneNumberValueObject(
            phoneNumber!,
            selectedCountry!.phoneCode,
          ),
          firstNameValueObject: FirstNameValueObject(
            firstNameTextController.text,
          ),
          lastNameValueObject: LastNameValueObject(
            lastNameTextController.text,
          ),
        );
        context.read<B>().add(
              ModifyCustomerEvent(modifyCustomerDto),
            );
      } on BaseFailure catch (e) {
        BotToast.showText(text: e.message);
      }
    }
  }

  void _onModifyCustomerDone(final String id) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Center(
          child: Text(
            'Successfully Submitted!',
          ),
        ),
      ),
    );
    Navigator.pop(context, id);
    // Navigator.pop(context);
  }
}
