import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livechat/blocs/user/user_bloc.dart';
import 'package:livechat/pages/home_page.dart';
import 'package:livechat/pages/signin_page.dart';
import 'package:livechat/pages/signout_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, state){
        //if(state is UserNotSignedInState) return SignInPage();
        if(state is UserSignedInState) return HomePage();
        if(state is UserInitialState) return state.user == null ? SignInPage() : HomePage();
        //if(state is UserSigningInState) return SignInPage();
        if(state is UserSigningOutState) return SignOutPage();
        if(state is UserErrorState) return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: Text(
                'Error\n\n${state.exception.toString()}'
              ),
            ),
          ),
        );

        return SignInPage();
      },
    );
  }
}
