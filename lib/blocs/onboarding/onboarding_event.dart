part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final LonerUser user;

  const StartOnboarding({
    this.user = const LonerUser(
        id: '',
        firstName: '',
        lastName: '',
        age: 0,
        gender: '',
        imageUrls: [],
        ign: '',
        valTag: '',
        server: '',
        mainRole: ''),
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends OnboardingEvent {
  final LonerUser user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final LonerUser? user;
  final XFile image;

  const UpdateUserImages({this.user, required this.image});

  @override
  List<Object?> get props => [user, image];
}
