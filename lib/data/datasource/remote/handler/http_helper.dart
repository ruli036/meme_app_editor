import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:meme_editor_app/core/utils/exception/message_exception.dart';
import 'package:meme_editor_app/core/utils/logger/logger.dart';

class HttpHelper {
  static String get _platformName {
    if (kIsWeb) return 'web-revamp';
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Android-revamp';
      case TargetPlatform.iOS:
        return 'iOS-revamp';
      default:
        return 'unknown';
    }
  }

  static get defaultHeaders => {'Content-Type': 'application/json'};

  static Map<String, String> headersPlatform() {
    final headers = Map<String, String>.from(defaultHeaders);
    headers['X-Platform'] = _platformName;
    return headers;
  }

  final Duration timeoutDuration = const Duration(seconds: 20);

  void _logRequest(
    String method,
    Uri uri,
    Map<String, String> headers,
    dynamic body,
  ) {
    if (kDebugMode) {
      Logger.logDebug('Request Method: $method');
      Logger.logDebug('Request URI: $uri');
      Logger.logDebug('Request Headers: $headers');
      if (body != null) {
        Logger.logDebug('Request Body: $body');
      }
    }
  }

  void _logResponse(http.Response response) {
    if (kDebugMode) {
      Logger.logDebug('Response Status: ${response.statusCode}');
      Logger.logDebug('Response Body: ${response.body}');
    }
  }

  Map<String, String> _getDefaultHeaders(Map<String, String>? headers) {
    Map<String, String> finalHeader = {...defaultHeaders};

    if (headers != null && headers.isNotEmpty) {
      finalHeader.addAll(headers);
    }

    return finalHeader;
  }

  ///This Function for CRUD
  Future<http.Response> getAPI({
    required http.Client client,
    required String uri,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    bool hasInet = await hasInternet();
    if (!hasInet) {
      throw NetworkError();
    }
    Uri finalUri = Uri.parse(uri);
    if (queryParams != null && queryParams.isNotEmpty) {
      finalUri = finalUri.replace(
        queryParameters: queryParams.map(
          (key, value) => MapEntry(key, value.toString()),
        ),
      );
    }
    final resolvedHeaders = _getDefaultHeaders(headers);
    _logRequest('GET', finalUri, resolvedHeaders, null);
    final response = await client
        .get(finalUri, headers: resolvedHeaders)
        .timeout(timeout ?? timeoutDuration);
    _logResponse(response);
    return response;
  }

  Future<http.Response> postAPI({
    required http.Client client,
    required String uri,
    required postParams,
    Map<String, String>? headers,
  }) async {
    bool hasInet = await hasInternet();
    if (!hasInet) {
      throw NetworkError();
    }
    final resolvedHeaders = _getDefaultHeaders(headers);
    _logRequest('POST', Uri.parse(uri), resolvedHeaders, postParams);
    final response = await client
        .post(Uri.parse(uri), body: postParams, headers: resolvedHeaders)
        .timeout(timeoutDuration);
    _logResponse(response);
    return response;
  }

  Future<http.Response> putAPI({
    required http.Client client,
    required String uri,
    required postParams,
    Map<String, String>? headers,
  }) async {
    bool hasInet = await hasInternet();
    if (!hasInet) {
      throw NetworkError();
    }
    final resolvedHeaders = _getDefaultHeaders(headers);
    _logRequest(
      'PUT',
      Uri.parse(uri),
      resolvedHeaders,
      postParams,
    ); // Log request
    final response = await client
        .put(Uri.parse(uri), body: postParams, headers: resolvedHeaders)
        .timeout(timeoutDuration);
    _logResponse(response);
    return response;
  }

  Future<http.Response> deleteAPI({
    required http.Client client,
    required String uri,
    required postParams,
    Map<String, String>? headers,
  }) async {
    bool hasInet = await hasInternet();
    if (!hasInet) {
      throw NetworkError();
    }
    final resolvedHeaders = _getDefaultHeaders(headers);
    _logRequest(
      'DELETE',
      Uri.parse(uri),
      resolvedHeaders,
      postParams,
    ); // Log request
    final response = await client
        .delete(Uri.parse(uri), body: postParams, headers: resolvedHeaders)
        .timeout(timeoutDuration);
    _logResponse(response);
    return response;
  }

  static Future<bool> hasInternet() async {
    // used in mobile app only, the inetAddress lookup is not supported on web
    if (!kIsWeb) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException {
        return false;
      }
      return false;
    }
    return true;
  }
}
