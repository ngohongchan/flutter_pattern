import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/0_data/datasources/advice_remote_datasource.dart';
import 'package:flutter_pattern/0_data/exeptions/exeprions.dart';
import 'package:flutter_pattern/0_data/models/advice_model.dart';
import 'package:flutter_pattern/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_repo_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRemoteDataSourceImpl>()])
void main() {
  group('advice repo impl ...', () {
    group('should return AdviceEntity', () {
      test('when AdviceRemoteDatasource return a AdviceModel', () async {
        final mockAdviceRemoteDataSourceImpl = MockAdviceRemoteDataSourceImpl();

        final adviceRepoInplUnderTest = AdviceRepoImpl(
            adviceRemoteDatasource: mockAdviceRemoteDataSourceImpl);

        when(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromApi())
            .thenAnswer((realInvocation) =>
                Future.value(AdviceModel(advice: 'test', id: 42)));

        final result = await adviceRepoInplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            Right<Failure, AdviceModel>(
              AdviceModel(advice: 'test', id: 42),
            ));
        verify(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromApi())
            .called(1);
        verifyNoMoreInteractions(mockAdviceRemoteDataSourceImpl);
      });
    });

    group('should return left with', () {
      test('a ServerFailure when a ServerExeption occurs', () async {
        final mockAdviceRemoteDataSourceImpl = MockAdviceRemoteDataSourceImpl();

        final adviceRepoInplUnderTest = AdviceRepoImpl(
            adviceRemoteDatasource: mockAdviceRemoteDataSourceImpl);

        when(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromApi())
            .thenThrow(ServerException());

        final result = await adviceRepoInplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
      });

      test('a GeneralFailure on all other Exeptions', () async {
        final mockAdviceRemoteDataSourceImpl = MockAdviceRemoteDataSourceImpl();

        final adviceRepoInplUnderTest = AdviceRepoImpl(
            adviceRemoteDatasource: mockAdviceRemoteDataSourceImpl);

        when(mockAdviceRemoteDataSourceImpl.getRandomAdviceFromApi())
            .thenThrow(const SocketException('test'));

        final result = await adviceRepoInplUnderTest.getAdviceFromDataSource();

        expect(result.isLeft(), true);
        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
      });
    });
  });
}
