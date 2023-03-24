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

  group('Golden Test ...', () {
    group('Custom Button', () {
      testWidgets(
        'is enabled',
        (widgetTester) async {
          await widgetTester.pumpWidget(widgetUnderMethbod(callback: (() {})));
          await expectLater(
              find.byType(CustomButton), matchesGoldenFile('goldens/'));
        },
      );
    });
  });
}
