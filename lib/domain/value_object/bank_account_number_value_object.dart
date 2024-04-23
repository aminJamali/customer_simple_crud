import '../failure/bank_account_number_is_not_valid_failure.dart';
import '../failure/field_is_required_failure.dart';

class BankAccountNumberValueObject {
  final String number;

  BankAccountNumberValueObject(this.number) {
    _validateBankAccountNumber(number);
  }

  static void _validateBankAccountNumber(
    final String value,
  ) {
    if (value.isNotEmpty) {
      const String pattern = r'^[0-9]{9,18}$';
      final RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        throw BankAccountNumberIsNotValidFailure('Bank Account Number is not valid');
      }
    } else {
      throw FieldIsRequiredFailure('Bank Account Number is required');
    }
  }
}
