import 'package:flutter/material.dart';
import '../data/seed_data.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar.dart';
import 'contact_info_screen.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sorted = [...seedChats]
      ..sort((a, b) => a.title.compareTo(b.title));

    return Scaffold(
      appBar: AppBar(title: const Text('Contacts')),
      body: ListView.separated(
        itemCount: sorted.length,
        separatorBuilder: (_, __) => const Divider(indent: 72),
        itemBuilder: (context, i) {
          final contact = sorted[i];
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            leading: Avatar(item: contact, size: 50),
            title: Text(
              contact.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            subtitle: const Text(
              'last seen recently',
              style: TextStyle(color: AppColors.hint, fontSize: 13),
            ),
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.hint,
              size: 20,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ContactInfoScreen(contact: contact),
              ),
            ),
          );
        },
      ),
    );
  }
}
