import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meme_editor_app/core/extensions/extension.dart';
import 'package:meme_editor_app/core/network/base_api_response.dart';
import 'package:meme_editor_app/core/network/error_response.dart';
import 'package:meme_editor_app/core/utils/exception/message_exception.dart';

class APIHandler {
  Future<BaseApiResponse<T>> performApiRequest<T>({
    required Future<http.Response> Function() request,
    required T Function(dynamic json) fromJson,
    bool bypassTokenValidation = false,
  }) async {
    try {
      await _checkNetwork();
      var result = await request();
      return handleResponse(result, fromJson, request);
    } catch (err) {
      final handleError = MessageException.handleError(err);
      return Future.error(handleError);
    }
  }

  Future<BaseApiResponse<T>> handleResponse<T>(
    http.Response result,
    T Function(dynamic json) fromJson,
    Future<http.Response> Function() retryRequest,
  ) async {
    if (result.headers['content-type'] == 'application/pdf') {
      return BaseApiResponse(
        data: '' as T,
        bodyString: result.body,
        statusCode: result.statusCode,
        bodyBytes: result.bodyBytes,
      );
    } else if (result.isValidStatusCode() && !result.isErrorStatusCode()) {
      var jsonData = jsonDecode(result.body);
      if (jsonData is List) {
        final parsedData = jsonData.map((item) => fromJson(item)).toList();
        return BaseApiResponse(
          data: parsedData as T,
          bodyString: result.body,
          statusCode: result.statusCode,
          bodyBytes: result.bodyBytes,
        );
      } else {
        final parsedData = fromJson(jsonData);
        return BaseApiResponse(
          data: parsedData,
          bodyString: result.body,
          statusCode: result.statusCode,
          bodyBytes: result.bodyBytes,
        );
      }
    }

    try {
      final errorResponse = ErrorResponse.fromJson(jsonDecode(result.body));
      return BaseApiResponse(
        data: fromJson(jsonDecode(result.body)),
        bodyString: errorResponse.message ?? '',
        statusCode: result.statusCode,
        bodyBytes: result.bodyBytes,
      );
    } catch (e) {
      throw jsonEncode(result.body);
    }
  }

  Future<void> _checkNetwork() async {
    return Future.value();
  }
}
