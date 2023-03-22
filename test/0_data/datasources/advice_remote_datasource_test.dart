import 'package:flutter_pattern/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_pattern/0_data/exeptions/exeprions.dart';
import 'package:flutter_pattern/0_data/models/advice_model.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_remote_datasource_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('advice remote datasource ...', () {
    group('should retuen AdviceModel', () {
      test('when Client response was 200 and has valid data', () async {
        final mockClient = MockClient();

        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        const responseBody = '{"advice": "test advice", "advice_id": 1}';

        when(mockClient.get(
            Uri.parse('https://64196f0df398d7d95d3f26d8.mockapi.io/advice'),
            headers: {'content-type': 'application/json'})).thenAnswer(
          (realInvocation) => Future.value(
            http.Response(responseBody, 200),
          ),
        );

        final result =
            await adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

        expect(result, AdviceModel(advice: 'test advice', id: 1));
      });
    });

    group('should throw', () {
      test('a ServerExeption when Client response was not 200', () {
        final mockClient = MockClient();

        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);
        when(
          mockClient.get(
            Uri.parse('https://64196f0df398d7d95d3f26d8.mockapi.io/advice'),
            headers: {'content-type': 'application/json'},
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(
            http.Response('', 201),
          ),
        );

        final result = adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

        expect(result, throwsA(isA<ServerException>()));
      });

      test('a Type when Client response was 200 and has no valid data', () {
        final mockClient = MockClient();

        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

        const responseBody = '{"advice": "test advice"}';

        when(
          mockClient.get(
            Uri.parse('https://64196f0df398d7d95d3f26d8.mockapi.io/advice'),
            headers: {'content-type': 'application/json'},
          ),
        ).thenAnswer(
          (realInvocation) => Future.value(
            http.Response(responseBody, 200),
          ),
        );

        final result = adviceRemoteDatasourceUnderTest.getRandomAdviceFromApi();

        expect(result, throwsA(isA<TypeError>()));
      });
    });
  });
}
