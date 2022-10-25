part of 'match_bloc.dart';

abstract class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

class MatchLoading extends MatchState {}

class MatchLoaded extends MatchState {
  final List<UserMatch> matchedUsers;

  const MatchLoaded({this.matchedUsers = const <UserMatch>[]});

  @override
  List<Object> get props => [matchedUsers];
}

class NoMatches extends MatchState {}
