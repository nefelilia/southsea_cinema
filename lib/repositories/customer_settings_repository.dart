
import 'package:southsea_cinema/models/customer_settings.dart';

class CustomerSettingsRepository {
  CustomerSettings? _settings;

  CustomerSettings? get settings => _settings;

  void saveSettings(CustomerSettings settings) {
    _settings = settings;
  }

  void clearSettings() {
    _settings = null;
  }
}

final CustomerSettingsRepository customerSettingsRepository =
    CustomerSettingsRepository();
