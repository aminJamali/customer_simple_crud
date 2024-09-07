import 'dart:io';

import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

import 'hooks/clear_cache_hook.dart';
import 'steps/add_invalid_customer_step.dart';

Future<void> main(List<String> args) {
  if (args.isEmpty) {
    exit(1);
  }
  final config = FlutterTestConfiguration()
    ..features = [RegExp('features/*.*.feature')]
    ..reporters = [ProgressReporter()]
    ..stepDefinitions = [
      userObservesCustomerListRecordsStep(),
      userNavigatesToTheAddCustomerScreen(),
      userTapOn(),
      userObservesError(),
      fillTheFieldWith(),
      userCreateNewCustomer(),
      userTapOnButtonByText(),
      userObservesSuccessMessage(),
      userObservesCustomer(),
      userCorrectsCustomer(),
      userEditsCustomerToAValidCustomer(),
    ]
    ..hooks = [
      // ClearCacheHook(),
    ]
    ..flutterBuildTimeout = const Duration(minutes: 5)
    ..targetAppWorkingDirectory = '../'
    ..restartAppBetweenScenarios = false
    ..targetAppPath = 'test_driver/app.dart'
    ..runningAppProtocolEndpointUri = args[0];
  return GherkinRunner().execute(config);
}
