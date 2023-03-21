import 'dart:convert';

import 'package:flutter_pattern/0_data/exeptions/exeprions.dart';
import 'package:flutter_pattern/0_data/models/advice_model.dart';
import 'package:http/http.dart' as http;

abstract class AdviceRemoteDatasource {
  /// requests a random advice from api
  /// returns [AdviceModel] if successfully
  /// throws a server-Exeption
  Future<AdviceModel> getRandomAdviceFromApi();
}

class AdviceRemoteDataSourceImpl implements AdviceRemoteDatasource {
  final http.Client client;
  AdviceRemoteDataSourceImpl({required this.client});
  // final client = http.Client();
  @override
  Future<AdviceModel> getRandomAdviceFromApi() async {
    final response = await client.get(
      Uri.parse('https://64196f0df398d7d95d3f26d8.mockapi.io/advice'),
      headers: {
        'content-type': 'application/json ',
        'access-control-allow-methods': 'GET',
        'access-control-allow-origin': '*',
      },
    );

    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      final responseBody = json.decode(response.body);

      return AdviceModel.fromJson(responseBody);
    }
  }
}
