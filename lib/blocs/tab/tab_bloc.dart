import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:livechat/widgets/bottom_navbar_page.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  TabBloc() : super(TabInitial(tabItem:  TabItem.Conversation, onSelectedTab: (TabItem value) {  }));

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    // TODO: implement mapEventToState
  }
}
