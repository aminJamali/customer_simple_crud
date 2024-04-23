import 'package:flutter/material.dart';

import '../../utils/utils.dart';


class AppTheme {
  static MaterialColor primarySwatch =
      const MaterialColor(0xFF10AC84, <int, Color>{
    50: Color(0xff0e9b77),
    100: Color(0xff0d8a6a),
    200: Color(0xff0b785c),
    300: Color(0xff0a674f),
    400: Color(0xff085642),
    500: Color(0xff064535),
    600: Color(0xff053428),
    700: Color(0xff03221a),
    800: Color(0xff02110d),
    900: Color(0xff000000),
  });
  static Color secondaryColor = const Color(0xff000000);
  static Color successColor = const Color(0xff08C94F);
  static Color warningColor = const Color(0xffF8833E);
  static Color dangerColor = const Color(0xffDC2626);

  static Color white = Colors.white;
  static Color black = Colors.black;

  static Color textColor = black;
  static Color textInputBorderColor = Colors.black54;
  static Color scaffoldBackgroundColor = const Color(0xffEBEBEB);
  static Color cardColor = white;
  static Color borderColor = const Color(0xffd3d3d3);
  static Color disabledColor = Colors.grey.withOpacity(.8);

  static ThemeData getThemeData() => ThemeData(
        primaryColor: primarySwatch,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: primarySwatch,
          accentColor: secondaryColor,
          backgroundColor: scaffoldBackgroundColor,
          cardColor: cardColor,
          errorColor: dangerColor,
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: BorderSide(width: 1, color: borderColor),
        ),
        disabledColor: disabledColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: _textTheme(),
        filledButtonTheme: _filledButtonTheme(),
        textButtonTheme: _flatButtonTheme(),
        floatingActionButtonTheme: _floatingActionButtonThemeData(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
        outlinedButtonTheme: _outlinedButtonThemeData(),
        buttonTheme: _buttonThemeData(),
        iconButtonTheme: _iconButtonThemeData(),
        inputDecorationTheme: _inputTheme(),
        textSelectionTheme: TextSelectionThemeData(cursorColor: primarySwatch),
        listTileTheme: ListTileThemeData(
          iconColor: textColor,
        ),
        drawerTheme: DrawerThemeData(
          backgroundColor: cardColor,
        ),
        iconTheme: IconThemeData(
          color: textColor,
        ),
        cardColor: cardColor,
        dialogBackgroundColor: cardColor,
      );

  static IconButtonThemeData _iconButtonThemeData() => IconButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(
              style: BorderStyle.solid,
              color: secondaryColor,
              width: 2,
            ),
          ),
        ),
      );

  static ButtonThemeData _buttonThemeData() => ButtonThemeData(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.accent,
        shape: const RoundedRectangleBorder(
          borderRadius: Utils.normalRadius,
        ),
      );

  static OutlinedButtonThemeData _outlinedButtonThemeData() =>
      OutlinedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            _textTheme().labelMedium!.copyWith(
                  fontSize: 16,
                  color: Colors.grey,
                ),
          ),
          side: MaterialStateProperty.all(
            const BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey,
              width: 0.9,
            ),
          ),
        ),
      );

  static ElevatedButtonThemeData _elevatedButtonThemeData() =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(fontSize: 16),
          backgroundColor: secondaryColor,
          foregroundColor: cardColor,
        ),
      );

  static FloatingActionButtonThemeData _floatingActionButtonThemeData() =>
      FloatingActionButtonThemeData(
        backgroundColor: secondaryColor,
        splashColor: cardColor,
        foregroundColor: cardColor,
      );

  static InputDecorationTheme _inputTheme() => InputDecorationTheme(
        labelStyle: const TextStyle(fontSize: 16),
        suffixStyle: const TextStyle(fontSize: 16),
        hintStyle: const TextStyle(fontSize: 16),
        iconColor: primarySwatch,
        suffixIconColor: primarySwatch,
        floatingLabelStyle: const TextStyle(fontSize: 16),
        contentPadding:
            const EdgeInsets.only(left: 8, bottom: 4, right: 4, top: 4),
        border: OutlineInputBorder(
          borderRadius: Utils.normalRadius,
          borderSide: BorderSide(
            color: textInputBorderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: Utils.normalRadius,
          borderSide: BorderSide(
            color: textInputBorderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: primarySwatch,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: dangerColor,
          ),
        ),
      );

  static FilledButtonThemeData _filledButtonTheme() =>
      FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
            primarySwatch,
          ),
          textStyle: MaterialStatePropertyAll(
            _textTheme().labelMedium!.copyWith(
                  color: white,
                  fontSize: 16,
                ),
          ),
        ),
      );

  static TextButtonThemeData _flatButtonTheme() => TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(
            Colors.transparent,
          ),
          textStyle: MaterialStatePropertyAll(
            _textTheme().titleSmall!.copyWith(color: Colors.blue),
          ),
        ),
      );

  static TextTheme _textTheme() => TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          color: textColor,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          color: textColor,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          color: textColor,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          color: textColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          color: textColor,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          letterSpacing: 0.15,
          color: textColor,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          letterSpacing: 0.1,
          color: textColor,
        ),
        labelLarge: TextStyle(
          fontSize: 22,
          letterSpacing: 0.1,
          color: textColor,
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          letterSpacing: 0.5,
          color: textColor,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          letterSpacing: 0.5,
          color: textColor,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          letterSpacing: 0.15,
          color: textColor,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          letterSpacing: 0.25,
          color: textColor,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          letterSpacing: 0.4,
        ),
      );
}
