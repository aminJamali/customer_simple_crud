import 'dart:io';

import 'package:gherkin/gherkin.dart';
import 'package:hive/hive.dart';

class HiveCleanupHook extends Hook {
  @override
  Future<void> onBeforeRun(TestConfiguration config) async {
    print('Initializing Hive for tests...');

    final hiveDir = Directory('./hive_test_storage');

    if (!(await hiveDir.exists())) {
      await hiveDir.create(recursive: true);
      print('Created Hive test storage directory.');
    }

    Hive.init(hiveDir.path);
  }

  @override
  Future<void> onAfterRun(TestConfiguration config) async {
    print('Cleaning up Hive database...');

    try {
      await Hive.close();

      final hiveDir = Directory('./hive_test_storage');

      if (await hiveDir.exists()) {
        await hiveDir.delete(recursive: true);
        print('Hive database files deleted.');
      } else {
        print('Hive storage directory not found.');
      }
    } catch (e) {
      print('Error during Hive cleanup: $e');
    }
  }
}
