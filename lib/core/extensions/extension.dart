import 'package:http/http.dart';

extension ResponseExtension on Response {
  bool isValidStatusCode() {
    return statusCode >= 200 && statusCode < 300;
  }

  bool isErrorStatusCode() {
    return statusCode >= 400;
  }
}