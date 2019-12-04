import '../domain/friend.dart';
import '../domain/friends_context.dart';
import '../views/get_in_touch_tab_view.dart';
import '../views/get_in_touch_tab_nav_views.dart';
import '../views/nav_view.dart'; // how to get rid of this

class GetInTouchFlow implements TopLevelFlow {
  final FriendsContext friendsContext;
  final GetInTouchTabView getInTouchTabView; 
  final GetInTouchTabNavViews getInTouchTabNavViews;

  GetInTouchFlow._(this.friendsContext, this.getInTouchTabView, this.getInTouchTabNavViews);

  factory GetInTouchFlow(FriendsContext friendsContext) {
    Future<List<Friend>> friends = friendsContext.getRandomFriends();
    var getInTouchTabView = GetInTouchTabView(friends); 

    GetInTouchTabView Function() start = () {
      Future<List<Friend>> friends = friendsContext.getRandomFriends();
      return GetInTouchTabView(friends); 
    };

    var getInTouchTabNavViews = GetInTouchTabNavViews(getInTouchTabView, start);

    return new GetInTouchFlow._(friendsContext, getInTouchTabView, getInTouchTabNavViews);
  }

  @override
  TopLevelNavViews getTopLevelNavViews() {
    return getInTouchTabNavViews;
  }
}
