import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livechat/blocs/user/user_bloc.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({Key? key, required this.title, this.icon, required this.color, required this.onPressed, required this.animate, this.radius, this.width, this.height, this.userState}) : super(key: key);

  final Widget title;
  final Widget? icon;
  final Color color;
  final VoidCallback onPressed;
  final double? radius;
  final bool animate;
  final double? width;
  final double? height;
  final UserState? userState;

  @override
  Widget build(BuildContext context) {
    final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final Size size = MediaQuery.of(context).size;
    return BlocBuilder(
      bloc: userBloc,
      builder: (context, state){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
            Widget child = Container(
              width: size.width * (5/9),
              child: icon != null ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        width: size.width * (1/9),
                        child: icon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Container(
                        width: size.width * (4/9),
                        child: title,
                      ),
                    ),
                  ],
                ),
              ) :
              Container(
                width: size.width * (2/3),
                child: title,
              ),
            );
            double awidth = width ?? size.width * (2.5/3);
            if(state == userState && animate == true){
              setState((){
                awidth = height ?? size.height / 15;
                child = Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              });
            }else{
              setState((){
                awidth = width ?? size.width * (2.5/3);
                child = Container(
                  width: size.width * (5/9),
                  child: icon != null ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          width: size.width * (1/9),
                          child: icon,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          width: size.width * (4/9),
                          child: title,
                        ),
                      ),
                    ],
                  ) :
                  Container(
                    width: size.width * (2/3),
                    child: title,
                  ),
                );
              });
            }
            return InkWell(
              borderRadius: BorderRadius.circular(radius ?? size.height / 15),
              onTap: onPressed,
              child: AnimatedContainer(
                curve: Curves.easeOutCirc,
                duration: Duration(milliseconds: 500),
                width: awidth,
                height: height ?? size.height / 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius ?? size.height/15),
                    color: color
                ),
                child: child,
              ),
            );
          },
        );
      },
    );
  }
}

