import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:velocy_user_app/service/local_storage/secure_storage.dart';

class DioClient {
  final Dio _dio = Dio();
  final String baseUrl;
  final String? userId;
  DioClient({required this.baseUrl, this.userId}) {
    _dio
      ..httpClientAdapter
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        InterceptorsWrapper(
          onResponse: (res, handler) async {
            return handler.next(res);
          },
          onRequest: (option, handler) async {
            final accessToken = await SecureStorage().getAccessToken();
            if (accessToken != null && accessToken.isNotEmpty) {
              // _tokenHandler(accessToken: accessToken);
            }
            return handler.next(option);
          },
        ),
      );

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
        ),
      );
    }
  }

  Future<Response> get(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.getUri(
        uri,
        options: options,
        // cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     default:
      //       rethrow;
      //   }
      // } else {
      //   rethrow;
      // }
      rethrow;
    }
  }

  Future<dynamic> post(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    if (data is Map) {
      payload:
      Map<String, dynamic>.from(data);
    }

    try {
      final response = await _dio.postUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     default:
      //       rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  Future<dynamic> put(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.putUri(
        uri,
        data: data,
        // queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     default:
      //       rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  Future<dynamic> patch(
    Uri uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patchUri(
        uri,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     // default:
      //     //   rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  Future<Response> delete(
    Uri uri, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.deleteUri(
        uri,
        // queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        data: data,
      );
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (error) {
      // if (error is DioError) {
      //   switch (error.response?.statusCode) {
      //     // case 401:
      //     //   return await requestRetrier(
      //     //     baseUrl: baseUrl,
      //     //     response: error.response!,
      //     //     userId: userId,
      //     //   );
      //     // default:
      //     //   rethrow;
      //   }
      // } else {
      // }
      rethrow;
    }
  }

  // Future<bool> _tokenHandler({required String accessToken}) async {
  //   try {
  //     if (accessToken == "") {
  //       return false;
  //     }
  //     final payloadAccessToken = JwtUtils.parseJwtPayLoad(accessToken);

  //     DateTime currentDateTime = DateTime.now();

  //     debugPrint("current date ${currentDateTime.toIso8601String()}");

  //     DateTime accessTokenExpDateTime =
  //         DateTime.fromMillisecondsSinceEpoch(payloadAccessToken['exp'] * 1000);

  //     debugPrint("access token ${accessTokenExpDateTime.toIso8601String()}");

  //     if (currentDateTime.isAfter(accessTokenExpDateTime)) {
  //       await RepositoryProvider.of<AuthRepository>(NavigationService.context)
  //           .localLogout();

  //       NavigationService.pushNamedAndRemoveUntil(
  //           routeName: Routes.dashboardPage);

  //       CustomToast.error(message: "Session Timeout, Login Again");
  //       return false;
  //     } else {
  //       return true;
  //     }
  //   } catch (e) {
  //     await RepositoryProvider.of<AuthRepository>(NavigationService.context)
  //         .logout();

  //     // NavigationService.pushNamedAndRemoveUntil(
  //     //     routeName: Routes.dashboardPage);

  //     CustomToast.error(message: "Sesson Timeout, Login Again");

  //     debugPrint(e.toString());
  //     rethrow;
  //   }
  // }
}
