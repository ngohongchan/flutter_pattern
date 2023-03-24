import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pattern/3_application/pages/advice/widgets/custom_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

abstract class OnCustomButtonOnTap {
  void call();
}

class MockOnCustomButtonOntap extends Mock implements OnCustomButtonOnTap {}

void main() {
  Widget widgetUnderMethbod({Function()? callback}) {
    return MaterialApp(
      home: Scaffold(
        body: CustomButton(
          onTap: callback,
        ),
      ),
    );
  }

  group('custom button ...', () {
    group('is Button rendered correctly', () {
      testWidgets('and has all parts that he need', (widgetTester) async {
        await widgetTester.pumpWidget(widgetUnderMethbod());

        final buttonLabelFinder = find.text('Get Advice');

        expect(buttonLabelFinder, findsOneWidget);
      });
    });

    group('should handle onTap', () {
      testWidgets('when someone has pressed the button', (widgetTester) async {
        final mockOnCustomButtonOntap = MockOnCustomButtonOntap();
        await widgetTester.pumpWidget(widgetUnderMethbod(
          callback: mockOnCustomButtonOntap,
        ));

        final customButtonFinder = find.byType(CustomButton);

        widgetTester.tap(customButtonFinder);

        verify(mockOnCustomButtonOntap()).called(1);
      });
    });
  });
}
