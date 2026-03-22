# Project 5 - Interactive Chat UI (Flutter)

This README explains the full homework implementation, how it maps to the assignment requirements, and the key code used in the app.

## Assignment Requirements Checklist

- [x] Use previous layout as base
- [x] Convert relevant widgets to `StatefulWidget`
- [x] Manage UI updates using state and `setState()`
- [x] Add interactive elements (search, filters, swipe actions, tab switching, read toggles)
- [x] Ensure UI updates correctly after user actions
- [x] Use at least one package from pub.dev (`flutter_slidable`)

## What This App Implements

This app is a Telegram-style chats screen with:

- Search bar (live filtering)
- Filter chips (`All`, `Unread`, `Pinned`)
- Chat list with avatars and unread badges
- Swipe actions on the right side:
  - `Pin/Unpin`
  - `Delete`
- Tap chat row to toggle read/unread
- Bottom navigation tab switching

## Package Used (pub.dev Requirement)

`pubspec.yaml` includes:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_slidable: ^3.1.2
```

In `lib/main.dart` we import and use it:

```dart
import 'package:flutter_slidable/flutter_slidable.dart';
```

## Project Structure (Relevant Files)

- `lib/main.dart` - UI, state, interactions
- `lib/models/chat_item.dart` - chat model + immutable copyWith

## Code Walkthrough

### 1) App Entry + Root Widget

```dart
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
```

### 2) Stateful Screen (Interactivity Core)

`ChatsScreen` is a `StatefulWidget` because UI changes based on user input.

```dart
class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}
```

### 3) State Variables

```dart
final TextEditingController _searchController = TextEditingController();
late List<ChatItem> _chats;
String _searchQuery = '';
int _selectedFilter = 0;
int _selectedBottomTab = 2;
```

- `_chats` changes when pinning, deleting, and toggling read state.
- `_searchQuery` and `_selectedFilter` drive visible list results.
- `_selectedBottomTab` updates bottom nav selection UI.

### 4) Data Model (`ChatItem`)

Full file: `lib/models/chat_item.dart`

```dart
class ChatItem {
  final String title;
  final String subtitle;
  final String time;
  final int unreadCount;
  final String? imagePath;
  final bool isPinned;

  const ChatItem({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.unreadCount,
    required this.imagePath,
    this.isPinned = false,
  });

  ChatItem copyWith({
    String? title,
    String? subtitle,
    String? time,
    int? unreadCount,
    String? imagePath,
    bool? isPinned,
  }) {
    return ChatItem(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      unreadCount: unreadCount ?? this.unreadCount,
      imagePath: imagePath ?? this.imagePath,
      isPinned: isPinned ?? this.isPinned,
    );
  }
}
```

### 5) State Update Methods (`setState`)

```dart
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
```

### 6) Search + Filter Logic

```dart
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
```

### 7) Swipe Actions (Same Side: Right)

This is the package-powered interaction area from `flutter_slidable`.

```dart
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
        icon: item.isPinned ? Icons.push_pin_outlined : Icons.push_pin,
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
```

### 8) Other Interactions

- **Search** updates query on typing:

```dart
onChanged: (value) {
  setState(() {
    _searchQuery = value;
  });
}
```

- **Filter chips** update selected index:

```dart
onChanged: (value) {
  setState(() {
    _selectedFilter = value;
  });
}
```

- **Bottom tabs** update active tab color:

```dart
onTap: (index) {
  setState(() {
    _selectedBottomTab = index;
  });
}
```

## Full Source References

- Full interactive screen code: `lib/main.dart`
- Full model code: `lib/models/chat_item.dart`

## How UI Reacts to User Actions

1. Tap chat row -> unread counter toggles (read/unread behavior)
2. Swipe right side and tap `Pin/Unpin` -> chat updates and reorders with pinned chats first
3. Swipe right side and tap `Delete` (or full dismiss) -> chat removed from list
4. Type in search -> list filters instantly
5. Tap `All/Unread/Pinned` chips -> list updates instantly
6. Tap bottom nav items -> active tab highlight changes

## Run Instructions

Use these commands in the project root:

```powershell
flutter pub get
flutter run
```

Optional checks:

```powershell
flutter analyze
flutter test
```

## Notes

- Assets are loaded from `assets/images/` (already configured in `pubspec.yaml`).
- The app uses immutable `ChatItem` objects with `copyWith` to keep state updates clean and predictable.
