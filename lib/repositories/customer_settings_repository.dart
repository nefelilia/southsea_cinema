import 'package:shared_preferences/shared_preferences.dart';
import 'package:southsea_cinema/models/customer_settings.dart';

class CustomerSettingsRepository {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  static const String prefName = 'customer_name';
  static const String prefAddress = 'customer_address';
  static const String prefEmail = 'customer_email';
  static const String prefPatron = 'customer_patron';
  static const String prefNewsletter = 'customer_newsletter';

  Future<CustomerSettings> loadSettings() async {
    final name = await _preferences.getString(prefName);
    final address = await _preferences.getString(prefAddress);
    final email = await _preferences.getString(prefEmail);
    final patron = await _preferences.getString(prefPatron);
    final newsletter = await _preferences.getBool(prefNewsletter);

    return CustomerSettings(
      fullName: name ?? '',
      address: address ?? '',
      email: email ?? '',
      patronNumber: patron ?? '',
      receiveNews: newsletter ?? false,
    );
  }

  Future<void> saveSettings(
    CustomerSettings settings,
  ) async {
    await _preferences.setString(
      prefName,
      settings.fullName,
    );

    await _preferences.setString(
      prefAddress,
      settings.address,
    );

    await _preferences.setString(
      prefEmail,
      settings.email,
    );

    await _preferences.setString(
      prefPatron,
      settings.patronNumber,
    );

    await _preferences.setBool(
      prefNewsletter,
      settings.receiveNews,
    );
  }

  Future<void> clearSettings() async {
    await _preferences.remove(prefName);
    await _preferences.remove(prefAddress);
    await _preferences.remove(prefEmail);
    await _preferences.remove(prefPatron);
    await _preferences.remove(prefNewsletter);
  }
}

final CustomerSettingsRepository customerSettingsRepository =
    CustomerSettingsRepository();
