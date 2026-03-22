import 'package:flutter/material.dart';
import '../data/seed_data.dart';
import '../models/chat_item.dart';
import '../theme/app_theme.dart';
import '../widgets/avatar.dart';
import 'chat_detail_screen.dart';

enum CallType { incoming, outgoing, missed }

class CallLog {
  final ChatItem contact;
  final CallType type;
  final String time;
  const CallLog({
    required this.contact,
    required this.type,
    required this.time,
  });
}

class CallsScreen extends StatelessWidget {
  const CallsScreen({super.key});

  static final calls = [
    CallLog(contact: seedChats[0], type: CallType.outgoing, time: 'Today, 11:40'),
    CallLog(contact: seedChats[1], type: CallType.incoming, time: 'Today, 10:15'),
    CallLog(contact: seedChats[3], type: CallType.missed,   time: 'Today, 09:30'),
    CallLog(contact: seedChats[4], type: CallType.incoming, time: 'Yesterday'),
    CallLog(contact: seedChats[2], type: CallType.outgoing, time: 'Yesterday'),
    CallLog(contact: seedChats[7], type: CallType.missed,   time: 'Sat'),
    CallLog(contact: seedChats[8], type: CallType.incoming, time: 'Fri'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calls')),
      body: ListView.separated(
        itemCount: calls.length,
        separatorBuilder: (_, __) => const Divider(indent: 72),
        itemBuilder: (context, i) {
          final call = calls[i];
          final isMissed = call.type == CallType.missed;
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            leading: Avatar(item: call.contact, size: 50),
            title: Text(
              call.contact.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isMissed ? AppColors.danger : Colors.white,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(
                  call.type == CallType.incoming
                      ? Icons.call_received
                      : call.type == CallType.outgoing
                          ? Icons.call_made
                          : Icons.call_missed,
                  size: 14,
                  color: isMissed ? AppColors.danger : AppColors.hint,
                ),
                const SizedBox(width: 4),
                Text(
                  call.time,
                  style: TextStyle(
                    fontSize: 13,
                    color: isMissed ? AppColors.danger : AppColors.hint,
                  ),
                ),
              ],
            ),
            trailing: const Icon(
              Icons.call_outlined,
              color: AppColors.accent,
              size: 22,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ChatDetailScreen(item: call.contact, onMarkRead: () {}),
              ),
            ),
          );
        },
      ),
    );
  }
}
