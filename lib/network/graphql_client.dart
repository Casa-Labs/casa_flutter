// import 'dart:async';
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' hide Response;
// import 'package:go_router/go_router.dart';
// // import 'package:http/http.dart' as http; // used for form data
// import 'package:http/http.dart';
//
// import '../routes/app_routes.dart';
// import '../src/common/service/global_navigator_service.dart';
// import '../src/common/widgets/loading_dialog.dart';
// import '../src/common/widgets/response_dialog.dart';
// import '../utils/preference_manager.dart';
// import '../utils/utils.dart';
// import 'api_endpoints.dart';
//
// class HttpClient {
//   HttpClient._privateConstructor();
//
//   static final HttpClient _instance = HttpClient._privateConstructor();
//
//   factory HttpClient() {
//     return _instance;
//   }
//
//   static Map<String, String> getHeaders() {
//     var header = <String, String>{
//       "Authorization":
//           "Bearer ${PreferenceManager.getString(PreferenceManager.token)}",
//       "Accept": "application/json",
//       "content-type": "application/json",
//     };
//     logg.i(header);
//     return header;
//   }
//
//   static Map<String, String> getHeadersWithoutToken() {
//     var header = <String, String>{
//       "Accept": "application/json",
//       "content-type": "application/json",
//     };
//     logg.i(header);
//     return header;
//   }
//
//   Future<Response> getRequest(String path) async {
//     Response response;
//
//     LoadingDialog.showProgressIndicatorAlertDialog();
//     try {
//       response = await get(
//         Uri.parse(ApiEndpoints.baseUrl + path),
//         headers: getHeaders(),
//       ).timeout(const Duration(seconds: 30));
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//     } on TimeoutException {
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//       throw TimeoutException('Can\'t connect in 30 seconds.');
//     } catch (e) {
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//       logg.e('Error: $e');
//       rethrow;
//     }
//     logg.i(ApiEndpoints.baseUrl + path);
//     if (isJson(response.body)) {
//       debugPrint('Response Body: ');
//       prettyPrintJson(response.body);
//       switch (response.statusCode) {
//         case 500:
//           {
//             Get.snackbar('Error', 'Server Error');
//           }
//           break;
//
//         case 401:
//           {
//             Get.snackbar(
//                 'Error', 'Your Session is Expired, You Need to Login Again.',
//                 onTap: (_) => navigatorKey.currentContext
//                     ?.goNamed(RouteNames.welcomeAuth));
//           }
//           break;
//
//         case 200:
//         // var decode = json.decode(response.body);
//         // switch (decode['statusCode']) {
//         //   case 500:
//         //     {
//         //       Get.snackbar('Error', decode['message']);
//         //     }
//         //     break;
//         // }
//       }
//     } else {
//       logg.e(response.body, error: 'Response body is not a JSON object');
//     }
//     return response;
//   }
//
//   Future<Response> postRequest(String path,
//       {Map<String, dynamic>? body}) async {
//     LoadingDialog.showProgressIndicatorAlertDialog();
//     Response response;
//     try {
//       response = await post(
//         Uri.parse(ApiEndpoints.baseUrl + path),
//         headers: getHeaders(),
//         body: jsonEncode(body),
//       ).timeout(const Duration(seconds: 30));
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//     } on TimeoutException {
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//       throw TimeoutException('Can\'t connect in 30 seconds.');
//     } catch (e) {
//       logg.e('Error: $e');
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//       rethrow;
//     }
//
//     logg.i(ApiEndpoints.baseUrl + path);
//     debugPrint('Request Body: ');
//     prettyPrintJson(jsonEncode(body));
//     if (isJson(response.body)) {
//       debugPrint('Response Body: ');
//       prettyPrintJson(response.body);
//       switch (response.statusCode) {
//         case 500:
//           {
//             Get.snackbar('Error', 'Server Error');
//           }
//           break;
//
//         case 401:
//           {
//             Get.snackbar(
//                 'Error', 'Your Session is Expired, You Need to Login Again.',
//                 onTap: (_) => navigatorKey.currentContext
//                     ?.goNamed(RouteNames.welcomeAuth));
//           }
//           break;
//
//         case 200:
//           var decode = json.decode(response.body);
//           switch (decode['statusCode']) {
//             case 500:
//               {
//                 Get.snackbar('Error', decode['message']);
//               }
//               break;
//           }
//       }
//     } else {
//       logg.e(response.body, error: 'Response body is not a JSON object');
//     }
//
//     return response;
//   }
//
//   Future<Response> postRequestWithoutToken(String path,
//       {Map<String, dynamic>? body}) async {
//     LoadingDialog.showProgressIndicatorAlertDialog();
//     Response response;
//     try {
//       response = await post(
//         Uri.parse(ApiEndpoints.baseUrl + path),
//         headers: getHeadersWithoutToken(),
//         body: jsonEncode(body),
//       ).timeout(const Duration(seconds: 30));
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//     } on TimeoutException {
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//       throw TimeoutException('Can\'t connect in 30 seconds.');
//     } catch (e) {
//       logg.e('Error: $e');
//       LoadingDialog.removeProgressIndicatorAlertDialog();
//       rethrow;
//     }
//
//     logg.i(ApiEndpoints.baseUrl + path);
//     if (isJson(response.body)) {
//       prettyPrintJson(response.body);
//     } else {
//       logg.e(response.body, error: 'Response body is not a JSON object');
//     }
//
//     switch (response.statusCode) {
//       case 500:
//         {
//           Get.snackbar('Error', 'Server Error');
//         }
//         break;
//
//       case 401:
//         {
//           Get.snackbar(
//               'Error', 'Your Session is Expired, You Need to Login Again.',
//               onTap: (_) =>
//                   navigatorKey.currentContext?.goNamed(RouteNames.welcomeAuth));
//         }
//         break;
//
//       case 200:
//         var decode = json.decode(response.body);
//         switch (decode['statusCode']) {
//           case 500:
//             {
//               Get.snackbar('Error', decode['message']);
//             }
//             break;
//         }
//     }
//     return response;
//   }
//
//   Future<Response> deleteRequest(String path,
//       {Map<dynamic, dynamic>? body}) async {
//     LoadingDialog.showProgressIndicatorAlertDialog();
//
//     logg.d(ApiEndpoints.baseUrl + path);
//     prettyPrintMap(body);
//
//     Response response = await delete(
//       Uri.parse(ApiEndpoints.baseUrl + path),
//       headers: getHeaders(),
//       body: body != null ? jsonEncode(body) : null, // Added body field here
//     ).timeout(
//       const Duration(seconds: 30),
//       onTimeout: () {
//         LoadingDialog.removeProgressIndicatorAlertDialog();
//         ResponseDialog.showErrorDialog(
//             errorText: "Something went wrong,Please try again.",
//             onPressed: () {
//               Get.back();
//             });
//         throw TimeoutException('Can\'t connect in 30 seconds.');
//       },
//     );
//
//     LoadingDialog.removeProgressIndicatorAlertDialog();
//     logg.i(ApiEndpoints.baseUrl + path);
//     if (isJson(response.body)) {
//       debugPrint('Response Body: ');
//       prettyPrintJson(response.body);
//       switch (response.statusCode) {
//         case 500:
//           {
//             Get.snackbar('Error', 'Server Error');
//           }
//           break;
//
//         case 401:
//           {
//             Get.snackbar(
//                 'Error', 'Your Session is Expired, You Need to Login Again.',
//                 onTap: (_) => navigatorKey.currentContext
//                     ?.goNamed(RouteNames.welcomeAuth));
//           }
//           break;
//
//         case 200:
//         // var decode = json.decode(response.body);
//         // switch (decode['statusCode']) {
//         //   case 500:
//         //     {
//         //       Get.snackbar('Error', decode['message']);
//         //     }
//         //     break;
//         // }
//       }
//     } else {
//       logg.e(response.body, error: 'Response body is not a JSON object');
//     }
//     return response;
//   }
//
//   Future<Response> putRequest(String path,
//       {Map<dynamic, dynamic>? body}) async {
//     LoadingDialog.showProgressIndicatorAlertDialog();
//
//     logg.d(ApiEndpoints.baseUrl + path);
//     // print(getHeaders());
//     prettyPrintMap(body);
//
//     Response response = await put(
//       Uri.parse(ApiEndpoints.baseUrl + path),
//       body: body != null
//           ? jsonEncode(body)
//           : null, // Only encode body if it's not null
//       headers: getHeaders(),
//     ).timeout(
//       const Duration(seconds: 30),
//       onTimeout: () {
//         LoadingDialog.removeProgressIndicatorAlertDialog();
//         ResponseDialog.showErrorDialog(
//             errorText: "Something went wrong,Please try again.",
//             onPressed: () {
//               Get.back();
//             });
//         throw TimeoutException('Can\'t connect in 30 seconds.');
//       },
//     );
//
//     logg.i(ApiEndpoints.baseUrl + path);
//     if (isJson(response.body)) {
//       prettyPrintMap(response.headers);
//       prettyPrintJson(response.body);
//       switch (response.statusCode) {
//         case 500:
//           {
//             Get.snackbar('Error', 'Server Error');
//           }
//           break;
//
//         case 401:
//           {
//             Get.snackbar(
//                 'Error', 'Your Session is Expired, You Need to Login Again.',
//                 onTap: (_) => navigatorKey.currentContext
//                     ?.goNamed(RouteNames.welcomeAuth));
//           }
//           break;
//
//         case 200:
//           var decode = json.decode(response.body);
//           switch (decode['statusCode']) {
//             case 500:
//               {
//                 Get.snackbar('Error', decode['message']);
//               }
//               break;
//           }
//       }
//     } else {
//       logg.e(response.body, error: 'Response body is not a JSON object');
//     }
//     LoadingDialog.removeProgressIndicatorAlertDialog();
//
//     return response;
//   }
//
//   // Future<Response> postFormData(
//   //     String path, Map<String, dynamic> formData) async {
//   //   LoadingDialog.showProgressIndicatorAlertDialog();
//   //   Response response;
//   //   try {
//   //     var uri = Uri.parse(ApiEndpoints.baseUrl + path);
//   //     var request = http.MultipartRequest('POST', uri);
//   //
//   //     // Add headers
//   //     request.headers.addAll(getHeaders());
//   //
//   //     // Add form fields
//   //     formData.forEach((key, value) {
//   //       if (value is File) {
//   //         // Add files if the value is a File
//   //         request.files.add(http.MultipartFile.fromBytes(
//   //           key,
//   //           value.readAsBytesSync(),
//   //           filename: value.path.split('/').last,
//   //         ));
//   //       } else {
//   //         request.fields[key] = value.toString();
//   //       }
//   //     });
//   //
//   //     // Send the request
//   //     var streamedResponse =
//   //         await request.send().timeout(const Duration(seconds: 30));
//   //     response = await http.Response.fromStream(streamedResponse);
//   //
//   //     LoadingDialog.removeProgressIndicatorAlertDialog();
//   //   } on TimeoutException {
//   //     LoadingDialog.removeProgressIndicatorAlertDialog();
//   //     throw TimeoutException('Can\'t connect in 30 seconds.');
//   //   } catch (e) {
//   //     logg.e('Error: $e');
//   //     LoadingDialog.removeProgressIndicatorAlertDialog();
//   //     rethrow;
//   //   }
//   //
//   //   logg.i(ApiEndpoints.baseUrl + path);
//   //   debugPrint('Form Data: ');
//   //
//   //   if (isJson(response.body)) {
//   //     debugPrint('Response Body: ');
//   //     prettyPrintJson(response.body);
//   //     switch (response.statusCode) {
//   //       case 500:
//   //         {
//   //           Get.snackbar('Error', 'Server Error');
//   //         }
//   //         break;
//   //
//   //       case 401:
//   //         {
//   //           Get.snackbar(
//   //               'Error', 'Your Session is Expired, You Need to Login Again.',
//   //               onTap: (_) => navigatorKey.currentContext
//   //                   ?.goNamed(RouteNames.welcomeAuth));
//   //         }
//   //         break;
//   //
//   //       case 200:
//   //         var decode = json.decode(response.body);
//   //         switch (decode['statusCode']) {
//   //           case 500:
//   //             {
//   //               Get.snackbar('Error', decode['message']);
//   //             }
//   //             break;
//   //         }
//   //     }
//   //   } else {
//   //     logg.e(response.body, error: 'Response body is not a JSON object');
//   //   }
//   //
//   //   return response;
//   // }
// }
//
// bool isJson(String str) {
//   try {
//     final json = jsonDecode(str);
//     return json is Map<String, dynamic> ||
//         json is List; // Check for valid JSON types
//   } catch (e) {
//     return false;
//   }
// }
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../utils/preference_manager.dart';

class GraphQLClientService {
  static final HttpLink _httpLink = HttpLink(
    'https://server.casashop.in/graphql', // Replace with your GraphQL endpoint
  );

  static final AuthLink _authLink = AuthLink(
    getToken: () async =>
        'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI0ZWQxMTcwNS0xMTJlLTQ4NzQtYTY0Ni0wYWFmNDk2ZDVjZTIiLCJyb2xlIjoiQ1VTVE9NRVIiLCJwcm92aWRlciI6bnVsbCwiaWF0IjoxNzM5NTk0NjE4LCJleHAiOjE3NDIxODY2MTh9.gvRxR9WquNVehSKdRbz4CFU5O7WFCgT4SgLUb-ZE-aQ',
        //'Bearer ${PreferenceManager.getString(PreferenceManager.token)}',
  );

  static final Link _link = _authLink.concat(_httpLink);

  static final GraphQLClient _client = GraphQLClient(
    link: _link,
    cache:
        GraphQLCache(store: InMemoryStore()), // Caching for better performance
  );

  /// **Perform a GraphQL Query**
  Future<QueryResult> performQuery(
      {required String document, Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(document),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly, // Always fetch fresh data
    );

    final result = await _client.query(options);

    _handleErrors(result);
    return result;
  }

  /// **Perform a GraphQL Mutation**
  Future<QueryResult> performMutation(
      {required String document, Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(document),
      variables: variables ?? {},
    );

    final result = await _client.mutate(options);

    _handleErrors(result);
    return result;
  }

  /// **Handle GraphQL Errors**
  void _handleErrors(QueryResult result) {
    if (result.hasException) {
      debugPrint('GraphQL Error: ${result.exception.toString()}');
      throw Exception(result.exception.toString());
    }
  }
}
