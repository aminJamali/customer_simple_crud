import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
import 'package:mc_crud_test/domain/repository/customer_repository.dart';
import 'package:mc_crud_test/domain/use_case/get_all_customers_use_case.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/presentation/customer_list/bloc/get_all_customers_bloc.dart';
import 'package:mc_crud_test/presentation/customer_list/bloc/get_all_customers_event.dart';
import 'package:mc_crud_test/presentation/customer_list/bloc/get_all_customers_state.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';
import 'package:mocktail/mocktail.dart';

class MockAddCustomerRepository extends Mock implements CustomerRepository {}

class MockAddCustomerUseCase extends Mock implements GetAllCustomersUseCase {}

void main() {
  late MockAddCustomerUseCase mockGetAllCustomerUseCase;
  late GetAllCustomersBloc getAllCustomerBloc;

  setUp(
    () {
      mockGetAllCustomerUseCase = MockAddCustomerUseCase();
      getAllCustomerBloc = GetAllCustomersBloc(
        GetAllCustomersLoadingState(),
        mockGetAllCustomerUseCase,
      );
    },
  );

  blocTest<GetAllCustomersBloc, GetAllCustomersState>(
    'Emits [GetAllCustomersLoadingState,GetAllCustomerDoneState] when GetAllCustomersEvent is added',
    build: () {
      when(
        () => mockGetAllCustomerUseCase.call(null),
      ).thenAnswer(
        (_) async => Right(_fakeCustomerList),
      );
      return getAllCustomerBloc;
    },
    act: (bloc) => bloc.add(GetAllCustomersEvent()),
    expect: () => [
      GetAllCustomersLoadingState(),
      GetAllCustomersDoneState(_fakeCustomerList),
    ],
  );

  blocTest<GetAllCustomersBloc, GetAllCustomersState>(
    'Emits [GetAllCustomersLoadingState,GetAllCustomerEmptyState] when GetAllCustomersEvent is added',
    build: () {
      when(
        () => mockGetAllCustomerUseCase.call(null),
      ).thenAnswer(
        (_) async => const Right([]),
      );
      return getAllCustomerBloc;
    },
    act: (bloc) => bloc.add(GetAllCustomersEvent()),
    expect: () => [
      GetAllCustomersLoadingState(),
      GetAllCustomersEmptyState(),
    ],
  );

  blocTest<GetAllCustomersBloc, GetAllCustomersState>(
    'Emits [GetAllCustomersLoadingState,GetAllCustomerExceptionState] when GetAllCustomersEvent is added',
    build: () {
      when(
        () => mockGetAllCustomerUseCase.call(null),
      ).thenAnswer(
        (_) async => const Left(
          ExceptionModel(message: 'exception'),
        ),
      );
      return getAllCustomerBloc;
    },
    act: (bloc) => bloc.add(GetAllCustomersEvent()),
    expect: () => [
      GetAllCustomersLoadingState(),
      GetAllCustomersExceptionState(
        const ExceptionModel(message: 'exception'),
      ),
    ],
  );
}

final _fakeCustomerList = [
  CustomerModel(
    bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
    dateOfBirthValueObject:
        DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
    id: '1',
    emailValueObject: EmailValueObject('amin@gmail.com'),
    phoneNumberValueObject: PhoneNumberValueObject('9014523821', '98'),
    firstNameValueObject: FirstNameValueObject('amin'),
    lastNameValueObject: LastNameValueObject('jamali'),
  ),
];
