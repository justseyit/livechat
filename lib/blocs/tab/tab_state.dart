part of 'tab_bloc.dart';

abstract class TabState extends Equatable {
  const TabState();
}

class TabInitial extends TabState {
  final TabItem tabItem;
  final ValueChanged<TabItem> onSelectedTab;
  TabInitial({required this.tabItem, required this.onSelectedTab});

  @override
  List<Object> get props => [this.tabItem, this.onSelectedTab];
}
