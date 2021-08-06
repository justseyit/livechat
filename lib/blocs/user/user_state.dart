part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitialState extends UserState {
  final AppUser? user;
  UserInitialState({required this.user});
  @override
  List<Object> get props => [this.user!];
}

class UserSigningInAnonymouslyState extends UserState {
  @override
  List<Object> get props => [];
}

class UserSigningInWithGoogleState extends UserState {
  @override
  List<Object> get props => [];
}

class UserSigningInWithFacebookState extends UserState {
  @override
  List<Object> get props => [];
}

class UserSigningInWithEmailState extends UserState {
  @override
  List<Object> get props => [];
}


class UserEmailExpandedState extends UserState {
  @override
  List<Object> get props => [];
}

class UserRegisterEmailExpandedState extends UserState {
  @override
  List<Object> get props => [];
}


class UserSignedInState extends UserState {
  final AppUser? user;

  UserSignedInState({required this.user});
  @override
  List<Object> get props => [];
}

class UserSigningOutState extends UserState {
  @override
  List<Object> get props => [];
}

class UserNotSignedInState extends UserState {
  final bool signedOut;
  UserNotSignedInState({required this.signedOut});
  @override
  List<Object> get props => [];
}

class UserErrorState extends UserState {
  final Object exception;
  UserErrorState({required this.exception});
  @override
  List<Object> get props => [this.exception];
}
