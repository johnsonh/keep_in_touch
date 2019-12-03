import 'dart:async';

import 'package:flutter/material.dart';

class FriendTabView extends StatelessWidget {
  final StreamController<String> _controller = StreamController<String>.broadcast();

  @override
  Widget build(BuildContext context) {
    return FriendsListView(friendStream: _controller.stream);
  }

  addFriend(String friend) {
    _controller.add(friend);
  }
}

class FriendsListView extends StatefulWidget {
  final Stream<String> friendStream;

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

  _addFriend(String friend) {
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
          title: Text('${_friendsList[index]}', style: _biggerFont),
        );
      },
    );
  }
}
