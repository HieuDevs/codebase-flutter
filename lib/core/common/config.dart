import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvType { production, staging }

class Config {
  static Future<void> loadEnv({required EnvType envType}) async {
    final fileName = '${envType.name}.env';
    await dotenv.load(fileName: fileName);
    debugPrint('Env Mode: ${dotenv.env['MODE']}');
  }

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
}
