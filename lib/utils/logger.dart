import 'dart:developer' as developer;

/// Logger utility for application-wide logging
class Logger {
  static void debug(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? 'App',
      level: 800, // Debug level
    );
  }

  static void info(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? 'App',
      level: 700, // Info level
    );
  }

  static void warning(String message, {String? tag}) {
    developer.log(
      message,
      name: tag ?? 'App',
      level: 900, // Warning level
    );
  }

  static void error(String message, {Object? error, StackTrace? stackTrace, String? tag}) {
    developer.log(
      message,
      name: tag ?? 'App',
      error: error,
      stackTrace: stackTrace,
      level: 1000, // Error level
    );
  }
}

