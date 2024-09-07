// import 'package:flutter/material.dart';
// import 'package:gherkin/gherkin.dart';
// import 'package:mc_crud_test/application/injection/app_injections.dart';
// import 'package:mc_crud_test/data/data_source/local_data_source.dart';
//
// class ClearCacheHook extends Hook {
//   @override
//   Future<void> onBeforeScenario(
//     TestConfiguration config,
//     String scenario,
//     Iterable<Tag> tags,
//   ) async {
//     debugPrint(
//       '======================> Delete Customers Hook <=====================',
//     );
//     final dataSource = AppInjections.customerGetIt<LocalDataSource>();
//     final result = await dataSource.clearAllCustomers();
//
//     if (result) {
//       debugPrint('Customers Successfully Deleted');
//     } else {
//       debugPrint('Something Went Wrong While Deleting Customers');
//     }
//   }
// }
