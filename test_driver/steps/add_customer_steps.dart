import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_gherkin/flutter_gherkin.dart';
import 'package:gherkin/gherkin.dart';

StepDefinitionGeneric userObservesCustomerListRecordsStep() =>
    given1<String, FlutterWorld>(
      'User observes {string} text in Customer List',
      (key, context) async {
        final locator = find.text(key);
        final errorText =
            await FlutterDriverUtils.getText(context.world.driver!, locator);
        context.expectMatch(
          errorText,
          key,
        );
      },
    );

StepDefinitionGeneric userNavigatesToTheAddCustomerScreen() =>
    and1<String, FlutterWorld>(
      'Navigates to the Add Customer Screen by tapping {string} button',
      (key, context) async {
        final locator = find.byValueKey(key);
        await FlutterDriverUtils.tap(context.world.driver, locator);
      },
    );

StepDefinitionGeneric userCreateNewCustomer() => when<FlutterWorld>(
      'User create the customer with invalid mobile number',
      (context) async {},
    );

StepDefinitionGeneric userCorrectsCustomer() => when<FlutterWorld>(
      'user corrects the mobile number into a valid mobile number',
      (context) async {},
    );

StepDefinitionGeneric userEditsCustomerToAValidCustomer() => when<FlutterWorld>(
      'user edits the customer to a new valid customer',
      (context) async {},
    );

StepDefinitionGeneric userTapOn() => and1<String, FlutterWorld>(
      'tap on the {string} button',
      (key, context) async {
        final locator = find.byValueKey(key);
        await FlutterDriverUtils.tap(context.world.driver, locator);
      },
    );

StepDefinitionGeneric userTapOnButtonByText() => and1<String, FlutterWorld>(
      'tap on the {string} date button',
      (key, context) async {
        final locator = find.text(key);
        await FlutterDriverUtils.tap(context.world.driver, locator);
      },
    );

StepDefinitionGeneric userObservesError() => then1<String, FlutterWorld>(
      'user observes the error that {string}',
      (key, context) async {
        final locator = find.text(key);
        context.expectMatch(
          await FlutterDriverUtils.getText(context.world.driver!, locator),
          key,
        );
      },
    );

StepDefinitionGeneric userObservesCustomer() => then1<String, FlutterWorld>(
      'user observes {string} customer in the records list',
      (key, context) async {
        final locator = find.text(key);
        context.expectMatch(
          await FlutterDriverUtils.getText(context.world.driver!, locator),
          key,
        );
      },
    );

StepDefinitionGeneric userObservesSuccessMessage() =>
    then1<String, FlutterWorld>(
      'user observes the {string} message',
      (key, context) async {
        final locator = find.text(key);
        context.expectMatch(
          await FlutterDriverUtils.getText(context.world.driver!, locator),
          key,
        );
      },
    );

StepDefinitionGeneric fillTheFieldWith() => and2<String, String, FlutterWorld>(
      'fill the {string} field with {string}',
      (key, input, context) async {
        final locator = find.byValueKey(key);
        await FlutterDriverUtils.tap(context.world.driver, locator);
        await FlutterDriverUtils.enterText(
          context.world.driver,
          locator,
          input,
        );
      },
    );
