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
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final settings = await customerSettingsRepository.loadSettings();

      if (!mounted) return;

      setState(() {
        _nameController.text = settings.fullName;
        _addressController.text = settings.address;
        _emailController.text = settings.email;
        _patronController.text = settings.patronNumber;
        receiveNews = settings.receiveNews;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to load settings'),
        ),
      );
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
    });

    final settings = CustomerSettings(
      fullName: _nameController.text.trim(),
      address: _addressController.text.trim(),
      email: _emailController.text.trim(),
      patronNumber: _patronController.text.trim(),
      receiveNews: receiveNews,
    );

    try {
      await customerSettingsRepository.saveSettings(
        settings,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Settings saved successfully!'),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to save settings'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  Future<void> _cancelSettings() async {
    setState(() {
      _isLoading = true;
    });

    await _loadSettings();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _patronController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cinemaBackground,
      appBar: AppBar(
        title: const Text(appTitle),
      ),
      drawer: const NavDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: cinemaBrand,
              ),
            )
          : SingleChildScrollView(
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
                      enabled: !_isSaving,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        labelStyle: TextStyle(
                          color: cinemaFontWhite,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      enabled: !_isSaving,
                      maxLines: 3,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: cinemaFontWhite,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      enabled: !_isSaving,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        labelStyle: TextStyle(
                          color: cinemaFontWhite,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }

                        final emailPattern = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        );

                        if (!emailPattern.hasMatch(
                          value.trim(),
                        )) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _patronController,
                      enabled: !_isSaving,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        color: cinemaFontWhite,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Patron Number',
                        labelStyle: TextStyle(
                          color: cinemaFontWhite,
                        ),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your patron number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text(
                        'Receive news by email',
                        style: TextStyle(
                          color: cinemaFontWhite,
                        ),
                      ),
                      value: receiveNews,
                      activeThumbColor: cinemaBrand,
                      onChanged: _isSaving
                          ? null
                          : (value) {
                              setState(() {
                                receiveNews = value;
                              });
                            },
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        OutlinedButton(
                          onPressed: _isSaving ? null : _cancelSettings,
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: cinemaBrand,
                            foregroundColor: cinemaBackground,
                          ),
                          onPressed: _isSaving ? null : _saveSettings,
                          child: Text(
                            _isSaving ? 'Saving...' : 'Save',
                          ),
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
