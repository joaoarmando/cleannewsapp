import 'package:cleannewsapp/infra/network/networ_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'networ_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late InternetConnectionChecker internetConnectionChecker;
  late NetworkInfo networkInfo;

  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(internetConnectionChecker);
  });

  test('Should forward the call to InternetConnectionChecker.hasConnection', () async{
    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfo.isConnected;

    verify(internetConnectionChecker.hasConnection);
    expect(result, equals(true));
  });
}