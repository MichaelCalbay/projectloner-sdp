import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final DateTime dateTime;
  final String timeToString;

  const Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeToString,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        message,
        dateTime,
        timeToString,
      ];

  static List<Message> messages = [
    Message(
      id: 1,
      senderId: 1,
      receiverId: 2,
      message: 'Hi how are you?',
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 2,
      senderId: 2,
      receiverId: 1,
      message: "I'm good thank you!",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 4,
      senderId: 2,
      receiverId: 1,
      message: "What have you been up to?",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 5,
      senderId: 1,
      receiverId: 2,
      message: "Not much, chillin on loner. You?",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 6,
      senderId: 3,
      receiverId: 1,
      message: "Hi Cutie ;)",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 7,
      senderId: 3,
      receiverId: 1,
      message: "You there??????",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 8,
      senderId: 3,
      receiverId: 1,
      message: "Stop ignoring me!",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 9,
      senderId: 1,
      receiverId: 3,
      message: "Chill I was having dinner!",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
  ];
}
