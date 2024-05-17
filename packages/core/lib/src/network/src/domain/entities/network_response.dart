import 'dart:convert';

import '../../../../utils/utils.dart';
import 'entities.dart';

class NetworkResponse {
  final String url;
  final int statusCode;
  final NetworkRequestMethod method;
  final Map<String, dynamic> headers;
  final dynamic _data;

  Json get jsonData => JsonUtils.parseFromString(jsonEncode(_data)) ?? {};

  JsonList get jsonListData =>
      JsonListUtils.parseFromString(jsonEncode(_data)) ?? <Json>[];

  dynamic getData() => _data;

  NetworkResponse(
    this._data, {
    required this.url,
    required this.statusCode,
    required this.method,
    required this.headers,
  });

  factory NetworkResponse.fromJson(Map<String, dynamic> json) {
    return NetworkResponse(
      json['data'],
      url: json['url'],
      statusCode: json['statusCode'],
      method: (json['method']).toString().toRequestMethod() ??
          NetworkRequestMethod.get,
      headers: json['headers'],
    );
  }

  NetworkResponse copyWith({
    String? url,
    int? statusCode,
    NetworkRequestMethod? method,
    Map<String, dynamic>? headers,
    dynamic data,
  }) =>
      NetworkResponse(
        data ?? _data,
        url: url ?? this.url,
        statusCode: statusCode ?? this.statusCode,
        method: method ?? this.method,
        headers: headers ?? this.headers,
      );
}

extension RequestMethodFromString on String {
  NetworkRequestMethod? toRequestMethod() {
    switch (this) {
      case 'GET':
        return NetworkRequestMethod.get;
      case 'POST':
        return NetworkRequestMethod.post;
      case 'PUT':
        return NetworkRequestMethod.put;
      case 'PATCH':
        return NetworkRequestMethod.patch;
      case 'DELETE':
        return NetworkRequestMethod.delete;
      default:
        return null;
    }
  }
}
