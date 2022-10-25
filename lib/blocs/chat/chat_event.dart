part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChat extends ChatEvent {
  final String? chatId;

  const LoadChat(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class UpdateChat extends ChatEvent {
  final Chat chat;

  const UpdateChat({required this.chat});

  @override
  List<Object?> get props => [chat];
}

class AddMessage extends ChatEvent {
  final String userId;
  final String matchedUserId;
  final String message;

  AddMessage({
    required this.userId,
    required this.matchedUserId,
    required this.message,
  });

  @override
  List<Object?> get props => [
        userId,
        matchedUserId,
        message,
      ];
}
