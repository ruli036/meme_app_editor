import 'dart:typed_data';

class BaseApiResponse<T> {
  final T data;
  final String bodyString;
  final int statusCode;
  final Uint8List bodyBytes;

  BaseApiResponse({required this.data, required this.bodyString, required this.statusCode, required this.bodyBytes});
}