import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_pattern/3_application/pages/advice/bloc/bloc/advice_bloc.dart';
import 'package:test/test.dart';

void main() {
  group('advicer cubit ...', () {
    group('should emits', () {
      blocTest<AdviceBloc, AdviceState>(
        'nothing when no event is added',
        build: () => AdviceBloc(),
        expect: () => const <AdviceState>[],
      );

      blocTest<AdviceBloc, AdviceState>(
        '[AdvicerStateLOading, AdvicerError]',
        build: () => AdviceBloc(),
        act: (bloc) => bloc.add(AdviceRequestedEvent()),
        wait: const Duration(seconds: 3),
        expect: () => <AdviceState>[
          AdvicerStateLoading(),
          AdvicerStateError(message: 'error message')
        ],
      );
    });
  });
}
