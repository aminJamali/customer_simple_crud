import 'package:flutter/material.dart';

class Utils {
  static const double smallWidth = 576;
  static const double mediumWidth = 768;
  static const double largeWidth = 992;
  static const double extraLargeWidth = 1200;

  static const double smallSize = 15;
  static const double mediumSize = 20;
  static const double largeSize = 30;
  static const double tinySpace = 2;
  static const double smallSpace = 4;
  static const double mediumSpace = 8;
  static const double semiLargeSpace = 12;
  static const double largeSpace = 16;
  static const double extraLargeSpace = 32;
  static const double maxCrossAxisExtent = 100;
  static const double smallMaxCrossAxisExtent = 80;
  static const double maxWith = 700;
  static const tinyVerticalSpacer = SizedBox(height: Utils.tinySpace);
  static const smallVerticalSpacer = SizedBox(height: Utils.smallSpace);
  static const mediumVerticalSpacer = SizedBox(height: Utils.mediumSpace);
  static const largeVerticalSpacer = SizedBox(height: Utils.largeSpace);
  static const extraLargeVerticalSpacer =
      SizedBox(height: Utils.extraLargeSpace);

  static const tinyHorizontalSpacer = SizedBox(width: Utils.tinySpace);
  static const smallHorizontalSpacer = SizedBox(width: Utils.smallSpace);
  static const mediumHorizontalSpacer = SizedBox(width: Utils.mediumSpace);
  static const largeHorizontalSpacer = SizedBox(width: Utils.largeSpace);
  static const extraLargeHorizontalSpacer =
      SizedBox(width: Utils.extraLargeSpace);

  static const mediumPadding = EdgeInsetsDirectional.all(mediumSpace);
  static const smallPadding = EdgeInsetsDirectional.all(smallSpace);
  static const tinyPadding = EdgeInsetsDirectional.all(tinySpace);
  static const largePadding = EdgeInsetsDirectional.all(largeSpace);
  static const extraLargePadding = EdgeInsetsDirectional.all(extraLargeSpace);

  static const normalRadius = BorderRadius.all(
    Radius.circular(mediumSpace),
  );
}
