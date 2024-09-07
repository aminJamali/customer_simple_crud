import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../shared/models/exception_model.dart';
import '../model/modify_customer_dto.dart';

class LocalDataSource {
  static const String customers = 'customers';

  final BoxCollection boxCollection;

  LocalDataSource(this.boxCollection);

  Future<CollectionBox<dynamic>> openCustomerBox() =>
      boxCollection.openBox(customers);

  Future<bool> clearAllCustomers() async {
    try {
      final customers = await openCustomerBox();

      await customers.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Either<ExceptionModel, String>> editCustomer(
    final ModifyCustomerDto modifyCustomerDto,
  ) async {
    try {
      final customers = await openCustomerBox();

      await validateCustomerToEdit(
        id: modifyCustomerDto.id!,
        firstName: modifyCustomerDto.firstNameValueObject.firstName,
        lastName: modifyCustomerDto.lastNameValueObject.lastName,
        email: modifyCustomerDto.emailValueObject.email,
        dateOfBirth: modifyCustomerDto.dateOfBirthValueObject.dateOfBirth,
      );

      await customers.put(
        modifyCustomerDto.id!,
        modifyCustomerDto.toJson(),
      );

      return Right(modifyCustomerDto.id!);
    } on ExceptionModel catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ExceptionModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<ExceptionModel, Map<dynamic, dynamic>>> getCustomerById(
    final String id,
  ) async {
    final customers = await openCustomerBox();
    try {
      final customer = await customers.get(id);

      return Right(customer);
    } on ExceptionModel catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ExceptionModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<ExceptionModel, Map<String, dynamic>>> getAllCustomers() async {
    try {
      final customerBox = await openCustomerBox();

      final customers = await customerBox.getAllValues();

      return Right(customers);
    } on ExceptionModel catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ExceptionModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<Either<ExceptionModel, String>> addCustomer(
    ModifyCustomerDto addCustomerDto,
  ) async {
    try {
      final customerBox = await openCustomerBox();
      await validateCustomer(
        firstName: addCustomerDto.firstNameValueObject.firstName,
        lastName: addCustomerDto.lastNameValueObject.lastName,
        email: addCustomerDto.emailValueObject.email,
        dateOfBirth: addCustomerDto.dateOfBirthValueObject.dateOfBirth,
      );
      await customerBox.put(addCustomerDto.id, addCustomerDto.toJson());

      return Right(addCustomerDto.id);
    } on ExceptionModel catch (e) {
      return Left(e);
    } on Exception catch (e) {
      return Left(
        ExceptionModel(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> validateCustomerToEdit({
    required final String firstName,
    required final String lastName,
    required final String email,
    required final String dateOfBirth,
    required final String id,
  }) async {
    final customerBox = await openCustomerBox();
    final customers = await customerBox.getAllValues();
    customers.forEach((key, value) {
      value as Map<dynamic, dynamic>;
      if (value['firstName'] == firstName &&
          value['lastName'] == lastName &&
          value['dateOfBirth'] == dateOfBirth &&
          value['id'] != id) {
        throw const ExceptionModel(message: 'Customer is duplicate');
      }
      if (value['email'] == email && value['id'] != id) {
        throw const ExceptionModel(message: 'Email is duplicate');
      }
    });
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
      value as Map<dynamic, dynamic>;
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
