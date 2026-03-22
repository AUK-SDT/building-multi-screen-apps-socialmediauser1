import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../data/seed_data.dart';
import '../models/chat_item.dart';
import '../theme/app_theme.dart';
import '../widgets/chat_search_bar.dart';
import '../widgets/chat_tile.dart';
import '../widgets/filter_row.dart';
import 'chat_detail_screen.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => ChatsScreenState();
}

class ChatsScreenState extends State<ChatsScreen> {
  final searchController = TextEditingController();
  late List<ChatItem> chats;
  String searchQuery = '';
  int selectedFilter = 0;

  @override
  void initState() {
    super.initState();
    chats = List<ChatItem>.from(seedChats);
    sortChats();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void sortChats() {
    chats.sort((a, b) {
      if (a.isPinned == b.isPinned) return 0;
      return a.isPinned ? -1 : 1;
    });
  }

  int get unreadTotal => chats.fold(0, (sum, c) => sum + c.unreadCount);

  List<ChatItem> get visibleChats {
    final query = searchQuery.trim().toLowerCase();
    return chats.where((chat) {
      final matchesFilter = switch (selectedFilter) {
        1 => chat.unreadCount > 0,
        2 => chat.isPinned,
        _ => true,
      };
      final matchesQuery = query.isEmpty ||
          chat.title.toLowerCase().contains(query) ||
          chat.subtitle.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  void togglePinned(ChatItem item) {
    setState(() {
      final index = chats.indexOf(item);
      if (index == -1) return;
      chats[index] = item.copyWith(isPinned: !item.isPinned);
      sortChats();
    });
  }

  void markRead(ChatItem item) {
    setState(() {
      final index = chats.indexOf(item);
      if (index == -1) return;
      chats[index] = item.copyWith(unreadCount: 0);
    });
  }

  void removeChat(ChatItem item) {
    setState(() => chats.remove(item));
  }

  void openChat(ChatItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatDetailScreen(
          item: item,
          onMarkRead: () => markRead(item),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visible = visibleChats;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats ($unreadTotal)'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: ChatSearchBar(
              controller: searchController,
              onChanged: (v) => setState(() => searchQuery = v),
            ),
          ),
          const SizedBox(height: 10),
          FilterRow(
            selectedIndex: selectedFilter,
            onChanged: (v) => setState(() => selectedFilter = v),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text(
                      'No chats found',
                      style: TextStyle(color: AppColors.hint, fontSize: 15),
                    ),
                  )
                : ListView.separated(
                    itemCount: visible.length,
                    separatorBuilder: (_, __) => const Divider(indent: 86),
                    itemBuilder: (context, i) {
                      final item = visible[i];
                      return Slidable(
                        key: ValueKey('chat-${item.title}'),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.5,
                          dismissible: DismissiblePane(
                            confirmDismiss: () async => true,
                            onDismissed: () => removeChat(item),
                          ),
                          children: [
                            SlidableAction(
                              onPressed: (_) => togglePinned(item),
                              backgroundColor: AppColors.accent,
                              foregroundColor: Colors.white,
                              icon: item.isPinned
                                  ? Icons.push_pin_outlined
                                  : Icons.push_pin,
                              label: item.isPinned ? 'Unpin' : 'Pin',
                            ),
                            SlidableAction(
                              onPressed: (_) => removeChat(item),
                              backgroundColor: AppColors.danger,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ChatTile(
                          item: item,
                          onTap: () => openChat(item),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
