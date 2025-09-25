enum LogLevel {
  debug(0, 'DEBUG', '🐛'),
  info(1, 'INFO', 'ℹ️'),
  warning(2, 'WARNING', '⚠️'),
  error(3, 'ERROR', '❌'),
  fatal(4, 'FATAL', '💀');

  const LogLevel(this.level, this.name, this.emoji);

  final int level;
  final String name;
  final String emoji;

  bool shouldLog(LogLevel other) => other.level >= level;
}
