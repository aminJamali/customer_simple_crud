import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

import 'package:mc_crud_test/data/data_source/local_data_source.dart';
import 'package:mc_crud_test/data/model/customer_model.dart';
import 'package:mc_crud_test/data/model/modify_customer_dto.dart';
import 'package:mc_crud_test/domain/value_object/bank_account_number_value_object.dart';
import 'package:mc_crud_test/domain/value_object/date_of_birth_value_object.dart';
import 'package:mc_crud_test/domain/value_object/email_value_object.dart';
import 'package:mc_crud_test/domain/value_object/first_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/last_name_value_object.dart';
import 'package:mc_crud_test/domain/value_object/phone_number_value_object.dart';
import 'package:mc_crud_test/shared/models/exception_model.dart';
import 'package:mocktail/mocktail.dart';

class MockBoxCollection extends Mock implements BoxCollection {}

class MockCollectionBox extends Mock implements CollectionBox<dynamic> {}

void main() {
  late MockBoxCollection mockBoxCollection;
  late MockCollectionBox mockCollectionBox;
  late LocalDataSource localCustomerDataSource;

  setUp(
    () {
      mockBoxCollection = MockBoxCollection();
      mockCollectionBox = MockCollectionBox();
      localCustomerDataSource = LocalDataSource(mockBoxCollection);
    },
  );

  group('add customer data source tests', () {
    test(
      'add customer data source should return added customer\'s id',
      () async {
        when(
          () => localCustomerDataSource.openCustomerBox(),
        ).thenAnswer(
          (_) async => MockCollectionBox(),
        );
        when(
          () => mockBoxCollection.openBox<dynamic>('customers'),
        ).thenAnswer(
          (_) async => mockCollectionBox,
        );
        when(
          () => mockCollectionBox.getAllValues(),
        ).thenAnswer(
          (_) async => _fakeBoxValues,
        );

        when(
          () => mockCollectionBox.put(
            '12',
            _addCustomerFakeDto.toJson(),
          ),
        ).thenAnswer(
          (_) async => Future<void>,
        );
        final result = await localCustomerDataSource.addCustomer(
          _addCustomerFakeDto,
        );

        result.fold(
          (l) => null,
          (r) {
            expect(r.runtimeType, String);
          },
        );
      },
    );
    test(
      'add customer data source should return customer is duplicate exception',
      () async {
        when(
          () => localCustomerDataSource.openCustomerBox(),
        ).thenAnswer(
          (_) async => MockCollectionBox(),
        );
        when(
          () => mockBoxCollection.openBox<dynamic>('customers'),
        ).thenAnswer(
          (_) async => mockCollectionBox,
        );
        when(
          () => mockCollectionBox.getAllValues(),
        ).thenAnswer(
          (_) async => _fakeBoxValues,
        );

        when(
          () => mockCollectionBox.put(
            '12',
            _addCustomerFakeDto.toJson(),
          ),
        ).thenAnswer(
          (_) async => Future<void>,
        );
        final result = await localCustomerDataSource.addCustomer(
          _addCustomerFakeDto,
        );

        result.fold(
          (l) => expect(
            l,
            const ExceptionModel(message: 'Customer is duplicate'),
          ),
          (r) => null,
        );
      },
    );
  });

  group('get all customers data source tests', () {
    test(
      'should return a map with one item',
      () async {
        when(
          () => localCustomerDataSource.openCustomerBox(),
        ).thenAnswer(
          (_) async => MockCollectionBox(),
        );
        when(
          () => mockBoxCollection.openBox<dynamic>('customers'),
        ).thenAnswer(
          (_) async => mockCollectionBox,
        );
        when(
          () => mockCollectionBox.getAllValues(),
        ).thenAnswer(
          (_) async => _fakeBoxValues,
        );

        final result = await localCustomerDataSource.getAllCustomers();

        result.fold(
          (l) => null,
          (r) => expect(r.length, 1),
        );
      },
    );
  });

  group('get customer by id data source tests', () {
    test(
      'should return a valid customer model',
      () async {
        when(
          () => localCustomerDataSource.openCustomerBox(),
        ).thenAnswer(
          (_) async => MockCollectionBox(),
        );
        when(
          () => mockBoxCollection.openBox<dynamic>('customers'),
        ).thenAnswer(
          (_) async => mockCollectionBox,
        );
        when(
          () => mockCollectionBox.get('3'),
        ).thenAnswer(
          (_) async => _fakeSingleValue,
        );
        final getResult = await localCustomerDataSource.getCustomerById('3');

        getResult.fold(
          (l) => null,
          (r) => expect(_fakeCustomerModel('3'), CustomerModel.fromJson(r)),
        );
      },
    );
  });

  group('edit customer data source tests', () {
    test(
      'should return edited customer id',
      () async {
        when(
          () => localCustomerDataSource.openCustomerBox(),
        ).thenAnswer(
          (_) async => MockCollectionBox(),
        );
        when(
          () => mockBoxCollection.openBox<dynamic>('customers'),
        ).thenAnswer(
          (_) async => mockCollectionBox,
        );
        when(
          () => mockCollectionBox.getAllValues(),
        ).thenAnswer(
          (_) async => _fakeBoxValues,
        );

        when(
          () => mockCollectionBox.put(
            '12',
            _addCustomerFakeDto.toJson(),
          ),
        ).thenAnswer(
          (_) async => Future<void>,
        );
        final result =
            await localCustomerDataSource.editCustomer(_addCustomerFakeDto);

        result.fold(
          (l) => null,
          (r) => expect(r, '12'),
        );
      },
    );

  });
}

final Map<dynamic, dynamic> _fakeSingleValue = {
  'id': '3',
  'bankAccountNumber': '123456787',
  'dateOfBirth': '2024-01-23T10:24:16.642479',
  'email': 'amin22@gmail.com',
  'phoneNumber': {
    'phoneNumber': '9014536522',
    'countryCode': '98',
  },
  'firstName': 'reza',
  'lastName': 'jamali',
};

final Map<String, dynamic> _fakeBoxValues = {
  '1': {
    'id': '1',
    'bankAccountNumber': '123456787',
    'dateOfBirth': '2024-01-23T10:24:16.642479',
    'email': 'amin22@gmail.com',
    'phoneNumber': {
      'phoneNumber': '9014536522',
      'countryCode': '98',
    },
    'firstName': 'reza',
    'lastName': 'jamali',
  },
};

CustomerModel _fakeCustomerModel(final String id) => CustomerModel(
      id: id,
      bankAccountNumberValueObject: BankAccountNumberValueObject('123456787'),
      dateOfBirthValueObject:
          DateOfBirthValueObject('2024-01-23T10:24:16.642479'),
      emailValueObject: EmailValueObject('amin22@gmail.com'),
      phoneNumberValueObject: PhoneNumberValueObject('9014536522', '98'),
      firstNameValueObject: FirstNameValueObject('reza'),
      lastNameValueObject: LastNameValueObject('jamali'),
    );

final _addCustomerFakeDto = ModifyCustomerDto(
  id: '12',
  bankAccountNumberValueObject: BankAccountNumberValueObject('123456789'),
  dateOfBirthValueObject: DateOfBirthValueObject('2024-04-25T10:24:16.642479'),
  emailValueObject: EmailValueObject('amin@gmail.com'),
  phoneNumberValueObject: PhoneNumberValueObject('9014536521', '98'),
  firstNameValueObject: FirstNameValueObject('amin'),
  lastNameValueObject: LastNameValueObject('jamali'),
);
