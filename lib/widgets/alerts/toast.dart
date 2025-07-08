import 'package:flutter/material.dart';
import 'package:hotel_app/routes/router.dart';
import 'package:toastification/toastification.dart';

enum ToastType {
  success,
  error,
  info,
  warning;

  Color get color {
    switch (this) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.info:
        return Colors.blue;
      case ToastType.warning:
        return Colors.orange;
    }
  }

  ToastificationType get _type => {
    ToastType.success: ToastificationType.success,
    ToastType.error: ToastificationType.error,
    ToastType.info: ToastificationType.info,
    ToastType.warning: ToastificationType.warning,
  }[this]!;

  show({Widget? title, Widget? description}) {
    return toastification.show(
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 6),
      context: homeNavigationKey.currentContext!,
      title: title,
      description: description,
      type: _type,
    );
  }

  showFromText({required String text, String? description}) {
    return toastification.show(
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 3),
      context: homeNavigationKey.currentContext!,
      title: Text(text, style: const TextStyle(fontSize: 18)),
      description: description != null
          ? Text(description, style: TextStyle(fontSize: 16))
          : null,
      type: _type,
    );
  }
}
