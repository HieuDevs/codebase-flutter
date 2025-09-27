// Base Repository Class

import 'dart:io';
import 'dart:math';

import 'package:codebase/core/api/api_response.dart';
import 'package:dio/dio.dart';

class RetryConfig {
  final int maxRetries;
  final Duration initialDelay;
  final double backoffMultiplier;
  final List<int> retryStatusCodes;

  const RetryConfig({
    this.maxRetries = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.backoffMultiplier = 2.0,
    this.retryStatusCodes = const [
      HttpStatus.requestTimeout,
      HttpStatus.tooManyRequests,
      HttpStatus.internalServerError,
      HttpStatus.badGateway,
      HttpStatus.serviceUnavailable,
      HttpStatus.gatewayTimeout,
    ],
  });
}

abstract class BaseRepository {
  Future<ApiResponse<T>> handleRequest<T>(
    Future<Response<T>> Function() request, {
    T Function(dynamic data)? parser,
    RetryConfig retryConfig = const RetryConfig(),
  }) async {
    DioException? lastError;

    for (int attempt = 0; attempt <= retryConfig.maxRetries; attempt++) {
      try {
        // Add delay for retry attempts
        if (attempt > 0) {
          final delay = _calculateDelay(attempt, retryConfig);
          await Future<void>.delayed(delay);
        }

        final response = await request();
        final data = parser != null ? parser(response.data) : response.data;
        return ApiResponse.fromResponse(response, data);
      } on DioException catch (e) {
        lastError = e;

        // Don't retry if not retryable or max attempts reached
        if (!_shouldRetry(e, retryConfig) || attempt >= retryConfig.maxRetries) {
          break;
        }
      }
    }

    return ApiResponse.fromError(lastError!);
  }

  bool _shouldRetry(DioException error, RetryConfig config) {
    // Retry on timeout/connection errors
    if ([DioExceptionType.connectionTimeout, DioExceptionType.receiveTimeout, DioExceptionType.connectionError].contains(error.type)) {
      return true;
    }

    // Retry on specific status codes
    final statusCode = error.response?.statusCode;
    return statusCode != null && config.retryStatusCodes.contains(statusCode);
  }

  Duration _calculateDelay(int attempt, RetryConfig config) {
    final delay = config.initialDelay.inMilliseconds * pow(config.backoffMultiplier, attempt - 1);
    return Duration(milliseconds: delay.round());
  }
}
