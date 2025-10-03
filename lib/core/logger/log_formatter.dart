import 'package:lua/core/logger/log_level.dart';

class LogFormatter {
  const LogFormatter();

  String format({
    required LogLevel level,
    required String message,
    String? className,
    String? methodName,
    StackTrace? stackTrace,
    DateTime? timestamp,
    bool showColors = true,
    bool showTimestamp = true,
    bool showStackTrace = true,
    bool showClassName = true,
    bool showMethodName = true,
  }) {
    final buffer = StringBuffer();

    if (showTimestamp) {
      final time = timestamp ?? DateTime.now();
      buffer.write('[${_formatTime(time)}] ');
    }

    buffer.write('${level.emoji} ${level.name}');

    if (showClassName && className != null) {
      buffer.write(' [$className');
      if (showMethodName && methodName != null) {
        buffer.write('.$methodName');
      }
      buffer.write(']');
    }

    buffer.write(': $message');

    if (showStackTrace && stackTrace != null) {
      buffer.write('\n${stackTrace.toString()}');
    }

    return buffer.toString();
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}.'
        '${time.millisecond.toString().padLeft(3, '0')}';
  }

  String getColorCode(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '\x1B[36m'; // Cyan
      case LogLevel.info:
        return '\x1B[32m'; // Green
      case LogLevel.warning:
        return '\x1B[33m'; // Yellow
      case LogLevel.error:
        return '\x1B[31m'; // Red
      case LogLevel.fatal:
        return '\x1B[35m'; // Magenta
    }
  }

  String get resetColor => '\x1B[0m';
}
