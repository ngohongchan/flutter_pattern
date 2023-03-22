import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/0_data/repositories/advice_repo_impl.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:flutter_pattern/1_domain/usecases/advice_usecases.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'advice_usecases_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AdviceRepoImpl>()])
void main() {
  group('advice usecases ...', () {
    group('should return AdviceEntity', () {
      test('when AdviceRepoImpl return a AdviceModel', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUsecaseUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) =>
                Future.value(const Right(AdviceEntity(advice: 'test', id: 1))));

        final result = await adviceUsecaseUnderTest.getAdvice();

        expect(result.isLeft(), false);
        expect(result.isRight(), true);
        expect(
            result,
            const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'test', id: 1)));
        verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead.called(0)
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });

    group('should reuturn left with', () {
      test('a ServerFailure', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUsecaseUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(ServerFailure())));

        final result = await adviceUsecaseUnderTest.getAdvice();
        expect(result.isLeft(), true);

        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(ServerFailure()));
        verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead.called(0)
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });

      test('a GenneralFailure', () async {
        final mockAdviceRepoImpl = MockAdviceRepoImpl();
        final adviceUsecaseUnderTest =
            AdviceUseCases(adviceRepo: mockAdviceRepoImpl);

        when(mockAdviceRepoImpl.getAdviceFromDataSource()).thenAnswer(
            (realInvocation) => Future.value(Left(GeneralFailure())));

        final result = await adviceUsecaseUnderTest.getAdvice();
        expect(result.isLeft(), true);

        expect(result.isRight(), false);
        expect(result, Left<Failure, AdviceEntity>(GeneralFailure()));
        verify(mockAdviceRepoImpl.getAdviceFromDataSource()).called(
            1); // when you want to check if a method was not call use verifyNever(mock.methodCall) instead.called(0)
        verifyNoMoreInteractions(mockAdviceRepoImpl);
      });
    });
  });
}
