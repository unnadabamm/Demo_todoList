import 'package:bloc/bloc.dart';
// import 'package:todolist_app/UI/myCal.dart';
import 'package:todolist_app/UI/myTodoList.dart';

import 'package:todolist_app/UI/myUserlist.dart';

enum NavigationEvents {
  MyUserListClickedEvent,
  MyCalculatorClickedEvent,
  MyTodoListClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => MyTodoList();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.MyUserListClickedEvent:
        yield MyUserList();
        break;
      // case NavigationEvents.MyCalculatorClickedEvent:
      //   yield MyCalculator();
      //   break;
      case NavigationEvents.MyTodoListClickedEvent:
        yield MyTodoList();
        break;
      case NavigationEvents.MyCalculatorClickedEvent:
        break;
    }
  }
}
