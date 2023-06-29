import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:rental_owner/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 35,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) {
                return FlutterSwitch(
                  width: 100.0,
                  height: 55.0,
                  toggleSize: 45.0,
                  borderRadius: 30.0,
                  padding: 2.0,
                  value: themeProvider.currentThemeMode == ThemeModeType.dark,
                  onToggle: (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                  activeToggleColor: const Color(0xFF6E40C9),
                  inactiveToggleColor: const Color(0xFF2F363D),
                  activeSwitchBorder: Border.all(
                    color: const Color(0xFF3C1E70),
                    width: 6.0,
                  ),
                  inactiveSwitchBorder: Border.all(
                    color: const Color(0xFFD1D5DA),
                    width: 6.0,
                  ),
                  activeColor: const Color(0xFF271052),
                  inactiveColor: Colors.white,
                  activeIcon: const Icon(
                    Icons.nightlight_round,
                    color: Color(0xFFF8E3A1),
                  ),
                  inactiveIcon: const Icon(
                    Icons.wb_sunny,
                    color: Color(0xFFFFDF5D),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
