import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'application/config/router/router.dart';
import 'application/config/theme/app_theme.dart';
import 'application/injection/app_injections.dart';
import 'package:flutter_driver/driver_extension.dart';


void main() async {

  enableFlutterDriverExtension();

  WidgetsFlutterBinding.ensureInitialized();

  await init();
  await AppInjections.initAppInjections();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.getThemeData(),
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        onGenerateRoute: AppRouter.onGenerateRoute,
      );
}
