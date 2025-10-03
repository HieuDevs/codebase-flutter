import 'package:lua/core/extensions/context.dart';
import 'package:lua/core/logger/logger.dart';
import 'package:lua/core/logger/app_logger.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestLogger extends ConsumerStatefulWidget {
  const TestLogger({super.key});

  @override
  ConsumerState<TestLogger> createState() => _TestLoggerState();
}

class _TestLoggerState extends ConsumerState<TestLogger> {
  List<String> logFiles = [];
  String selectedLogContent = '';
  bool isLoadingLogs = false;

  @override
  void initState() {
    super.initState();
    _loadLogFiles();
  }

  Future<void> _loadLogFiles() async {
    setState(() => isLoadingLogs = true);
    try {
      final files = await AppLogger.instance.getLogFiles();
      setState(() => logFiles = files);
    } catch (e) {
      appLogger.error('Failed to load log files: $e', methodName: '_loadLogFiles');
    } finally {
      setState(() => isLoadingLogs = false);
    }
  }

  Future<void> _viewLogFile(String filePath) async {
    try {
      final content = await AppLogger.instance.readLogFile(filePath);
      setState(() => selectedLogContent = content);
    } catch (e) {
      appLogger.error('Failed to read log file: $e', methodName: '_viewLogFile');
    }
  }

  Future<void> _clearAllLogs() async {
    try {
      await AppLogger.instance.clearAllLogs();
      await _loadLogFiles();
      setState(() => selectedLogContent = '');
      appLogger.info('All logs cleared successfully', methodName: '_clearAllLogs');
    } catch (e) {
      appLogger.error('Failed to clear logs: $e', methodName: '_clearAllLogs');
    }
  }

  void _testDebugLog() {
    appLogger.debug('This is a debug message 🐛', methodName: '_testDebugLog');
  }

  void _testInfoLog() {
    appLogger.info('This is an info message ℹ️', methodName: '_testInfoLog');
  }

  void _testWarningLog() {
    appLogger.warning('This is a warning message ⚠️', methodName: '_testWarningLog');
  }

  void _testErrorLog() {
    appLogger.error('This is an error message ❌', methodName: '_testErrorLog');
  }

  void _testFatalLog() {
    appLogger.fatal('This is a fatal message 💀', methodName: '_testFatalLog');
  }

  void _testLogWithStackTrace() {
    try {
      throw Exception('Test exception for stack trace');
    } catch (e, stackTrace) {
      appLogger.error('Exception caught: $e', methodName: '_testLogWithStackTrace', stackTrace: stackTrace);
    }
  }

  void _testBulkLogs() {
    appLogger.debug('Starting bulk log test', methodName: '_testBulkLogs');
    for (int i = 1; i <= 5; i++) {
      appLogger.info('Bulk log message $i/5', methodName: '_testBulkLogs');
    }
    appLogger.debug('Finished bulk log test', methodName: '_testBulkLogs');
  }

  void _testLogToFiles() {
    appLogger.info('File logging test completed - Check log files', allowWriteToFile: true, methodName: '_testLogToFiles');

    _loadLogFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logger Test'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Log Level Tests', style: context.getTextTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _testDebugLog,
                          icon: const Text('🐛'),
                          label: const Text('Debug'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade100, foregroundColor: Colors.cyan.shade800),
                        ),
                        ElevatedButton.icon(
                          onPressed: _testInfoLog,
                          icon: const Text('ℹ️'),
                          label: const Text('Info'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade100, foregroundColor: Colors.green.shade800),
                        ),
                        ElevatedButton.icon(
                          onPressed: _testWarningLog,
                          icon: const Text('⚠️'),
                          label: const Text('Warning'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade100, foregroundColor: Colors.orange.shade800),
                        ),
                        ElevatedButton.icon(
                          onPressed: _testErrorLog,
                          icon: const Text('❌'),
                          label: const Text('Error'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100, foregroundColor: Colors.red.shade800),
                        ),
                        ElevatedButton.icon(
                          onPressed: _testFatalLog,
                          icon: const Text('💀'),
                          label: const Text('Fatal'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade100, foregroundColor: Colors.purple.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Advanced Tests', style: context.getTextTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton.icon(
                          onPressed: _testLogWithStackTrace,
                          icon: const Icon(Icons.bug_report),
                          label: const Text('Test Stack Trace'),
                        ),
                        ElevatedButton.icon(onPressed: _testBulkLogs, icon: const Icon(Icons.refresh), label: const Text('Bulk Logs')),
                        ElevatedButton.icon(
                          onPressed: _testLogToFiles,
                          icon: const Icon(Icons.file_copy),
                          label: const Text('Test Log to Files'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade100, foregroundColor: Colors.blue.shade800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Log Files', style: context.getTextTheme.headlineSmall),
                        Row(
                          children: [
                            IconButton(
                              onPressed: _loadLogFiles,
                              icon: isLoadingLogs
                                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                                  : const Icon(Icons.refresh),
                            ),
                            IconButton(
                              onPressed: logFiles.isNotEmpty ? _clearAllLogs : null,
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (logFiles.isEmpty)
                      const Text('No log files found')
                    else
                      ...logFiles.map((file) {
                        final fileName = file.split('/').last;
                        return ListTile(
                          title: Text(fileName),
                          subtitle: Text(file),
                          trailing: const Icon(Icons.visibility),
                          onTap: () => _viewLogFile(file),
                        );
                      }),
                  ],
                ),
              ),
            ),
            if (selectedLogContent.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Log Content', style: context.getTextTheme.headlineSmall),
                          IconButton(onPressed: () => setState(() => selectedLogContent = ''), icon: const Icon(Icons.close)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        height: 300,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: SingleChildScrollView(child: Text(selectedLogContent, style: context.getTextTheme.bodySmall)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
