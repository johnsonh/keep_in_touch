import 'dart:async';

import 'package:flutter/material.dart';
import '../domain/friend.dart';

class FriendTabView extends StatelessWidget {
  final StreamController<Friend> _controller = StreamController<Friend>.broadcast();

  @override
  Widget build(BuildContext context) {
    return FriendsListView(friendStream: _controller.stream);
  }

  addFriend(Friend friend) {
    _controller.add(friend);
  }

  // Widget populate(Future<List<Friend>> friendsFuture) {
  //   return FutureBuilder(
  //     builder: (context, friendsSnapshot) {
  //       if (friendsSnapshot.connectionState == ConnectionState.none &&
  //           friendsSnapshot.hasData == null) {
  //         return Container();
  //       }

  //       return friendsList(friendsSnapshot);
  //     },
  //     future: friendsFuture,
  //   ); 
  // }

  // Widget friendsList(AsyncSnapshot<List<Friend>> friendsSnapshot) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: (friendsSnapshot.data == null ? 0 : friendsSnapshot.data.length),
  //     itemBuilder: (context, index) {
  //       Friend friend = friendsSnapshot.data[index];
  //       return Container(
  //           margin: const EdgeInsets.all(20.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               // Text("ID: " + friend.id.toString()),
  //               Text("Name: " + friend.name),
  //               Text("Email: " + (friend.email == null ? "" : friend.email)),
  //               Text("Phone: " + friend.phoneNumber.toString()),
  //             ],
  //           )
  //         );
  //     },
  //   );
  // }

}

class FriendsListView extends StatefulWidget {
  final Stream<Friend> friendStream;

  const FriendsListView({Key key, this.friendStream}) : super(key: key);

  @override
  FriendsListViewState createState() => FriendsListViewState();
}

class FriendsListViewState extends State<FriendsListView> {
  final _friendsList = [];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    this.widget.friendStream.asBroadcastStream().listen((friend) {
      _addFriend(friend);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFriends();
  }

  _addFriend(Friend friend) {
    if (!mounted) return;
    setState(() {
      _friendsList.add(friend);
    });
  }

  Widget _buildFriends() {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(
        color: Colors.black,
      ),
      itemCount: _friendsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${_friendsList[index].name}', style: _biggerFont),
        );
      },
    );
  }
}
