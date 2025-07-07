
// FOR THE EXAMPLE WE DONT NEED THIS 

// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// Dio get dio => HttpManager.instance.dio;

// class HttpManager {
//   static final instance = HttpManager();

//   final dio = Dio();

//   void updateAuthHeader({String? token, String prefix = "Bearer"}) {
//     if (kDebugMode) {
//       log("$prefix $token");
//     }
//     if (token == null) {
//       dio.options.headers.remove("Authorization");
//       return;
//     }
//     dio.options.headers["Authorization"] = "$prefix $token";
//   }

//   void updateBaseHosted(String? baseUrl) {
//     if (kDebugMode || baseUrl == null) {
//       if (kReleaseMode) {
//         throw Exception("Base url is null");
//       }
//       dio.options = BaseOptions(
//         baseUrl: "http://localhost:8082",
//         headers: dio.options.headers,
//       );
//     } else {
//       dio.options = BaseOptions(baseUrl: baseUrl, headers: dio.options.headers);
//     }
//   }
// }
