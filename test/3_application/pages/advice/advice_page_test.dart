import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pattern/3_application/core/services/theme_service.dart';
import 'package:flutter_pattern/3_application/pages/advice/advice_page.dart';
import 'package:flutter_pattern/3_application/pages/advice/bloc/cubit/cubit/advicer_cubit.dart';
import 'package:flutter_pattern/3_application/pages/advice/widgets/error_message.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:provider/provider.dart';

class MockAdvicerCubit extends MockCubit<AdvicerCubitState>
    implements AdvicerCubit {}

void main() {
  Widget widgetUnderTestFunction({required AdvicerCubit cubit}) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: ((context) => ThemeService()),
        child: BlocProvider<AdvicerCubit>(
          create: (context) => cubit,
          child: const AdvicerPage(),
        ),
      ),
    );
  }

  group('advice page ...', () {
    late AdvicerCubit mockAdvicerCubit;

    setUp(() {
      mockAdvicerCubit = MockAdvicerCubit();
    });

    group('should be displayed in ViewState', () {
      testWidgets(
        'Initial when cubit Emits AdvicerInitial()',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable(const [AdviceInitial()]),
            initialState: const AdviceInitial(),
          );

          await widgetTester.pumpWidget(
            widgetUnderTestFunction(
              cubit: mockAdvicerCubit,
            ),
          );

          final advicerInitialTextFinder =
              find.text('Your Advice is waiting for you!');

          expect(advicerInitialTextFinder, findsOneWidget);
        },
      );

      testWidgets(
        'advice text when cubits emits AdvicerStateLoaded()',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable([AdvicerStateLoaded(advice: '42')]),
            initialState: const AdviceInitial(),
          );

          await widgetTester.pumpWidget(
            widgetUnderTestFunction(
              cubit: mockAdvicerCubit,
            ),
          );

          await widgetTester.pump();

          final advicerInitialTextFinder = find.textContaining('42');

          expect(advicerInitialTextFinder, findsOneWidget);
        },
      );

      testWidgets(
        'Error when cubits emits AdvicerStateError()',
        (widgetTester) async {
          whenListen(
            mockAdvicerCubit,
            Stream.fromIterable(const [AdvicerStateError(message: 'error')]),
            initialState: const AdviceInitial(),
          );

          await widgetTester.pumpWidget(
            widgetUnderTestFunction(
              cubit: mockAdvicerCubit,
            ),
          );

          await widgetTester.pump();

          final advicerInitialTextFinder = find.byType(ErrorMessage);

          expect(advicerInitialTextFinder, findsOneWidget);
        },
      );
    });
  });
}
