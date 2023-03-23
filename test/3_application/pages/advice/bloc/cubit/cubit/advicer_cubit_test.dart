import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_pattern/1_domain/entities/advice_entity.dart';
import 'package:flutter_pattern/1_domain/failures/failures.dart';
import 'package:flutter_pattern/1_domain/usecases/advice_usecases.dart';
import 'package:flutter_pattern/3_application/pages/advice/bloc/cubit/cubit/advicer_cubit.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';

class MockAdviceUseCase extends Mock implements AdviceUseCases {}

void main() {
  group('advicer cubit ...', () {
    group(
      'should emits',
      () {
        MockAdviceUseCase mockAdviceUseCase = MockAdviceUseCase();
        blocTest(
          'nothing when no method is called',
          build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCase),
          act: (bloc) => const <AdvicerCubitState>[],
        );

        blocTest<AdvicerCubit, AdvicerCubitState>(
          '[AdviceStateLoading, AdvicerStateLoaded when adviceRequested() is called]',
          build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCase),
          act: (cubit) => cubit.adviceRequested(),
          setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
            (invocation) => Future.value(
              const Right<Failure, AdviceEntity>(
                AdviceEntity(advice: 'advice', id: 1),
              ),
            ),
          ),
          expect: () => const <AdvicerCubitState>[
            AdvicerStateLoading(),
            AdvicerStateError(message: 'error message')
          ],
        );

        group(
            '[AdvicerStateLoading, AdvicerStateError] when adviceRequested() is called',
            () async {
          blocTest(
            'and a ServerFailure occors',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  ServerFailure(),
                ),
              ),
            ),
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCase),
            expect: () => const <AdvicerCubitState>[
              AdvicerStateLoading(),
              AdvicerStateError(
                message: 'error message',
              )
            ],
          );

          blocTest(
            'and a GeneralFailure occors',
            setUp: () => when(() => mockAdviceUseCase.getAdvice()).thenAnswer(
              (invocation) => Future.value(
                Left<Failure, AdviceEntity>(
                  GeneralFailure(),
                ),
              ),
            ),
            build: () => AdvicerCubit(adviceUseCases: mockAdviceUseCase),
            expect: () => const <AdvicerCubitState>[
              AdvicerStateLoading(),
              AdvicerStateError(
                message: 'error message',
              )
            ],
          );
        });
      },
    );
  });
}
