import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final String timeToString;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeToString,
  });

  factory Message.fromJson(Map<String, dynamic> json, {String? id}) {
    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      dateTime: DateTime.now(),
      timeToString: DateFormat('HH:mm').format(
        json['dateTime'].toDate(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'dateTime': dateTime,
    };
  }

  @override
  List<Object?> get props => [
        senderId,
        receiverId,
        message,
        dateTime,
        timeToString,
      ];
}
