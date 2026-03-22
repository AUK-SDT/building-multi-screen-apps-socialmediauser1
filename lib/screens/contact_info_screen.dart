import 'package:flutter/material.dart';
import '../models/chat_item.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar.dart';
import 'chat_detail_screen.dart';

class ContactInfoScreen extends StatelessWidget {
  final ChatItem contact;

  const ContactInfoScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact Info')),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          Center(child: Avatar(item: contact, size: 96)),
          const SizedBox(height: 16),
          Center(
            child: Text(
              contact.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'online',
              style: TextStyle(fontSize: 14, color: AppColors.accent),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Message',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatDetailScreen(
                        item: contact,
                        onMarkRead: () {},
                      ),
                    ),
                  ),
                ),
                _ActionButton(
                  icon: Icons.call_outlined,
                  label: 'Call',
                  onTap: () {},
                ),
                _ActionButton(
                  icon: Icons.video_call_outlined,
                  label: 'Video',
                  onTap: () {},
                ),
                _ActionButton(
                  icon: Icons.search,
                  label: 'Search',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),
          _InfoTile(
            icon: Icons.phone_outlined,
            label: 'Mobile',
            value: '+81 90 ${contact.title.hashCode.abs() % 9000 + 1000} ${contact.title.hashCode.abs() % 9000 + 1000}',
          ),
          const Divider(indent: 56),
          _InfoTile(
            icon: Icons.alternate_email,
            label: 'Username',
            value: '@${contact.title.toLowerCase().replaceAll(' ', '_')}',
          ),
          const Divider(),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Last message',
              style: TextStyle(
                fontSize: 13,
                color: AppColors.hint,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                contact.subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.block, color: AppColors.danger),
              label: Text(
                'Block ${contact.title}',
                style: const TextStyle(color: AppColors.danger),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.danger),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: AppColors.hint),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: AppColors.accent, size: 22),
      title: Text(value, style: const TextStyle(color: Colors.white, fontSize: 15)),
      subtitle: Text(label, style: const TextStyle(color: AppColors.hint, fontSize: 13)),
    );
  }
}
