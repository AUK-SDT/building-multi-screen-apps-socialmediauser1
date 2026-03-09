import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'models/chat_item.dart';

void main() => runApp(const TelegramChatsApp());

class TelegramChatsApp extends StatelessWidget {
  const TelegramChatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF000000),
      ),
      home: const ChatsScreen(),
    );
  }
}

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  static const List<ChatItem> _seedChats = [
    ChatItem(
      title: 'Denji',
      subtitle: "Bro I'm starving. Any food plans?",
      time: '11:41',
      unreadCount: 2,
      imagePath: 'assets/images/denji.jpg',
    ),
    ChatItem(
      title: 'Power',
      subtitle: 'Bring me snacks. It is an order.',
      time: '11:30',
      unreadCount: 17,
      imagePath: 'assets/images/power.jpg',
    ),
    ChatItem(
      title: 'Aki Hayakawa',
      subtitle: 'Be on time. No excuses.',
      time: '10:58',
      unreadCount: 0,
      imagePath: 'assets/images/aki.jpg',
    ),
    ChatItem(
      title: 'Makima',
      subtitle: "Let's talk after you finish your task.",
      time: '10:12',
      unreadCount: 1,
      imagePath: 'assets/images/makima.jpg',
    ),
    ChatItem(
      title: 'Kobeni',
      subtitle: 'Wait... are we sure this is safe?',
      time: '09:49',
      unreadCount: 4,
      imagePath: 'assets/images/kobeni.jpg',
    ),
    ChatItem(
      title: 'Himeno',
      subtitle: "Good job today. Don't overthink it.",
      time: '09:10',
      unreadCount: 0,
      imagePath: 'assets/images/himeno.jpg',
    ),
    ChatItem(
      title: 'Kishibe',
      subtitle: 'Train. Then train again.',
      time: 'Yesterday',
      unreadCount: 0,
      imagePath: 'assets/images/kishibe.jpg',
    ),
    ChatItem(
      title: 'Angel Devil',
      subtitle: 'Do we really have to go outside today?',
      time: 'Yesterday',
      unreadCount: 0,
      imagePath: 'assets/images/angel.jpg',
    ),
    ChatItem(
      title: 'Reze',
      subtitle: 'Wanna grab coffee later?',
      time: 'Sat',
      unreadCount: 0,
      imagePath: 'assets/images/reze.jpg',
    ),
    ChatItem(
      title: 'Pochita',
      subtitle: 'woof!',
      time: 'Sat',
      unreadCount: 9,
      imagePath: 'assets/images/pochita.jpg',
    ),
  ];

  final TextEditingController _searchController = TextEditingController();
  late List<ChatItem> _chats;
  String _searchQuery = '';
  int _selectedFilter = 0;
  int _selectedBottomTab = 2;

  @override
  void initState() {
    super.initState();
    _chats = List<ChatItem>.from(_seedChats);
    _sortChats();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _sortChats() {
    _chats.sort((a, b) {
      if (a.isPinned == b.isPinned) return 0;
      return a.isPinned ? -1 : 1;
    });
  }

  int _unreadTotal() {
    return _chats.fold<int>(0, (sum, chat) => sum + chat.unreadCount);
  }

  List<ChatItem> _visibleChats() {
    final query = _searchQuery.trim().toLowerCase();
    return _chats.where((chat) {
      final matchesFilter = switch (_selectedFilter) {
        1 => chat.unreadCount > 0,
        2 => chat.isPinned,
        _ => true,
      };
      final matchesQuery =
          query.isEmpty ||
          chat.title.toLowerCase().contains(query) ||
          chat.subtitle.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  void _togglePinned(ChatItem item) {
    setState(() {
      final index = _chats.indexOf(item);
      if (index == -1) return;
      _chats[index] = item.copyWith(isPinned: !item.isPinned);
      _sortChats();
    });
  }

  void _toggleRead(ChatItem item) {
    setState(() {
      final index = _chats.indexOf(item);
      if (index == -1) return;
      final nextUnread = item.unreadCount > 0 ? 0 : 1;
      _chats[index] = item.copyWith(unreadCount: nextUnread);
    });
  }

  void _removeChat(ChatItem item) {
    setState(() {
      _chats.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleChats = _visibleChats();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111214),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 44,
        title: Text(
          'Chats (${_unreadTotal()})',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          FilterRow(
            selectedIndex: _selectedFilter,
            onChanged: (value) {
              setState(() {
                _selectedFilter = value;
              });
            },
          ),
          const SizedBox(height: 6),
          Expanded(
            child: visibleChats.isEmpty
                ? const Center(
                    child: Text(
                      'No chats found',
                      style: TextStyle(color: Color(0xFF8E8E93), fontSize: 15),
                    ),
                  )
                : ListView.separated(
                    itemCount: visibleChats.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      thickness: 0.8,
                      color: Color(0xFF121214),
                      indent: 86,
                    ),
                    itemBuilder: (context, index) {
                      final item = visibleChats[index];
                      return Slidable(
                        key: ValueKey('chat-${item.title}'),
                        endActionPane: ActionPane(
                          motion: const DrawerMotion(),
                          extentRatio: 0.5,
                          dismissible: DismissiblePane(
                            confirmDismiss: () async => true,
                            onDismissed: () => _removeChat(item),
                          ),
                          children: [
                            SlidableAction(
                              onPressed: (_) => _togglePinned(item),
                              backgroundColor: const Color(0xFF2D8CFF),
                              foregroundColor: Colors.white,
                              icon: item.isPinned
                                  ? Icons.push_pin_outlined
                                  : Icons.push_pin,
                              label: item.isPinned ? 'Unpin' : 'Pin',
                              borderRadius: BorderRadius.circular(0),
                            ),
                            SlidableAction(
                              onPressed: (_) => _removeChat(item),
                              backgroundColor: const Color(0xFFFE3B30),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ],
                        ),
                        child: ChatTile(
                          item: item,
                          onTap: () => _toggleRead(item),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBarMock(
        selectedIndex: _selectedBottomTab,
        onTap: (index) {
          setState(() {
            _selectedBottomTab = index;
          });
        },
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const SearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 14),
        decoration: const InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Color(0xFF8E8E93), size: 20),
          hintText: 'Search for messages or users',
          hintStyle: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
        ),
      ),
    );
  }
}

class FilterRow extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const FilterRow({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const labels = ['All', 'Unread', 'Pinned'];

    return SizedBox(
      height: 34,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return ChoiceChip(
            label: Text(labels[index]),
            selected: isSelected,
            onSelected: (_) => onChanged(index),
            selectedColor: const Color(0xFF2D8CFF),
            backgroundColor: const Color(0xFF1C1C1E),
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : const Color(0xFF8E8E93),
              fontSize: 13,
            ),
            side: BorderSide.none,
          );
        },
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemCount: labels.length,
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final ChatItem item;
  final VoidCallback onTap;

  const ChatTile({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: const Color(0xFF000000),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        child: Row(
          children: [
            Avatar(item: item),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (item.isPinned) ...[
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.push_pin,
                                size: 16,
                                color: Color(0xFF8E8E93),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item.time,
                        style: const TextStyle(
                          color: Color(0xFF8E8E93),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8E8E93),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      if (item.unreadCount > 0) ...[
                        const SizedBox(width: 10),
                        UnreadBubble(count: item.unreadCount),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnreadBubble extends StatelessWidget {
  final int count;
  const UnreadBubble({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    final label = count > 999 ? '999+' : count.toString();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  final ChatItem item;
  const Avatar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    const double size = 60;

    return ClipRRect(
      borderRadius: BorderRadius.circular(size / 2),
      child: Image.asset(
        item.imagePath ?? '',
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF2A2B2E),
            ),
            child: const Icon(Icons.person, color: Color(0xFF8E8E93)),
          );
        },
      ),
    );
  }
}

class BottomBarMock extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const BottomBarMock({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF111214),
        border: Border(top: BorderSide(color: Color(0xFF1C1C1E), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomItem(
            icon: Icons.person_outline,
            label: 'Contacts',
            color: selectedIndex == 0 ? Colors.white : const Color(0xFF8E8E93),
            onTap: () => onTap(0),
          ),
          BottomItem(
            icon: Icons.call_outlined,
            label: 'Calls',
            color: selectedIndex == 1 ? Colors.white : const Color(0xFF8E8E93),
            onTap: () => onTap(1),
          ),
          BottomItem(
            icon: Icons.chat_bubble_outline,
            label: 'Chats',
            color: selectedIndex == 2 ? Colors.white : const Color(0xFF8E8E93),
            onTap: () => onTap(2),
          ),
          BottomItem(
            icon: Icons.settings_outlined,
            label: 'Settings',
            color: selectedIndex == 3 ? Colors.white : const Color(0xFF8E8E93),
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const BottomItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 78,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
