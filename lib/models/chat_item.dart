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
