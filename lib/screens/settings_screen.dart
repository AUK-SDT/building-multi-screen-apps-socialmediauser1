import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person, size: 32, color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Denji',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '+81 90 1234 5678',
                      style: TextStyle(color: AppColors.accent, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 16),
          const SettingsTile(icon: Icons.notifications_outlined, title: 'Notifications and Sounds'),
          const SettingsTile(icon: Icons.lock_outline,           title: 'Privacy and Security'),
          const SettingsTile(icon: Icons.data_usage,             title: 'Data and Storage'),
          const SettingsTile(icon: Icons.palette_outlined,       title: 'Appearance'),
          const SettingsTile(icon: Icons.devices_outlined,       title: 'Devices'),
          const SettingsTile(icon: Icons.language,               title: 'Language'),
          const Divider(height: 16),
          const SettingsTile(icon: Icons.help_outline,           title: 'Help'),
          const SettingsTile(icon: Icons.info_outline,           title: 'About'),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.accent, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontSize: 15, color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: AppColors.hint, size: 20),
    );
  }
}
