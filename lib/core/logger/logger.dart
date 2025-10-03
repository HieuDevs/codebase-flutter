import 'package:lua/core/logger/app_logger.dart';

class Logger {
  Logger._(this._className);

  final String _className;

  static Logger getInstance(String className) => Logger._(className);

  void debug(String message, {bool allowWriteToFile = false, String? methodName, StackTrace? stackTrace}) {
    AppLogger.instance.debug(
      message,
      allowWriteToFile: allowWriteToFile,
      className: _className,
      methodName: methodName,
      stackTrace: stackTrace,
    );
  }

  void info(String message, {bool allowWriteToFile = false, String? methodName, StackTrace? stackTrace}) {
    AppLogger.instance.info(
      message,
      allowWriteToFile: allowWriteToFile,
      className: _className,
      methodName: methodName,
      stackTrace: stackTrace,
    );
  }

  void warning(String message, {bool allowWriteToFile = false, String? methodName, StackTrace? stackTrace}) {
    AppLogger.instance.warning(
      message,
      allowWriteToFile: allowWriteToFile,
      className: _className,
      methodName: methodName,
      stackTrace: stackTrace,
    );
  }

  void error(String message, {bool allowWriteToFile = false, String? methodName, StackTrace? stackTrace}) {
    AppLogger.instance.error(
      message,
      allowWriteToFile: allowWriteToFile,
      className: _className,
      methodName: methodName,
      stackTrace: stackTrace,
    );
  }

  void fatal(String message, {bool allowWriteToFile = false, String? methodName, StackTrace? stackTrace}) {
    AppLogger.instance.fatal(
      message,
      allowWriteToFile: allowWriteToFile,
      className: _className,
      methodName: methodName,
      stackTrace: stackTrace,
    );
  }
}

extension LoggerExtension on Object {
  Logger get appLogger => Logger.getInstance(runtimeType.toString());
}

Logger getLogger(String className) => Logger.getInstance(className);
