import 'package:flutter/foundation.dart';
import 'dart:developer';

// logger_service.dart: Uygulama genelinde loglama işlemleri için kullanılır.
// Hata ve bilgi mesajlarını konsola veya dosyaya yazmak için kullanılır.

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  factory LoggerService() => _instance;
  LoggerService._internal();

  void debug(String message) {
    if (kDebugMode) {
      log('[DEBUG] $message');
    }
  }

  void info(String message) {
    log('[INFO] $message');
  }

  void error(String message, [Object? error, StackTrace? stackTrace]) {
    log('[ERROR] $message');
    if (error != null) log('Error: $error');
    if (stackTrace != null) log('StackTrace: $stackTrace');
  }
}
