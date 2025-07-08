import 'package:flutter/material.dart';
import 'package:hotel_app/style/size.dart';
import 'package:intl/intl.dart' as intl;

const double cardHeight = 250;
const double cardHightTablet = 350;

const double factorOnMobile = 2 / 3;
const double factorOnTablet = 2 / 3;

const double textFactorMax = 1.1;
const double textFactorMaxMobile = 1;

double get cardFactor {
  if (!runOnTablet()) {
    return factorOnMobile;
  } else {
    return factorOnTablet;
  }
}

double get cardHight => isTablet ? cardHightTablet : cardHeight;
bool get isTablet => runOnTablet();

double getMaxSize({BuildContext? context}) {
  // if on tablate us maxFactor
  // if on mobile us maxFactorMobile
  return runOnTablet(context: context) ? textFactorMax : textFactorMaxMobile;
}

TextDirection getTextDirection() =>
    intl.Bidi.isRtlLanguage() ? TextDirection.rtl : TextDirection.ltr;

double getTheTextFactor(BuildContext context) {
  var r =
      MediaQuery.of(context).size.width * 0.0012 +
      MediaQuery.textScalerOf(context).scale(1.0);
  if (r > getMaxSize(context: context)) r = getMaxSize(context: context);
  return r;
}
