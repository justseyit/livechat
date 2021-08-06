import 'package:flutter/material.dart';
import 'package:livechat/pages/conversation_page.dart';
import 'package:livechat/pages/profile_page.dart';
import 'package:livechat/widgets/bottom_navbar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem tabItem = TabItem.Conversation;

  Map<TabItem, Widget> get pages{
    return{
      TabItem.Conversation : ConversationPage(),
      TabItem.Profile : ProfilePage()
    };
  }

  @override
  Widget build(BuildContext context) {
    //final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: BottomNavBarPage(
        tabItem: tabItem,
        pages: pages,
        onSelectedTab: (selectedTabItem){
          setState(() {
            tabItem = selectedTabItem;
          });
        },
      ),
      /*Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
            'Welcome User!\nID: ${(userBloc.state as UserSignedInState).user!.uid}',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              child: Text('Log Out'),
              onPressed: () async {
                userBloc.add(UserSignOutEvent());
              },
            ),

          ],
        ),*/
    );
  }
}
