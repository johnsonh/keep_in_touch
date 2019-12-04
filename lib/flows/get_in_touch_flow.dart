import '../domain/friends_context.dart';
import '../views/nav_view.dart'; // how to get rid of this

class GetInTouchFlow implements TopLevelFlow {
  final FriendsContext friendsContext;
  // final getInTouchTopTabView

  GetInTouchFlow(this.friendsContext); // DI

  @override
  AppBar getAppBar() {
    return AppBar(title: Text("Get In Touch"));
  }

  @override
  Widget getWidget() {
    return start();
  }

  @override
  BottomNavigationBarItem getNavItem() {
    return BottomNavigationBarItem(
        icon: new Icon(Icons.mail), title: new Text('Get In Touch!'));
  }

  @override
  TopLevelTabView getTopLevelViews() {
    return getInTouchTopTabView;
  }
}
