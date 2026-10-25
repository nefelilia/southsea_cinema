
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/customer_settings.dart';
import 'package:southsea_cinema/repositories/customer_settings_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _patronController = TextEditingController();

  bool receiveNews = false;

  @override
  void initState() {
    super.initState();

    final savedSettings = customerSettingsRepository.settings;

    if (savedSettings != null) {
      _nameController.text = savedSettings.fullName;
      _addressController.text = savedSettings.address;
      _emailController.text = savedSettings.email;
      _patronController.text = savedSettings.patronNumber;
      receiveNews = savedSettings.receiveNews;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _patronController.dispose();
    super.dispose();
  }

  void saveSettings() {
    if (_formKey.currentState!.validate()) {
      final settings = CustomerSettings(
        fullName: _nameController.text.trim(),
        address: _addressController.text.trim(),
        email: _emailController.text.trim(),
        patronNumber: _patronController.text.trim(),
        receiveNews: receiveNews,
      );

      customerSettingsRepository.saveSettings(settings);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings saved successfully!'),
        ),
      );
    }
  }

  void cancelSettings() {
    final savedSettings = customerSettingsRepository.settings;

    setState(() {
      _nameController.text = savedSettings?.fullName ?? '';
      _addressController.text = savedSettings?.address ?? '';
      _emailController.text = savedSettings?.email ?? '';
      _patronController.text = savedSettings?.patronNumber ?? '';
      receiveNews = savedSettings?.receiveNews ?? false;
    });

    _formKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinemaBackground,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Settings',
                style: cinemaHeaderStyle,
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _addressController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null ||
                      !RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                          .hasMatch(value.trim())) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: _patronController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Patron Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your patron number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28),

              const Text(
                'Preferences',
                style: TextStyle(
                  color: cinemaFontMuted,
                  fontSize: 18,
                ),
              ),
              SwitchListTile(
                title: const Text(
                  'Receive news by email',
                  style: TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
                value: receiveNews,
                activeThumbColor: cinemaBrand,
                onChanged: (value) {
                  setState(() {
                    receiveNews = value;
                  });
                },
              ),
              const SizedBox(height: 28),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  OutlinedButton(
                    onPressed: cancelSettings,
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: saveSettings,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cinemaBrand,
                      foregroundColor: cinemaBackground,
                    ),
                    child: const Text('SAVE SETTINGS'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
