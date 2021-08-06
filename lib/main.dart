import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:livechat/pages/landing_page.dart';
import 'package:livechat/service_locator.dart';
import 'blocs/user/user_bloc.dart';

void main() {
  setupLocator();
  runApp(LiveChatApp());
}

class LiveChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Live Chat',
            home: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => UserBloc(),
                ),
              ],
              child: LandingPage(),
            ),
          );
        }

        if (snapshot.hasError) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Live Chat',
            home: Scaffold(
              body: Center(
                child: Text(
                    'An error occoured while the Firebase initialization process.'
                ),
              ),
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Live Chat',
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

