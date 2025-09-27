import 'dart:io';

import 'package:codebase/core/routes/app_navigator.dart';
import 'package:codebase/core/routes/routes.dart';
import 'package:codebase/shared/resources/strings.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/src/pretty_dio_logger.dart';
import 'package:http_certificate_pinning/http_certificate_pinning.dart';

class DioService {
  late Dio _dio;
  Dio get dio => _dio;
  String? _authToken;

  void initialize({
    required String baseUrl,
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
    int sendTimeout = 30000,
    bool enableLogging = true,
    bool enableCertificatePinning = true,
    List<String>? allowedCertificates,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: connectTimeout),
        receiveTimeout: Duration(milliseconds: receiveTimeout),
        sendTimeout: Duration(milliseconds: sendTimeout),
        receiveDataWhenStatusError: true,
        validateStatus: (status) => status! < 500,
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );

    // Add interceptors
    _setupInterceptors(
      enableLogging: enableLogging,
      enableCertificatePinning: enableCertificatePinning,
      allowedCertificates: allowedCertificates,
    );
  }

  void _setupInterceptors({
    required bool enableLogging,
    required bool enableCertificatePinning,
    required List<String>? allowedCertificates,
  }) {
    // Authentication interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          if (_authToken != null) {
            options.headers['Authorization'] = 'Bearer $_authToken';
          }
          // Check connectivity
          final connectivity = await Connectivity().checkConnectivity();
          if (connectivity == ConnectivityResult.none) {
            throw DioException(requestOptions: options, error: AppStrings.noInternetConnection, type: DioExceptionType.connectionError);
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) async {
          // Handle unauthorized error
          if (error.response?.statusCode == HttpStatus.unauthorized) {
            try {
              await _refreshToken();
              // Retry the request
              final clonedRequest = await _dio.request<dynamic>(
                error.requestOptions.path,
                options: Options(method: error.requestOptions.method, headers: error.requestOptions.headers),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              handler.resolve(clonedRequest);
              return;
            } catch (e) {
              // Refresh token failed, return the original error
              _handleAuthenticationFailure();
            }
          }
          return handler.next(error);
        },
      ),
    );

    // Pretty logger interceptor
    if (enableLogging && kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }

    // Certificate pinning interceptor
    if (enableCertificatePinning && allowedCertificates != null) {
      _dio.interceptors.add(CertificatePinningInterceptor(allowedSHAFingerprints: allowedCertificates));
    }
  }

  // Authentication methods
  void setAuthToken(String token) {
    _authToken = token;
  }

  void clearAuthToken() {
    _authToken = null;
  }

  Future<void> _refreshToken() async {
    // Implement token refresh logic
    throw UnimplementedError();
  }

  void _handleAuthenticationFailure() {
    // Implement authentication failure logic
    clearAuthToken();
    // Navigate to login page
    AppNavigator.pushAndRemoveUntil(RouteNames.auth);
  }
}
