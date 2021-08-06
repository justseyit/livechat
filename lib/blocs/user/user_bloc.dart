import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:livechat/models/app_user.dart';
import 'package:livechat/repository/auth_repository.dart';
import 'package:livechat/service_locator.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState(user: null));

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    final AuthRepository authRepository = locator<AuthRepository>();

    if(event is UserSignInAnonymouslyEvent){
      try{
        yield UserSigningInAnonymouslyState();
        AppUser? user = await authRepository.signInAnonymously();
        yield user != null ? UserSignedInState(user: user) : UserNotSignedInState(signedOut: true);
      }catch(ex){
        yield UserErrorState(exception: ex);
      }
    }else if(event is UserSignOutEvent){
      try{
        yield UserSigningOutState();
        bool signedOut = await authRepository.signOut();
        yield UserNotSignedInState(signedOut: signedOut);
      }catch(ex){
        yield UserErrorState(exception: ex);
      }
    }else if(event is UserSignInWithGoogleEvent){
      try{
        yield UserSigningInWithGoogleState();
        AppUser? user = await authRepository.signInWithGoogle();
        yield user != null ? UserSignedInState(user: user) : UserNotSignedInState(signedOut: true);
      }catch(ex){
        yield UserErrorState(exception: ex);
      }
    }else if(event is UserSignInWithFacebookEvent){
      try{
        yield UserSigningInWithFacebookState();
        AppUser? user = await authRepository.signInWithFacebook();
        yield user != null ? UserSignedInState(user: user) : UserNotSignedInState(signedOut: true);
      }catch(ex){
        yield UserErrorState(exception: ex);
      }
    }else if(event is UserSignInWithEmailEvent){
      try{
        yield UserSigningInWithEmailState();
        AppUser? user = await authRepository.signInWithEmail(email: event.email, password: event.password);
        yield user != null ? UserSignedInState(user: user) : UserNotSignedInState(signedOut: true);
      }catch(ex){
        yield UserErrorState(exception: ex);
      }
    }else if(event is UserEmailExpandEvent){
      yield UserEmailExpandedState();
    }else if(event is UserRegisterEmailExpandEvent){
      yield UserRegisterEmailExpandedState();
    }else if(event is UserRegisterEmailEvent){
      try{
        yield UserSigningInWithEmailState();
        AppUser? user = await authRepository.signUpWithEmail(email: event.email, password: event.password);
        yield user != null ? UserSignedInState(user: user) : UserNotSignedInState(signedOut: true);
      }catch(ex){
        yield UserErrorState(exception: ex);
      }
    }else{
      yield UserInitialState(user: authRepository.currentUser);
    }
  }
}
