import 'package:keep_in_touch/services/url_launch_service.dart';

import '../domain/friend.dart';
import '../domain/friends_context.dart';
import '../views/get_in_touch_tab_nav_views.dart';
import '../views/get_in_touch_tab_view.dart';
import '../views/nav_view.dart';

class GetInTouchFlow implements TopLevelFlow {

  factory GetInTouchFlow(
      FriendsContext friendsContext, UrlLaunchService urlLaunchService) {
    final Future<List<Friend>> friends = friendsContext.getRandomFriends();

    final GetInTouchTabView getInTouchTabView = GetInTouchTabView(
        friends,
        urlLaunchService.launchSMS,
        urlLaunchService.launchFBMessenger,
        urlLaunchService.launchWhatsapp,
        urlLaunchService.launchSlack,
        urlLaunchService.launchWeChat,
        urlLaunchService.launchLinkedin);

    final GetInTouchTabView Function() start = () {
      final Future<List<Friend>> friends = friendsContext.getRandomFriends();
      return GetInTouchTabView(
          friends,
          urlLaunchService.launchSMS,
          urlLaunchService.launchFBMessenger,
          urlLaunchService.launchWhatsapp,
          urlLaunchService.launchSlack,
          urlLaunchService.launchWeChat,
          urlLaunchService.launchLinkedin);
    };

    final GetInTouchTabNavViewsProvider getInTouchTabNavViews =
        GetInTouchTabNavViewsProvider(getInTouchTabView, start);

    return GetInTouchFlow._(friendsContext, urlLaunchService,
        getInTouchTabView, getInTouchTabNavViews);
  }

  GetInTouchFlow._(this.friendsContext, this.urlLaunchService,
      this.getInTouchTabView, this.getInTouchTabNavViewsProvider);

  final FriendsContext friendsContext;
  final UrlLaunchService urlLaunchService;
  final GetInTouchTabView getInTouchTabView;
  final GetInTouchTabNavViewsProvider getInTouchTabNavViewsProvider;

  @override
  TopLevelNavViewProvider provideTopLevelNavViews() {
    return getInTouchTabNavViewsProvider;
  }
}
