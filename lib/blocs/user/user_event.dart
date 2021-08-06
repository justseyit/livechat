part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserSignInAnonymouslyEvent extends UserEvent {

  @override
  List<Object?> get props => [];
}

class UserSignInWithGoogleEvent extends UserEvent {

  @override
  List<Object?> get props => [];
}

class UserSignInWithFacebookEvent extends UserEvent {

  @override
  List<Object?> get props => [];
}

class UserSignInWithEmailEvent extends UserEvent {

  final String email;
  final String password;

  UserSignInWithEmailEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [this.email, this.password];
}

class UserEmailExpandEvent extends UserEvent {

  @override
  List<Object?> get props => [];
}

class UserRegisterEmailExpandEvent extends UserEvent {

  @override
  List<Object?> get props => [];
}

class UserRegisterEmailEvent extends UserEvent {

  final String email;
  final String password;

  UserRegisterEmailEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [this.email, this.password];
}

class UserSignOutEvent extends UserEvent {

  @override
  List<Object?> get props => [];
}
