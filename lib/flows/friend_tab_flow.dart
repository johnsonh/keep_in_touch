import 'package:keep_in_touch/views/add_friend_view.dart';

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

    // this can be buggy, would be fixed with BLoC
    final FriendsTabView Function() start = () {
      friendsContext.getAllFriends().then((List<Friend> friends) {
        friends.forEach(friendsTabView.addFriend);
      });

      return friendsTabView;
    };

    final Function onTapSave = () async {
      final Friend friend = Friend('Elephant', null, null);
      await friendsContext.saveFriend(friend);
      friendsTabView.addFriend(friend);
      print('add a friend');
    };

    final AddFriendView addFriendView = AddFriendView(onTapSave);

    final Function onTapAdd = () async {
      navigator.navigateTo('/friends/add');
    };

    final FriendsTabNavViewsProvider friendsTopTabViewsProvider =
        FriendsTabNavViewsProvider(friendsTabView, onTapAdd, start);

    return FriendTabFlow._(
        navigator, friendsContext, friendsTabView, addFriendView, friendsTopTabViewsProvider);
  }

  FriendTabFlow._(this._navigator, this._friendsContext, this._friendsTabView, this._addFriendView,
    this._friendsTopTabViewProvider);

  final URLNavigator _navigator;
  final FriendsContext _friendsContext;
  
  final FriendsTabView _friendsTabView;
  final AddFriendView _addFriendView; 
  final FriendsTabNavViewsProvider _friendsTopTabViewProvider;

  @override
  TopLevelNavViewProvider provideTopLevelNavViews() {
    return _friendsTopTabViewProvider;
  }
}
