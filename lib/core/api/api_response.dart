// API Response Model
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:codebase/shared/resources/strings.dart';

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final int? statusCode;
  final ApiErrorResponse? error;

  ApiResponse({required this.success, this.data, this.message, this.statusCode, this.error});

  factory ApiResponse.fromResponse(Response<T> response, T? data) {
    final isSuccess = response.statusCode! >= 200 && response.statusCode! < 300;
    final message = response.data is Map<String, dynamic> ? (response.data as Map<String, dynamic>)['message'] as String? : null;
    return ApiResponse<T>(success: isSuccess, data: data, message: message, statusCode: response.statusCode);
  }

  factory ApiResponse.fromError(DioException error) {
    var errorResponse = error.response?.data is Map<String, dynamic>
        ? ApiErrorResponse.fromJson(error.response?.data as Map<String, dynamic>)
        : null;
    if (errorResponse != null) {
      errorResponse = ApiErrorResponse(
        key: errorResponse.key,
        message: errorResponse.message,
        statusCode: error.response?.statusCode.toString(),
      ).makeSenseOfErrorMessage(error);
    }
    return ApiResponse<T>(success: false, message: error.message, statusCode: error.response?.statusCode, error: errorResponse);
  }
}

class ApiErrorResponse {
  final String? key;
  final String? message;
  final String? statusCode;

  ApiErrorResponse({required this.key, required this.message, required this.statusCode});

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(key: json['key'] as String?, message: json['message'] as String?, statusCode: json['status_code'] as String?);
  }

  ApiErrorResponse makeSenseOfErrorMessage(DioException error) {
    String? message = this.message;
    final statusCode = error.response?.statusCode;
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        message = AppStrings.connectionTimeout;
        break;
      case DioExceptionType.sendTimeout:
        message = AppStrings.sendTimeout;
        break;
      case DioExceptionType.receiveTimeout:
        message = AppStrings.receiveTimeout;
        break;
      case DioExceptionType.connectionError:
        message = AppStrings.connectionError;
        break;
      case DioExceptionType.badResponse:
        if (this.message == null) {
          switch (statusCode) {
            case HttpStatus.badRequest:
              message = AppStrings.badRequest;
              break;
            case HttpStatus.unauthorized:
              message = AppStrings.unauthorized;
              break;
            case HttpStatus.forbidden:
              message = AppStrings.forbidden;
              break;
            case HttpStatus.notFound:
              message = AppStrings.notFound;
              break;
            case HttpStatus.methodNotAllowed:
              message = AppStrings.methodNotAllowed;
              break;
            case HttpStatus.requestTimeout:
              message = AppStrings.requestTimeout;
              break;
            case HttpStatus.conflict:
              message = AppStrings.conflict;
              break;
            case HttpStatus.gone:
              message = AppStrings.gone;
              break;
            case HttpStatus.lengthRequired:
              message = AppStrings.lengthRequired;
              break;
            case HttpStatus.preconditionFailed:
              message = AppStrings.preconditionFailed;
              break;
            case HttpStatus.requestEntityTooLarge:
              message = AppStrings.requestEntityTooLarge;
              break;
            case HttpStatus.requestUriTooLong:
              message = AppStrings.requestUriTooLong;
              break;
            case HttpStatus.unsupportedMediaType:
              message = AppStrings.unsupportedMediaType;
              break;
            case HttpStatus.internalServerError:
              message = AppStrings.internalServerError;
              break;
            case HttpStatus.badGateway:
              message = AppStrings.badGateway;
              break;
            case HttpStatus.serviceUnavailable:
              message = AppStrings.serviceUnavailable;
              break;
            case HttpStatus.gatewayTimeout:
              message = AppStrings.gatewayTimeout;
              break;
            default:
              message = '${AppStrings.errorOccurred} (Status : $statusCode)';
              break;
          }
        }
        break;
      case DioExceptionType.cancel:
        message = AppStrings.requestCancelled;
        break;
      case DioExceptionType.unknown:
        message = '${AppStrings.unknownError} (Status: $statusCode)';
        break;
      default:
        message = '${AppStrings.errorOccurred} (Status : $statusCode)';
        break;
    }

    return ApiErrorResponse(key: this.key, message: message, statusCode: this.statusCode);
  }
}
