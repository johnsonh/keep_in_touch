import 'package:flutter/material.dart';
import '../domain/friend.dart';

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