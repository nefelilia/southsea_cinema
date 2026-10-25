
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  testWidgets('PrimaryButton displays label and responds to tap',
      (tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'Test Button',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Test Button'), findsOneWidget);

    final button = tester.widget<ElevatedButton>(
      find.byType(ElevatedButton),
    );

    expect(
      button.style?.backgroundColor?.resolve({}),
      cinemaBrand,
    );

    await tester.tap(find.text('Test Button'));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}
