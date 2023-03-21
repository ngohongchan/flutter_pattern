import 'package:flutter_pattern/0_data/datasources/advice_remote_datasource.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  group('advice remote datasource ...', () {
    group('should retuen AdviceModel', () {
      test('when Client response was 200 and has valid data', () {
        final mockClient = MockClient();

        final adviceRemoteDatasourceUnderTest =
            AdviceRemoteDataSourceImpl(client: mockClient);

            when(mockClient.get(url))
      });
    });
  });
}
