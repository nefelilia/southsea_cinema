import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:southsea_cinema/repositories/customer_settings_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  Future<void> openSettings(
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    await tester.pumpAndSettle();
  }

  group('Customer settings widget tests', () {
    testWidgets(
      'Settings form loads saved preferences',
      (tester) async {
        SharedPreferencesAsyncPlatform.instance =
            InMemorySharedPreferencesAsync.withData(
          <String, Object>{
            CustomerSettingsRepository.prefName: 'Alex Smith',
            CustomerSettingsRepository.prefAddress:
                '10 High Street, Portsmouth',
            CustomerSettingsRepository.prefEmail: 'alex@example.com',
            CustomerSettingsRepository.prefPatron: '1234',
            CustomerSettingsRepository.prefNewsletter: true,
          },
        );

        await openSettings(tester);

        expect(
          find.text('Alex Smith'),
          findsOneWidget,
        );

        expect(
          find.text('10 High Street, Portsmouth'),
          findsOneWidget,
        );

        expect(
          find.text('alex@example.com'),
          findsOneWidget,
        );

        expect(
          find.text('1234'),
          findsOneWidget,
        );

        final newsletter = tester.widget<SwitchListTile>(
          find.byType(SwitchListTile),
        );

        expect(newsletter.value, true);
      },
    );

    testWidgets(
      'Saving the form updates stored preferences',
      (tester) async {
        await openSettings(tester);

        final fields = find.byType(TextFormField);

        await tester.enterText(
          fields.at(0),
          'Jamie Smith',
        );

        await tester.enterText(
          fields.at(1),
          '20 High Street, Portsmouth',
        );

        await tester.enterText(
          fields.at(2),
          'jamie@example.com',
        );

        await tester.enterText(
          fields.at(3),
          '5678',
        );

        final newsletter = find.byType(SwitchListTile);

        await tester.ensureVisible(newsletter);

        final newsletterWidget = tester.widget<SwitchListTile>(newsletter);

        if (!newsletterWidget.value) {
          await tester.tap(newsletter);
          await tester.pumpAndSettle();
        }

        expect(
          tester.widget<SwitchListTile>(newsletter).value,
          isTrue,
        );

        final saveButton = find.text('Save');

        await tester.ensureVisible(saveButton);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        final settings = await customerSettingsRepository.loadSettings();

        expect(settings.fullName, 'Jamie Smith');
        expect(
          settings.address,
          '20 High Street, Portsmouth',
        );
        expect(settings.email, 'jamie@example.com');
        expect(settings.patronNumber, '5678');
        expect(settings.receiveNews, true);
      },
    );

    testWidgets(
      'Reopening settings displays updated values',
      (tester) async {
        await openSettings(tester);

        final fields = find.byType(TextFormField);

        await tester.enterText(
          fields.at(0),
          'Taylor Smith',
        );

        await tester.enterText(
          fields.at(1),
          '30 High Street, Portsmouth',
        );

        await tester.enterText(
          fields.at(2),
          'taylor@example.com',
        );

        await tester.enterText(
          fields.at(3),
          '9012',
        );

        final saveButton = find.text('Save');

        await tester.ensureVisible(saveButton);
        await tester.tap(saveButton);
        await tester.pumpAndSettle();

        // Close the settings page.
        await tester.pumpWidget(
          const SizedBox.shrink(),
        );
        await tester.pumpAndSettle();

        // Reopen the settings page.
        await openSettings(tester);

        expect(
          find.text('Taylor Smith'),
          findsOneWidget,
        );

        expect(
          find.text('30 High Street, Portsmouth'),
          findsOneWidget,
        );

        expect(
          find.text('taylor@example.com'),
          findsOneWidget,
        );

        expect(
          find.text('9012'),
          findsOneWidget,
        );
      },
    );
  });
}
