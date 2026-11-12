import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:southsea_cinema/models/customer_settings.dart';
import 'package:southsea_cinema/repositories/customer_settings_repository.dart';

void main() {
  late CustomerSettingsRepository repository;

  const settings = CustomerSettings(
    fullName: 'Alex Smith',
    address: '10 High Street, Portsmouth',
    email: 'alex@example.com',
    patronNumber: '1234',
    receiveNews: true,
  );

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    repository = CustomerSettingsRepository();
  });

  group('CustomerSettingsRepository tests', () {
    test('Default settings are empty', () async {
      final result = await repository.loadSettings();

      expect(result.fullName, '');
      expect(result.address, '');
      expect(result.email, '');
      expect(result.patronNumber, '');
      expect(result.receiveNews, false);
    });

    test('Save and load customer settings', () async {
      await repository.saveSettings(settings);

      final result = await repository.loadSettings();

      expect(result.fullName, 'Alex Smith');
      expect(
        result.address,
        '10 High Street, Portsmouth',
      );
      expect(result.email, 'alex@example.com');
      expect(result.patronNumber, '1234');
      expect(result.receiveNews, true);
    });

    test('Customer settings can be updated', () async {
      await repository.saveSettings(settings);

      const updatedSettings = CustomerSettings(
        fullName: 'Jamie Smith',
        address: '20 High Street, Portsmouth',
        email: 'jamie@example.com',
        patronNumber: '5678',
        receiveNews: false,
      );

      await repository.saveSettings(updatedSettings);

      final result = await repository.loadSettings();

      expect(result.fullName, 'Jamie Smith');
      expect(
        result.address,
        '20 High Street, Portsmouth',
      );
      expect(result.email, 'jamie@example.com');
      expect(result.patronNumber, '5678');
      expect(result.receiveNews, false);
    });

    test('Customer settings can be cleared', () async {
      await repository.saveSettings(settings);

      await repository.clearSettings();

      final result = await repository.loadSettings();

      expect(result.fullName, '');
      expect(result.address, '');
      expect(result.email, '');
      expect(result.patronNumber, '');
      expect(result.receiveNews, false);
    });
  });
}
