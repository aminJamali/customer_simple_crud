import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../shared/models/exception_model.dart';
import '../model/modify_customer_dto.dart';

class LocalDataSource {
  static const String customers = 'customers';
  static const String db = 'CustomerDb';

   Future<BoxCollection> openOrCreateDb() async {
    final directory = await getApplicationDocumentsDirectory();

    return BoxCollection.open(
      db,
      {customers},
      path: directory.path,
    );
  }

  Future<CollectionBox<dynamic>> openCustomerBox() async {
    final collection = await openOrCreateDb();

    return collection.openBox(customers);
  }

  Future<Either<ExceptionModel, String>> addCustomer(
    AddCustomerDto addCustomerDto,
  ) async {
    try {
      final customerBox = await openCustomerBox();
      await validateCustomer(
        firstName: addCustomerDto.firstNameValueObject.firstName,
        lastName: addCustomerDto.lastNameValueObject.lastName,
        email: addCustomerDto.emailValueObject.email,
        dateOfBirth: addCustomerDto.dateOfBirthValueObject.dateOfBirth,
      );
      final String uuid = const Uuid().v1();
      await customerBox.put(uuid, addCustomerDto.toJson(uuid));

      return Right(uuid);
    }on ExceptionModel catch (e) {
      return Left(e);
    }
  }

  Future<void> validateCustomer({
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String dateOfBirth,
  }) async {
    final customerBox = await openCustomerBox();
    final customers = await customerBox.getAllValues();
    customers.forEach((key, value) {
      if (value['firstName'] == firstName &&
          value['lastName'] == lastName &&
          value['dateOfBirth'] == dateOfBirth) {
        throw const ExceptionModel(message: 'Customer is duplicate');
      }
      if (value['email'] == email) {
        throw const ExceptionModel(message: 'Email is duplicate');
      }
    });
  }
}
