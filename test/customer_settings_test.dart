
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/customer_settings.dart';
import 'package:southsea_cinema/repositories/customer_settings_repository.dart';

void main() {
  group('Customer Settings Repository Tests', () {
    test('Settings are initially empty', () {
      final repository = CustomerSettingsRepository();

      expect(repository.settings, isNull);
    });

    test('Customer settings can be saved', () {
      final repository = CustomerSettingsRepository();

      const settings = CustomerSettings(
        fullName: 'Alex Smith',
        address: 'Portsmouth',
        email: 'alex@example.com',
        patronNumber: '1234',
        receiveNews: true,
      );

      repository.saveSettings(settings);

      expect(repository.settings?.fullName, 'Alex Smith');
      expect(repository.settings?.address, 'Portsmouth');
      expect(repository.settings?.email, 'alex@example.com');
      expect(repository.settings?.patronNumber, '1234');
      expect(repository.settings?.receiveNews, true);
    });

    test('Customer settings can be updated', () {
      final repository = CustomerSettingsRepository();

      const original = CustomerSettings(
        fullName: 'Alex Smith',
        address: 'Portsmouth',
        email: 'alex@example.com',
        patronNumber: '1234',
        receiveNews: true,
      );

      const updated = CustomerSettings(
        fullName: 'Alex Smith',
        address: 'London',
        email: 'alex@example.com',
        patronNumber: '1234',
        receiveNews: false,
      );

      repository.saveSettings(original);
      repository.saveSettings(updated);

      expect(repository.settings?.address, 'London');
      expect(repository.settings?.receiveNews, false);
    });

    test('Customer settings can be cleared', () {
      final repository = CustomerSettingsRepository();

      const settings = CustomerSettings(
        fullName: 'Alex Smith',
        address: 'Portsmouth',
        email: 'alex@example.com',
        patronNumber: '1234',
        receiveNews: true,
      );

      repository.saveSettings(settings);
      repository.clearSettings();

      expect(repository.settings, isNull);
    });
  });
}
