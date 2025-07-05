import 'dart:developer' as logger;

import 'package:flutter/foundation.dart';

class Logger {
  static bool debugMode = kDebugMode;
  static void log(String message) {
    logger.log(message);
  }
  static void logDebug(String message) {
    if (debugMode) {
      logger.log(message);
    }
  }

  static void logDebugTimed(String message) {
    logDebug("[${DateTime.now().toIso8601String()}] $message");
  }
  static void printDebug(String message) {
    if (debugMode) {
      print(message);
    }
  }
}
