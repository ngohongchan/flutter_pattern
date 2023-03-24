import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pattern/3_application/pages/advice/widgets/advice.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget widgetUnderTest({required String adviceTest}) {
    return MaterialApp(
      home: AdviceField(advice: adviceTest),
    );
  }

  group(
    'advice ...',
    () {
      group(
        'should be displayed correcly',
        () {
          testWidgets(
            'when a short text us given',
            (widgetTester) async {
              const text = 'a';

              await widgetTester.pumpWidget(widgetUnderTest(adviceTest: text));
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.textContaining('a');

              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when a long text us given',
            (widgetTester) async {
              const text =
                  'Hello flutter developers, i hope you enjoy the course, and have a greate time. The sun is shning, i have no idea what else i should write here to get a very long text.';

              await widgetTester.pumpWidget(widgetUnderTest(adviceTest: text));
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.byType(AdviceField);

              expect(adviceFieldFinder, findsOneWidget);
            },
          );

          testWidgets(
            'when no text is given',
            (widgetTester) async {
              const text = '';

              await widgetTester.pumpWidget(widgetUnderTest(adviceTest: text));
              await widgetTester.pumpAndSettle();

              final adviceFieldFinder = find.text(AdviceField.emptyAdvice);
              final adviceText =
                  widgetTester.widget<AdviceField>(find.byType(AdviceField));

              expect(adviceFieldFinder, findsOneWidget);
              expect(adviceText, '');
            },
          );
        },
      );
    },
  );
}
