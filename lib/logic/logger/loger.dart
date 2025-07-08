import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hotel_app/widgets/alerts/toast.dart';
import 'package:logger/logger.dart';

void logError(
  String message, {
  dynamic error,
  StackTrace? stackTrace,
  DioException? dioException,
  String? toastMessage,
  bool showToast = true,
}) {
  if (kDebugMode) {
    if (error is DioException) {
      Logger().e(
        {
          "message": message,
          "headers": error.response?.headers.map,
          "data": error.response?.data is String
              ? json.decode(error.response?.data)
              : error.response?.data,
          "url": error.response?.requestOptions.uri.toString(),
          "request": error.requestOptions.data,
        },
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      Logger().e(message, error: error, stackTrace: stackTrace);
    }
  }

  if (showToast) {
    ToastType.error.showFromText(text: toastMessage ?? message);
  }
}
