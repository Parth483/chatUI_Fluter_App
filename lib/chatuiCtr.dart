import 'package:get/get.dart';

class Message {
  final String id;
  final String authorId;
  final DateTime createdAt;
  final String text;

  Message({
    required this.id,
    required this.authorId,
    required this.createdAt,
    required this.text,
  });
}

class ChatController extends GetxController {
  final currentUserId = 'user1';
  final otherUserId = 'user2';
  final messages = <Message>[].obs;
  final isOnline = true.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchMessages();
    _simulateStatusChanges();
  }

  void _fetchMessages() {
    // Initial messages similar to the screenshot
    final initialMessages = [
      Message(
        id: '1',
        authorId: otherUserId,
        createdAt: DateTime.now().subtract(
          const Duration(hours: 5, minutes: 11),
        ),
        text: 'Do you have a time for interview today?',
      ),
      Message(
        id: '2',
        authorId: currentUserId,
        createdAt: DateTime.now().subtract(const Duration(minutes: 11)),
        text: 'Yes, I have.',
      ),
      Message(
        id: '3',
        authorId: otherUserId,
        createdAt: DateTime.now().subtract(const Duration(minutes: 7)),
        text: 'Okay, please meet me at Franklin Avenue at 5 pm',
      ),
      Message(
        id: '4',
        authorId: currentUserId,
        createdAt: DateTime.now().subtract(const Duration(minutes: 6)),
        text: 'Roger that sir, thankyou',
      ),
    ];

    messages.assignAll(initialMessages.reversed);
  }

  void addMessage(String text) {
    final message = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      authorId: currentUserId,
      createdAt: DateTime.now(),
      text: text,
    );
    messages.insert(0, message);

    // Simulate a reply from the other user
    Future.delayed(const Duration(seconds: 2), () {
      final reply = Message(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        authorId: otherUserId,
        createdAt: DateTime.now(),
        text: 'Got it! See you then.',
      );
      messages.insert(0, reply);
    });
  }

  void _simulateStatusChanges() {
    Future.delayed(const Duration(seconds: 5), () {
      isOnline.value = false;
      Future.delayed(const Duration(seconds: 3), () {
        isOnline.value = true;
      });
    });
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }
}
