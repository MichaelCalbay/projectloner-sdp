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
      receiverId: 5,
      message: 'Dayummm you THICCCCCC',
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 2,
      senderId: 5,
      receiverId: 1,
      message: 'Hah, thank you ;)',
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 3,
      senderId: 3,
      receiverId: 1,
      message: "Hi Cutie ;)",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 4,
      senderId: 1,
      receiverId: 3,
      message: "Hi sexy ;)",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 5,
      senderId: 6,
      receiverId: 1,
      message: "Omg, you're so cute!",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 6,
      senderId: 6,
      receiverId: 1,
      message: "Please reply :(",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
    Message(
      id: 7,
      senderId: 1,
      receiverId: 6,
      message: "Hi sorry, I was having dinner. How are you?",
      dateTime: DateTime.now(),
      timeToString: DateFormat('jm').format(DateTime.now()),
    ),
  ];
}
