import 'package:keep_in_touch/services/url_launch_service.dart';

import '../domain/friend.dart';
import '../domain/friends_context.dart';
import '../views/get_in_touch_tab_view.dart';
import '../views/get_in_touch_tab_nav_views.dart';
import '../views/nav_view.dart'; 

class GetInTouchFlow implements TopLevelFlow {
  final FriendsContext friendsContext;
  final UrlLaunchService urlLaunchService; 
  final GetInTouchTabView getInTouchTabView; 
  final GetInTouchTabNavViewsProvider getInTouchTabNavViewsProvider;

  GetInTouchFlow._(this.friendsContext, this.urlLaunchService, this.getInTouchTabView, this.getInTouchTabNavViewsProvider);

  factory GetInTouchFlow(FriendsContext friendsContext, UrlLaunchService urlLaunchService) {
    Future<List<Friend>> friends = friendsContext.getRandomFriends();

    var getInTouchTabView = GetInTouchTabView(
      friends,
      urlLaunchService.launchSMS,
      urlLaunchService.launchFBMessenger,
      urlLaunchService.launchWhatsapp,
      urlLaunchService.launchSlack,
      urlLaunchService.launchWeChat,
      urlLaunchService.launchLinkedin
    ); 

    GetInTouchTabView Function() start = () {
      Future<List<Friend>> friends = friendsContext.getRandomFriends();
      return GetInTouchTabView(
        friends, 
        urlLaunchService.launchSMS,
        urlLaunchService.launchFBMessenger,
        urlLaunchService.launchWhatsapp,
        urlLaunchService.launchSlack,
        urlLaunchService.launchWeChat,
        urlLaunchService.launchLinkedin
      ); 
    };

    var getInTouchTabNavViews = GetInTouchTabNavViewsProvider(getInTouchTabView, start);

    return new GetInTouchFlow._(friendsContext, urlLaunchService, getInTouchTabView, getInTouchTabNavViews);
  }

  @override
  TopLevelNavViewProvider provideTopLevelNavViews() {
    return getInTouchTabNavViewsProvider;
  }
}
