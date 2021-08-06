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

  GlobalKey<NavigatorState> conversationNaviKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> profileNaviKey = GlobalKey<NavigatorState>();

  Map<TabItem, Widget> get pages => {
    TabItem.Conversation : ConversationPage(),
    TabItem.Profile : ProfilePage()
  };

  Map<TabItem, GlobalKey<NavigatorState>> get navigatorStateGlobalKeys => {
    TabItem.Conversation : conversationNaviKey,
    TabItem.Profile : profileNaviKey
  };

  @override
  Widget build(BuildContext context) {
    //final UserBloc userBloc = BlocProvider.of<UserBloc>(context);
    //final Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{
        return !await navigatorStateGlobalKeys[tabItem]!.currentState!.maybePop();
      },
      child: BottomNavBarPage(
        tabItem: tabItem,
        pages: pages,
        navigatorStateGlobalKeys: navigatorStateGlobalKeys,
        onSelectedTab: (selectedTabItem){
          if(selectedTabItem == tabItem){
            navigatorStateGlobalKeys[selectedTabItem]!.currentState!.popUntil((route) => route.isFirst);
          }else{
            setState(() {
              tabItem = selectedTabItem;
            });
          }
        },
      ),
    );
  }
}
