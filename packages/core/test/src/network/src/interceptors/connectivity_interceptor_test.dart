import 'dart:io';

import 'package:core/core.dart';
import 'package:core/src/network/src/interceptors/connectivity_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockInternetAddress extends Mock {
  Future<List<InternetAddress>> lookup(String host);
}

class _FakeNetworkRequest extends Fake implements NetworkRequest {
  @override
  String get url => 'url';

  @override
  NetworkRequestMethod get method => NetworkRequestMethod.get;

  @override
  Duration? get timeout => Duration.zero;
}

void main() {
  late _MockInternetAddress _internetAddress;
  late ConnectivityInterceptor _connectivityInterceptor;

  setUp(() {
    _internetAddress = _MockInternetAddress();
    _connectivityInterceptor = ConnectivityInterceptor(_internetAddress.lookup);
  });

  group('Method onRequest -', () {
    test('Should return $InterceptorFailure when address lookup fails',
        () async {
      when(() => _internetAddress.lookup(any())).thenAnswer((_) async => []);

      final result =
          await _connectivityInterceptor.onRequest(_FakeNetworkRequest());

      expect(result.isLeft, true);
      expect(result.left, isA<InterceptorFailure>());
      verify(() => _internetAddress.lookup(any())).called(1);
    });

    test('Should return $Right when address lookup succeeds', () async {
      when(() => _internetAddress.lookup(any())).thenAnswer(
        (_) async => [
          InternetAddress('0.0.0.0', type: InternetAddressType.IPv4),
        ],
      );

      final result =
          await _connectivityInterceptor.onRequest(_FakeNetworkRequest());

      expect(result.isRight, true);
      expect(result.right, isA<NetworkRequest>());
      verify(() => _internetAddress.lookup(any())).called(1);
    });
  });
}
