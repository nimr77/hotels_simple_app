import 'dart:io';

import 'package:flutter/widgets.dart';

EdgeInsets get bottomNavigatorPadding => EdgeInsets.only(
    bottom: 20, left: 20, right: 20, top: Platform.isAndroid ? 20 : 20);
EdgeInsets get boxMergerPaddingAllSmallInfo =>
    const EdgeInsets.symmetric(horizontal: 8, vertical: 8);

EdgeInsets get boxMergerPaddingOnlyHerzontal => const EdgeInsets.symmetric(
      horizontal: 8,
    );

EdgeInsets get elementHeroPadding => const EdgeInsets.only(
      bottom: 12,
    );

EdgeInsets get elementHeroPaddingTop => const EdgeInsets.only(
      top: 12,
    );
EdgeInsets get elementPadding => const EdgeInsets.symmetric(
      vertical: 8,
    );

EdgeInsets get elementPaddingWithShadow => const EdgeInsets.only(
      bottom: 15,
    );

EdgeInsets get elementsPaddingWithTitle => const EdgeInsets.only(
      top: 5,
    );

EdgeInsets get elementsPaddingWithTitleBottom => const EdgeInsets.only(
      bottom: 5,
    );

EdgeInsets get elementsPaddingWithTitleBotton => const EdgeInsets.only(
      top: 5,
    );

double get elementsSpacing => 16;
double get heroSectionHight => 16;
EdgeInsets get ineerPaddingSearchPadding =>
    const EdgeInsets.all(12)..add(const EdgeInsets.symmetric(horizontal: 10));

EdgeInsets get infoBoxPadding => const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    );
double get infoPaddingHValue => 16;

EdgeInsets get pagePadding => const EdgeInsets.symmetric(
      horizontal: 16,
    );

EdgeInsets get titleHeroPadding => const EdgeInsets.symmetric(
      vertical: 5,
    );

EdgeInsets get verticalScrollElementsPadding => const EdgeInsets.only(
      bottom: 12,
    );

EdgeInsets navigatorPadding(BuildContext context) {
  final padding = MediaQuery.of(context).padding;

  return EdgeInsets.symmetric(
      horizontal: 8 + (Platform.isIOS ? 0 : 0) + padding.horizontal,
      vertical: 10 + (padding.vertical / 2));
}
