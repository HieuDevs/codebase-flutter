import 'package:codebase/core/logger/log_config.dart';
import 'package:codebase/core/logger/log_file_writer.dart';
import 'package:codebase/core/logger/log_formatter.dart';
import 'package:codebase/core/logger/log_level.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._internal();

  static AppLogger? _instance;
  static AppLogger get instance => _instance ??= AppLogger._internal();

  late final LogConfig _config;
  late final LogFormatter _formatter;
  late final LogFileWriter _fileWriter;

  void initialize({LogConfig? config}) {
    _config = config ?? const LogConfig();
    _formatter = const LogFormatter();
    _fileWriter = LogFileWriter(config: _config, formatter: _formatter);
  }

  void debug(String message, {bool allowWriteToFile = false, String? className, String? methodName, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, allowWriteToFile: allowWriteToFile, className: className, methodName: methodName, stackTrace: stackTrace);
  }

  void info(String message, {bool allowWriteToFile = false, String? className, String? methodName, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, allowWriteToFile: allowWriteToFile, className: className, methodName: methodName, stackTrace: stackTrace);
  }

  void warning(String message, {bool allowWriteToFile = false, String? className, String? methodName, StackTrace? stackTrace}) {
    _log(
      LogLevel.warning,
      message,
      allowWriteToFile: allowWriteToFile,
      className: className,
      methodName: methodName,
      stackTrace: stackTrace,
    );
  }

  void error(String message, {bool allowWriteToFile = false, String? className, String? methodName, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, allowWriteToFile: allowWriteToFile, className: className, methodName: methodName, stackTrace: stackTrace);
  }

  void fatal(String message, {bool allowWriteToFile = false, String? className, String? methodName, StackTrace? stackTrace}) {
    _log(LogLevel.fatal, message, allowWriteToFile: allowWriteToFile, className: className, methodName: methodName, stackTrace: stackTrace);
  }

  void _log(
    LogLevel level,
    String message, {
    required bool allowWriteToFile,
    String? className,
    String? methodName,
    StackTrace? stackTrace,
  }) {
    if (!_config.minLevel.shouldLog(level)) return;

    final timestamp = DateTime.now();
    final formattedMessage = _formatter.format(
      level: level,
      message: message,
      className: className,
      methodName: methodName,
      stackTrace: stackTrace,
      timestamp: timestamp,
      showColors: _config.enableColors,
      showTimestamp: _config.showTimestamp,
      showStackTrace: _config.showStackTrace,
      showClassName: _config.showClassName,
      showMethodName: _config.showMethodName,
    );

    if (_config.enableConsoleOutput && kDebugMode) {
      if (_config.enableColors) {
        debugPrint('${_formatter.getColorCode(level)}$formattedMessage${_formatter.resetColor}');
      } else {
        debugPrint(formattedMessage);
      }
    }

    if (_config.enableFileOutput && allowWriteToFile) {
      _fileWriter.writeToFile(level: level, message: message, className: className, methodName: methodName, stackTrace: stackTrace);
    }
  }

  Future<List<String>> getLogFiles() => _fileWriter.getLogFiles();
  Future<String> readLogFile(String filePath) => _fileWriter.readLogFile(filePath);
  Future<void> clearAllLogs() => _fileWriter.clearAllLogs();

  void updateConfig(LogConfig newConfig) {
    _config = newConfig;
    _fileWriter = LogFileWriter(config: _config, formatter: _formatter);
  }
}
