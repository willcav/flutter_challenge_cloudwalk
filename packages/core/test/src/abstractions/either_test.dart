import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Getter isLeft -', () {
    test('Should return false when object is $Right', () {
      // Arrange
      final obj = Right('');

      // Act
      final result = obj.isLeft;

      // Assert
      expect(result, false);
    });

    test('Should return true when object is $Left', () {
      // Arrange
      final obj = Left(GenericFailure());

      // Act
      final result = obj.isLeft;

      // Assert
      expect(result, true);
    });
  });

  group('Getter isRight -', () {
    test('Should return false when object is $Left', () {
      // Arrange
      final obj = Left(GenericFailure());

      // Act
      final result = obj.isRight;

      // Assert
      expect(result, false);
    });

    test('Should return true when object is $Right', () {
      // Arrange
      final obj = Right('');

      // Act
      final result = obj.isRight;

      // Assert
      expect(result, true);
    });
  });

  group('Getter left -', () {
    test('Should throw exception when object is $Right', () {
      final obj = Right('');

      expect(obj.isLeft, false);
      expect(obj.isRight, true);
      expect(() => obj.left, throwsException);
    });

    test('Should return $Left when object is $Left', () {
      final obj = Left(GenericFailure());

      expect(obj.isLeft, true);
      expect(obj.isRight, false);
      expect(obj.left, isA<GenericFailure>());
    });
  });

  group('Getter right -', () {
    test('Should throw exception when object is $Left', () {
      final obj = Left(GenericFailure());

      expect(obj.isLeft, true);
      expect(obj.isRight, false);
      expect(() => obj.right, throwsException);
    });

    test('Should return $Right when object is $Right', () {
      final obj = Right('');

      expect(obj.isLeft, false);
      expect(obj.isRight, true);
      expect(obj.right, isA<String>());
    });
  });

  group('Getter rightOrNull -', () {
    test('Should return null when object is $Left', () {
      final obj = Left(GenericFailure());

      expect(obj.isLeft, true);
      expect(obj.isRight, false);
      expect(obj.rightOrNull, null);
    });

    test('Should return $Right when object is $Right', () {
      final obj = Right('');

      expect(obj.isLeft, false);
      expect(obj.isRight, true);
      expect(obj.rightOrNull, isA<String>());
    });
  });

  group('Method fold -', () {
    test('Should get $Left value when object is $Left', () {
      // Arrange
      final obj = Left(GenericFailure());

      // Act
      final result = obj.fold((l) => l, (r) => r);

      // Assert
      expect(obj.isLeft, true);
      expect(obj.isRight, false);
      expect(result, isA<GenericFailure>());
    });

    test('Should get $Right value when object is $Right', () {
      // Arrange
      final obj = Right('value');

      // Act
      final result = obj.fold((l) => l, (r) => r);

      // Assert
      expect(obj.isLeft, false);
      expect(obj.isRight, true);
      expect(result, isA<String>());
      expect(result, 'value');
    });
  });
}
