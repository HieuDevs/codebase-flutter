import 'package:codebase/core/logger/log_level.dart';

class LogConfig {
  const LogConfig({
    this.minLevel = LogLevel.debug,
    this.enableConsoleOutput = true,
    this.enableFileOutput = false,
    this.enableColors = true,
    this.maxFileSize = 5 * 1024 * 1024, // 5MB
    this.maxFiles = 5,
    this.showTimestamp = true,
    this.showStackTrace = true,
    this.showClassName = true,
    this.showMethodName = true,
  });

  final LogLevel minLevel;
  final bool enableConsoleOutput;
  final bool enableFileOutput;
  final bool enableColors;
  final int maxFileSize;
  final int maxFiles;
  final bool showTimestamp;
  final bool showStackTrace;
  final bool showClassName;
  final bool showMethodName;
}
