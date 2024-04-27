import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/domain/use_case/add_customer_use_case.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/presentation/add_customer/bloc/add_customer_bloc.dart';
import 'package:mc_crud_test/presentation/add_customer/bloc/modify_customer_event.dart';
import 'package:mc_crud_test/presentation/add_customer/bloc/modify_customer_state.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';
import 'package:mocktail/mocktail.dart';



class MockAddCustomerUseCase extends Mock implements AddCustomerUseCase {}

void main() {
  late MockAddCustomerUseCase mockAddCustomerUseCase;
  late AddCustomerBloc addCustomerBloc;

  setUp(
    () {
      mockAddCustomerUseCase = MockAddCustomerUseCase();
      addCustomerBloc = AddCustomerBloc(
        initialState: AddCustomerInitialState(),
        addCustomerUseCase: mockAddCustomerUseCase,
      );
    },
  );

  blocTest<AddCustomerBloc, ModifyCustomerState>(
    'Emits [AddCustomerLoadingState,AddCustomerDoneState] when AddCustomerEvent is added',
    build: () {
      when(
        () => mockAddCustomerUseCase.call(_addCustomerFakeDto),
      ).thenAnswer(
        (_) async => const Right('1'),
      );
      return addCustomerBloc;
    },
    act: (bloc) => bloc.add(
      ModifyCustomerEvent(_addCustomerFakeDto),
    ),
    expect: () => [
      ModifyCustomerLoadingState(),
      ModifyCustomerDoneState('1'),
    ],
  );

  blocTest<AddCustomerBloc, ModifyCustomerState>(
    'Emits [AddCustomerLoadingState,AddCustomerExceptionState] when AddCustomerEvent is added',
    build: () {
      when(
        () => mockAddCustomerUseCase.call(_addCustomerFakeDto),
      ).thenAnswer(
        (_) async => const Left(
          ExceptionModel(message: 'exception'),
        ),
      );
      return addCustomerBloc;
    },
    act: (bloc) => bloc.add(
      ModifyCustomerEvent(_addCustomerFakeDto),
    ),
    expect: () => [
      ModifyCustomerLoadingState(),
      ModifyCustomerExceptionState(const ExceptionModel(message: 'exception')),
    ],
  );
}

final _addCustomerFakeDto = ModifyCustomerDto(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
