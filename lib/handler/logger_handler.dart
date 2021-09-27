import 'package:mtelektrik/shared/utils/logger/logger.dart';

final _logger = Logger();
void printError(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  _logger.e(message, error, stackTrace);
}

void printInfo(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  _logger.i(message, error, stackTrace);
}

void printDebug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  _logger.d(message, error, stackTrace);
}

void printWarning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
  _logger.w(message, error, stackTrace);
}
