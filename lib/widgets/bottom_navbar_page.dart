import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem{Conversation, Profile}

class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({Key? key, required this.tabItem, required this.onSelectedTab, required this.pages, required this.navigatorStateGlobalKeys}) : super(key: key);

  final TabItem tabItem;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> pages;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorStateGlobalKeys;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          tabItemToBottomNavigationBarItem(TabItem.Conversation),
          tabItemToBottomNavigationBarItem(TabItem.Profile),
        ],
        onTap: (index){
          onSelectedTab(TabItem.values[index]);
        },
      ),
      tabBuilder: (context, index){
        TabItem item = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorStateGlobalKeys[item],
          builder: (context){
            return pages[item]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem tabItemToBottomNavigationBarItem(TabItem tabItem){
    final TabItemData tabItemData = TabItemData.tabs[tabItem]!;
    return BottomNavigationBarItem(
      icon: Icon(tabItemData.iconData),
      label: tabItemData.title
    );
  }
}

class TabItemData{
  final String title;
  final IconData iconData;

  TabItemData({required this.title, required this.iconData});
  static Map<TabItem, TabItemData> get tabs => {
    TabItem.Conversation : TabItemData(
      title: 'Conversation',
      iconData: Icons.supervised_user_circle_outlined
    ),
    TabItem.Profile : TabItemData(
      title: 'Profile',
      iconData: Icons.person_outlined
    )
  };
}