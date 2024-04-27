import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/domain/use_case/edit_customer_use_case.dart';
import 'package:mc_crud_test/domain/use_case/get_customer_by_id_use_case.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/presentation/add_customer/bloc/edit_customer_bloc.dart';
import 'package:mc_crud_test/presentation/add_customer/bloc/modify_customer_event.dart';
import 'package:mc_crud_test/presentation/add_customer/bloc/modify_customer_state.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCustomerByIdUseCase extends Mock
    implements GetCustomerByIdUseCase {}

class MockEditCustomerUseCase extends Mock implements EditCustomerUseCase {}

void main() {
  late MockGetCustomerByIdUseCase mockGetCustomerByIdUseCase;
  late MockEditCustomerUseCase mockEditCustomerUseCase;
  late EditCustomerBloc editCustomerBloc;

  setUp(
    () {
      mockGetCustomerByIdUseCase = MockGetCustomerByIdUseCase();
      mockEditCustomerUseCase = MockEditCustomerUseCase();
      editCustomerBloc = EditCustomerBloc(
        GetCustomerByIdLoadingState(),
        editCustomerUseCase: mockEditCustomerUseCase,
        getCustomerUseCase: mockGetCustomerByIdUseCase,
      );
    },
  );

  group('edit customer tests', () {
    blocTest<EditCustomerBloc, ModifyCustomerState>(
      'Emits [ModifyCustomerLoadingState,ModifyCustomerDoneState] when ModifyCustomerEvent is added',
      build: () {
        when(
          () => mockEditCustomerUseCase.call(_editCustomerFakeDto),
        ).thenAnswer(
          (_) async => const Right('1'),
        );
        return editCustomerBloc;
      },
      act: (bloc) => bloc.add(
        ModifyCustomerEvent(_editCustomerFakeDto),
      ),
      expect: () => [
        ModifyCustomerLoadingState(),
        ModifyCustomerDoneState('1'),
      ],
    );

    blocTest<EditCustomerBloc, ModifyCustomerState>(
      'Emits [ModifyCustomerLoadingState,ModifyCustomerExceptionState] when ModifyCustomerEvent is added',
      build: () {
        when(
          () => mockEditCustomerUseCase.call(_editCustomerFakeDto),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );
        return editCustomerBloc;
      },
      act: (bloc) => bloc.add(
        ModifyCustomerEvent(_editCustomerFakeDto),
      ),
      expect: () => [
        ModifyCustomerLoadingState(),
        ModifyCustomerExceptionState(
          const ExceptionModel(message: 'exception'),
        ),
      ],
    );
  });

  group('get customer by id tests', () {
    blocTest<EditCustomerBloc, ModifyCustomerState>(
      'Emits [GetCustomerByIdLoadingState,GetCustomerByIdDoneState] when GetCustomerByIdEvent is added',
      build: () {
        when(
          () => mockGetCustomerByIdUseCase.call('1'),
        ).thenAnswer(
          (_) async => Right(_fakeCustomerModel),
        );
        return editCustomerBloc;
      },
      act: (bloc) => bloc.add(
        GetCustomerByIdEvent('1'),
      ),
      expect: () => [
        GetCustomerByIdLoadingState(),
        GetCustomerByIdDoneState(_fakeCustomerModel),
      ],
    );
    blocTest<EditCustomerBloc, ModifyCustomerState>(
      'Emits [GetCustomerByIdLoadingState,GetCustomerByIdExceptionState] when GetCustomerByIdEvent is added',
      build: () {
        when(
          () => mockGetCustomerByIdUseCase.call('1'),
        ).thenAnswer(
          (_) async => const Left(
            ExceptionModel(message: 'exception'),
          ),
        );
        return editCustomerBloc;
      },
      act: (bloc) => bloc.add(
        GetCustomerByIdEvent('1'),
      ),
      expect: () => [
        GetCustomerByIdLoadingState(),
        GetCustomerByIdExceptionState(
          const ExceptionModel(message: 'exception'),
        ),
      ],
    );
  });
}

CustomerModel _fakeCustomerModel = CustomerModel(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456787'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-01-23T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin22@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536522', '98'),
  firstNameValueObject: FirstNameValueObject('reza'),
  lastNameValueObject: LastNameValueObject('jamali'),
);

final _editCustomerFakeDto = ModifyCustomerDto(
  id: '1',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
