import '../domain/friend.dart';
import '../domain/friends_context.dart';
import '../services/url_navigator.dart'; // URLManager we out here
import '../views/friends_tab_nav_views.dart';
import '../views/friends_tab_view.dart';
import '../views/nav_view.dart';

class FriendTabFlow implements TopLevelFlow {

  factory FriendTabFlow(URLNavigator navigator, FriendsContext friendsContext) {
    final Function onPressFAB = () {
      print('Choose random friends');
      navigator.navigateTo('/get_in_touch');
    }; 

    final FriendsTabView friendsTabView = FriendsTabView(onPressFAB);

    // When there's a UI to fill out a new friend, this will be different
    final Function onTapAdd = () async {
      final Friend friend = Friend('Elephant', null, null);
      await friendsContext.saveFriend(friend);
      friendsTabView.addFriend(friend);
      print('add a friend');
    };

    final FriendsTabView Function() start = () {
      friendsContext.getAllFriends().then((List<Friend> friends) {
        friends.forEach(friendsTabView.addFriend);
      });

      return friendsTabView;
    };

    final FriendsTabNavViewsProvider friendsTopTabViewsProvider =
        FriendsTabNavViewsProvider(friendsTabView, onTapAdd, start);

    return FriendTabFlow._(
        navigator, friendsContext, friendsTabView, friendsTopTabViewsProvider);
  }

  FriendTabFlow._(this.navigator, this.friendsContext, this.friendsTabView,
    this.friendsTopTabViewProvider);

  final URLNavigator navigator;
  final FriendsContext friendsContext;
  final FriendsTabView friendsTabView;
  final FriendsTabNavViewsProvider friendsTopTabViewProvider;

  @override
  TopLevelNavViewProvider provideTopLevelNavViews() {
    return friendsTopTabViewProvider;
  }
}
