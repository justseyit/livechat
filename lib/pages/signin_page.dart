import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:livechat/blocs/user/user_bloc.dart';
import 'package:livechat/widgets/signin_with_email.dart';
import 'package:livechat/widgets/signin_button.dart';
import 'package:livechat/widgets/signup_with_email.dart';

//ignore:must_be_immutable
class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController verifyPasswordController =
      TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool registered = true;
  double denominator = 6;
  String title = 'Sign In With Email';

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder(
      bloc: userBloc,
      builder: (context, state) {
        late Widget child;
        late double animWidth;
        late double animHeight;
        if (state is UserEmailExpandedState) {
          child = Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignInWithEmail(
                      emailController: emailController,
                      passwordController: passwordController,
                      formKey: globalKey,
                      emailValidator: (value) {
                        bool valid = EmailValidator.validate(value ?? '');
                        if (valid == false)
                          return 'You provided an invalid e-mail address.';
                        else
                          return null;
                      },
                      passwordValidator: (value) {
                        if ((value ?? '').length < 8)
                          return 'Password length must be longer than 7 characters.';
                        else
                          return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text("Don't have an account? "),
                          InkWell(
                              onTap: () =>
                                  userBloc.add(UserRegisterEmailExpandEvent()),
                              child: Text(
                                'Sign up!',
                                style: TextStyle(color: Colors.blue),
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          animWidth = size.width * (2.5 / 3);
          animHeight = size.height / 4;
          denominator = 20;
          title = 'Sign In With Email';
        } else if (state is UserRegisterEmailExpandedState) {
          child = Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SignUpWithEmail(
                      emailController: emailController,
                      passwordController: passwordController,
                      verifyPasswordController: verifyPasswordController,
                      formKey: globalKey,
                      emailValidator: (value) {
                        bool valid = EmailValidator.validate(value ?? '');
                        if (valid == false)
                          return 'You provided an invalid e-mail address.';
                          return null;
                      },
                      passwordValidator: (value) {
                        if ((value ?? '').length < 8)
                          return 'Password length must be longer than 7 characters.';
                        else
                          return null;
                      },
                      verifyPasswordValidator: (value) {
                        if ((value ?? '').length < 8)
                          return 'Password length must be longer than 7 characters.';
                        if ((value ?? '') != passwordController.text)
                          return 'Passwords must be same';
                        else
                          return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        children: [
                          Text("Already have an account? "),
                          InkWell(
                            onTap: () => userBloc.add(UserEmailExpandEvent()),
                            child: Text(
                              'Sign in!',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
          animWidth = size.width * (2.5 / 3);
          animHeight = size.height / 3;
          denominator = 45;
          title = 'Sign Up With Email';
        } else {
          child = SizedBox();
          animWidth = 0;
          animHeight = 0;
          denominator = 6;
          title = 'Sign In With Email';
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(0, 0.3),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: SignInButton(
                              title: AutoSizeText(
                                'Sign In With Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                maxLines: 1,
                              ),
                              icon: Icon(
                                FontAwesome5.google,
                                color: Colors.white,
                              ),
                              color: Colors.deepOrange,
                              onPressed: () {
                                userBloc.add(UserSignInWithGoogleEvent());
                              },
                              animate: true,
                              userState: UserSigningInWithGoogleState(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SignInButton(
                              title: AutoSizeText(
                                'Sign In With Facebook',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                maxLines: 1,
                              ),
                              icon: Icon(
                                FontAwesome5.facebook,
                                color: Colors.white,
                              ),
                              color: Colors.blueAccent,
                              onPressed: () {
                                userBloc.add(UserSignInWithFacebookEvent());
                              },
                              animate: true,
                              userState: UserSigningInWithFacebookState(),
                            ),
                          ),
                          AnimatedContainer(
                              curve: Curves.ease,
                              width: animWidth,
                              height: animHeight,
                              duration: Duration(milliseconds: 1000),
                              child: child),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: SignInButton(
                              title: AutoSizeText(
                                title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                maxLines: 1,
                              ),
                              icon: Icon(
                                Icons.mail,
                                size: 26,
                                color: Colors.white,
                              ),
                              color: Colors.deepPurpleAccent,
                              onPressed: () {
                                if (!(state is UserEmailExpandedState) && !(state is UserRegisterEmailExpandedState)) userBloc.add(UserEmailExpandEvent());
                                else {
                                  if (state is UserRegisterEmailExpandedState) {
                                    globalKey.currentState!.save();
                                    if (globalKey.currentState!.validate()) {
                                      userBloc.add(
                                        UserRegisterEmailEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  } else {
                                    globalKey.currentState!.save();
                                    if (globalKey.currentState!.validate()) {
                                      userBloc.add(
                                        UserSignInWithEmailEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                              animate: true,
                              userState: UserSigningInWithEmailState(),
                            ),
                          ),
                          SignInButton(
                            title: AutoSizeText(
                              'Sign In As Guest',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              maxLines: 1,
                            ),
                            icon: Icon(
                              Icons.supervised_user_circle_outlined,
                              size: 26,
                              color: Colors.white,
                            ),
                            color: Colors.teal,
                            onPressed: () {
                              userBloc.add(UserSignInAnonymouslyEvent());
                            },
                            animate: true,
                            userState: UserSigningInAnonymouslyState(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    top: size.height / denominator,
                    left: size.width / 3,
                    right: size.width / 3,
                    curve: Curves.ease,
                    duration: Duration(seconds: 1),
                    child: Text(
                      'LIVE\nCHAT\nAPP',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w200, fontSize: 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

/*signInAsGuest(BuildContext context, AuthBase auth) async{
    AppUser? user = await auth.signInAnonymously();
    print(user!.uid.toString());
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LandingPage()));
  }*/
}
