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
  final FriendsTabNavViewsProvider friendsTopTabViewProvider;
  
  FriendTabFlow._(this.navigator, this.friendsContext, this.friendsTabView, this.friendsTopTabViewProvider);

  factory FriendTabFlow(URLNavigator navigator, FriendsContext friendsContext) {
    var friendsTabView = FriendsTabView(navigator);

    // When there's a UI to fill out a new friend, this will be different
    Function onTapAdd = () async {
      final friend = Friend('Elephant', null, null);
      await friendsContext.saveFriend(friend);
      friendsTabView.addFriend(friend);
      print("add a friend"); 
    };

    FriendsTabView Function() start = () {
      friendsContext.getAllFriends()
        .then((friends) {
          friends.forEach((f) => friendsTabView.addFriend(f)); 
        });

      return friendsTabView; 
    };

    var friendsTopTabViewsProvider = FriendsTabNavViewsProvider(friendsTabView, onTapAdd, start);

    return new FriendTabFlow._(navigator, friendsContext, friendsTabView, friendsTopTabViewsProvider);
  }

  @override
  TopLevelNavViewProvider provideTopLevelNavViews() {
    return friendsTopTabViewProvider;
  }
}
