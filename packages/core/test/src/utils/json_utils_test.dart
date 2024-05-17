import 'dart:convert';

import 'package:core/src/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('JsonUtils parseFromString -', () {
    test('Should return null if input text is null', () {
      // Arrange
      final String? nullText = null;
      // Act
      final result = JsonUtils.parseFromString(nullText);
      // Assert
      expect(result, null);
    });
    test('Should return null if input text is empty', () {
      // Arrange
      final emptyText = '';
      // Act
      final result = JsonUtils.parseFromString(emptyText);
      // Assert
      expect(result, null);
    });
    test('Should return $Json if input text is valid', () {
      // Arrange
      final validJson = {
        "list": [1, 2, 3],
        "boolean": true,
        "color": "gold",
        "null": null,
        "number": 123,
        "object": {"a": "b", "c": "d"},
        "string": "Hello World",
      };
      final stringJson = json.encode(validJson);
      // Act
      final result = JsonUtils.parseFromString(stringJson);
      // Assert
      expect(result, isA<Json>());
      expect(result, validJson);
    });
  });

  group('JsonListUtils parseFromString -', () {
    test('Should return null if input text is null', () {
      // Arrange
      final String? nullText = null;
      // Act
      final result = JsonListUtils.parseFromString(nullText);
      // Assert
      expect(result, null);
    });
    test('Should return null if input text is empty', () {
      // Arrange
      final emptyText = '';
      // Act
      final result = JsonListUtils.parseFromString(emptyText);
      // Assert
      expect(result, null);
    });
    test('Should return $Json if input text is valid', () {
      // Arrange
      final validJsonList = [
        {
          "list": [1, 2, 3],
          "boolean": true,
          "number": 123,
        },
        {
          "color": "gold",
          "null": null,
        },
        {
          "object": {"a": "b", "c": "d"},
          "string": "Hello World",
        }
      ];
      final stringJson = json.encode(validJsonList);
      // Act
      final result = JsonListUtils.parseFromString(stringJson);
      // Assert
      expect(result, isA<JsonList>());
      expect(result, validJsonList);
      expect(result!.length, 3);
    });
  });
}
