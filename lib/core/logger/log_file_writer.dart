import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:lua/core/logger/log_config.dart';

import 'package:lua/core/logger/log_level.dart';
import 'package:lua/core/logger/log_formatter.dart';

class LogFileWriter {
  LogFileWriter({required this.config, required this.formatter});

  final LogConfig config;
  final LogFormatter formatter;
  File? _currentLogFile;
  int _currentFileSize = 0;

  Future<void> writeToFile({
    required LogLevel level,
    required String message,
    String? className,
    String? methodName,
    StackTrace? stackTrace,
  }) async {
    if (!config.enableFileOutput) return;

    try {
      final logFile = await _getCurrentLogFile();
      final formattedMessage = formatter.format(
        level: level,
        message: message,
        className: className,
        methodName: methodName,
        stackTrace: config.showStackTrace ? stackTrace : null,
        showColors: false,
        showTimestamp: config.showTimestamp,
        showStackTrace: config.showStackTrace,
        showClassName: config.showClassName,
        showMethodName: config.showMethodName,
      );

      await logFile.writeAsString('$formattedMessage\n', mode: FileMode.append);
      _currentFileSize += formattedMessage.length;

      if (_currentFileSize >= config.maxFileSize) {
        await _rotateLogFile();
      }
    } catch (e) {
      print('Failed to write log to file: $e');
    }
  }

  Future<File> _getCurrentLogFile() async {
    if (_currentLogFile == null) {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');

      if (!await logDir.exists()) {
        await logDir.create(recursive: true);
      }

      _currentLogFile = File('${logDir.path}/app_${DateTime.now().millisecondsSinceEpoch}.log');
      _currentFileSize = await _currentLogFile!.exists() ? await _currentLogFile!.length() : 0;
    }
    return _currentLogFile!;
  }

  Future<void> _rotateLogFile() async {
    if (_currentLogFile == null) return;

    final directory = _currentLogFile!.parent;
    final files = await directory.list().where((file) => file is File && file.path.contains('app_')).cast<File>().toList();

    files.sort((a, b) => a.path.compareTo(b.path));

    while (files.length >= config.maxFiles) {
      await files.first.delete();
      files.removeAt(0);
    }

    _currentLogFile = null;
    _currentFileSize = 0;
  }

  Future<List<String>> getLogFiles() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');

      if (!await logDir.exists()) return [];

      final files = await logDir.list().where((file) => file is File && file.path.contains('app_')).cast<File>().toList();
      files.sort((a, b) => b.path.compareTo(a.path));

      return files.map((file) => file.path).toList();
    } catch (e) {
      return [];
    }
  }

  Future<String> readLogFile(String filePath) async {
    try {
      final file = File(filePath);
      return await file.readAsString();
    } catch (e) {
      return 'Error reading log file: $e';
    }
  }

  Future<void> clearAllLogs() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final logDir = Directory('${directory.path}/logs');

      if (await logDir.exists()) {
        await logDir.delete(recursive: true);
      }

      _currentLogFile = null;
      _currentFileSize = 0;
    } catch (e) {
      print('Failed to clear logs: $e');
    }
  }
}
