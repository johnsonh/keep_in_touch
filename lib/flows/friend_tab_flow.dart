import '../domain/friend.dart';
import '../domain/friends_context.dart';
import '../views/nav_view.dart';
import '../views/friends_tab_view.dart';
import '../views/friends_tab_nav_views.dart';
import '../services/url_navigator.dart'; // URLManager we out here

class FriendTabFlow implements TopLevelFlow {
  final URLNavigator navigator; 
  final FriendsContext friendsContext;
  final FriendsTabView friendsTabView;
  final FriendsTabNavViews friendsTopTabView;
  
  FriendTabFlow._(this.navigator, this.friendsContext, this.friendsTabView, this.friendsTopTabView);

  factory FriendTabFlow(URLNavigator navigator, FriendsContext friendsContext) {
    var friendsTabView = FriendsTabView(navigator);

    // this will be different when add actually goes to another page, and this saving happens in another button CB
    Function onTapAdd = () async {
      final friend = Friend('Elephant', null, null);
      await friendsContext.saveFriend(friend); // should await
      friendsTabView.addFriend(friend);
      print("add a friend"); 
    }; // analytics could be here 

    FriendsTabView Function() start = () {
      friendsContext.getAllFriends()
        .then((friends) {
          friends.forEach((f) => friendsTabView.addFriend(f)); 
        });

      return friendsTabView; 
    };

    var friendsTopTabView = FriendsTabNavViews(friendsTabView, onTapAdd, start);

    return new FriendTabFlow._(navigator, friendsContext, friendsTabView, friendsTopTabView);
  }

  @override
  TopLevelNavViews getTopLevelNavViews() {
    return friendsTopTabView;
  }
}
