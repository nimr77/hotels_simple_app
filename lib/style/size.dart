import 'package:flutter/material.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:hotel_app/style/common.dart';

Size getSize({BuildContext? context}) {
  final ctx =
      context ??
      mainNavigationKey.currentContext ??
      CommonThemeBuilders.context;
  return MediaQuery.of(ctx).size;
}

// double getTheHightOfHeader() => !runOnWildScreen() ? 100 : 100;
double heightCards() =>
    runOnWildScreen() ? getSize().height * 0.8 : getSize().height;
bool runOnTablet({BuildContext? context}) {
  // return false;
  final size = getSize(context: context);
  return size.height > 600 && size.width > 600;
}

bool runOnWildScreen() {
  final size = getSize();
  return size.height < size.width;
}

double widthCards() =>
    !runOnWildScreen() ? getSize().width : getSize().width * 0.8;
