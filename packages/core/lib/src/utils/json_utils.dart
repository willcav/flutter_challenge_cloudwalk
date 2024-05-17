import 'dart:convert';

import 'typedef.dart';

class JsonUtils {
  /// Retrieves a [Json] object from a [String] representation of a JSON object.
  static Json? parseFromString(String? jsonText) {
    if (jsonText == null || jsonText.isEmpty) return null;
    try {
      return Map<String, dynamic>.from(json.decode(jsonText));
    } catch (_) {
      return null;
    }
  }
}

class JsonListUtils {
  /// Retrieves a [JsonList] object from a [String] representation of a JSON list.
  static JsonList? parseFromString(String? jsonText) {
    if (jsonText == null || jsonText.isEmpty) return null;
    try {
      return JsonList.from(json.decode(jsonText));
    } catch (_) {
      return null;
    }
  }
}
