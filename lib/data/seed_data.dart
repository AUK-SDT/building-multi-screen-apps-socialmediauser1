import '../models/chat_item.dart';
import '../models/message.dart';

const List<ChatItem> seedChats = [
  ChatItem(title: 'Denji', subtitle: "Bro I'm starving. Any food plans?", time: '11:41', unreadCount: 2, imagePath: 'assets/images/denji.jpg'),
  ChatItem(title: 'Power', subtitle: 'Bring me snacks. It is an order.', time: '11:30', unreadCount: 17, imagePath: 'assets/images/power.jpg'),
  ChatItem(title: 'Aki Hayakawa', subtitle: 'Be on time. No excuses.', time: '10:58', unreadCount: 0, imagePath: 'assets/images/aki.jpg'),
  ChatItem(title: 'Makima', subtitle: "Let's talk after you finish your task.", time: '10:12', unreadCount: 1, imagePath: 'assets/images/makima.jpg'),
  ChatItem(title: 'Kobeni', subtitle: 'Wait... are we sure this is safe?', time: '09:49', unreadCount: 4, imagePath: 'assets/images/kobeni.jpg'),
  ChatItem(title: 'Himeno', subtitle: "Good job today. Don't overthink it.", time: '09:10', unreadCount: 0, imagePath: 'assets/images/himeno.jpg'),
  ChatItem(title: 'Kishibe', subtitle: 'Train. Then train again.', time: 'Yesterday', unreadCount: 0, imagePath: 'assets/images/kishibe.jpg'),
  ChatItem(title: 'Angel Devil', subtitle: 'Do we really have to go outside today?', time: 'Yesterday', unreadCount: 0, imagePath: 'assets/images/angel.jpg'),
  ChatItem(title: 'Reze', subtitle: 'Wanna grab coffee later?', time: 'Sat', unreadCount: 0, imagePath: 'assets/images/reze.jpg'),
  ChatItem(title: 'Pochita', subtitle: 'woof!', time: 'Sat', unreadCount: 9, imagePath: 'assets/images/pochita.jpg'),
];

const Map<String, List<Message>> seedMessages = {
  'Denji': [
    Message(text: 'yo you there?', isMe: false, time: '11:30'),
    Message(text: 'yeah what up', isMe: true, time: '11:31'),
    Message(text: 'bro im so hungry rn', isMe: false, time: '11:38'),
    Message(text: 'same tbh', isMe: true, time: '11:40'),
    Message(text: "Bro I'm starving. Any food plans?", isMe: false, time: '11:41'),
  ],
  'Power': [
    Message(text: 'I am hungry. Provide food immediately.', isMe: false, time: '11:10'),
    Message(text: 'go get it yourself lol', isMe: true, time: '11:12'),
    Message(text: 'Unacceptable. I am the Blood Fiend.', isMe: false, time: '11:20'),
    Message(text: 'ok fine I have some chips', isMe: true, time: '11:22'),
    Message(text: 'Bring me snacks. It is an order.', isMe: false, time: '11:30'),
  ],
  'Aki Hayakawa': [
    Message(text: 'Mission debrief at 10:45.', isMe: false, time: '10:30'),
    Message(text: 'got it', isMe: true, time: '10:32'),
    Message(text: 'Wear your uniform properly.', isMe: false, time: '10:50'),
    Message(text: 'Be on time. No excuses.', isMe: false, time: '10:58'),
  ],
  'Makima': [
    Message(text: 'How is the mission progressing?', isMe: false, time: '09:50'),
    Message(text: 'almost done', isMe: true, time: '09:55'),
    Message(text: 'Good. I am watching.', isMe: false, time: '10:00'),
    Message(text: "Let's talk after you finish your task.", isMe: false, time: '10:12'),
  ],
  'Kobeni': [
    Message(text: 'Are we really doing this?', isMe: false, time: '09:30'),
    Message(text: 'yeah the mission is confirmed', isMe: true, time: '09:35'),
    Message(text: 'I have a bad feeling...', isMe: false, time: '09:44'),
    Message(text: 'Wait... are we sure this is safe?', isMe: false, time: '09:49'),
  ],
  'Himeno': [
    Message(text: 'Nice work today everyone', isMe: false, time: '09:00'),
    Message(text: 'thanks!', isMe: true, time: '09:02'),
    Message(text: "Good job today. Don't overthink it.", isMe: false, time: '09:10'),
  ],
  'Kishibe': [
    Message(text: 'Did you complete your drills?', isMe: false, time: 'Yesterday'),
    Message(text: 'yes sir', isMe: true, time: 'Yesterday'),
    Message(text: 'Train. Then train again.', isMe: false, time: 'Yesterday'),
  ],
  'Angel Devil': [
    Message(text: 'Is there a mission today?', isMe: false, time: 'Yesterday'),
    Message(text: 'yep, briefing at noon', isMe: true, time: 'Yesterday'),
    Message(text: 'Ugh.', isMe: false, time: 'Yesterday'),
    Message(text: 'Do we really have to go outside today?', isMe: false, time: 'Yesterday'),
  ],
  'Reze': [
    Message(text: 'Hey stranger', isMe: false, time: 'Sat'),
    Message(text: 'oh hey!', isMe: true, time: 'Sat'),
    Message(text: 'Wanna grab coffee later?', isMe: false, time: 'Sat'),
  ],
  'Pochita': [
    Message(text: 'woof!', isMe: false, time: 'Sat'),
    Message(text: '...', isMe: true, time: 'Sat'),
    Message(text: 'woof woof!', isMe: false, time: 'Sat'),
  ],
};
