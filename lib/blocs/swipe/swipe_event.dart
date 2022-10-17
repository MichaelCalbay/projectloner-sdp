part of 'swipe_bloc.dart';

abstract class SwipeEvent extends Equatable {
  const SwipeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUsers extends SwipeEvent {
  final String userId;

  const LoadUsers({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class UpdateMatching extends SwipeEvent {
  final List<LonerUser>? users;

  const UpdateMatching({required this.users});

  @override
  List<Object?> get props => [users];
}

class SwipeLeft extends SwipeEvent {
  final LonerUser user;

  const SwipeLeft({required this.user});

  @override
  List<Object?> get props => [user];
}

class SwipeRight extends SwipeEvent {
  final LonerUser user;

  const SwipeRight({required this.user});

  @override
  List<Object?> get props => [user];
}
