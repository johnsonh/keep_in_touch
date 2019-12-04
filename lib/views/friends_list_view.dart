import 'package:flutter/material.dart';
import '../domain/friend.dart';

class FriendsListView extends StatefulWidget {
  const FriendsListView({Key key, this.friendStream}) : super(key: key);

  final Stream<Friend> friendStream;

  @override
  FriendsListViewState createState() => FriendsListViewState();
}

class FriendsListViewState extends State<FriendsListView> {
  final List<Friend> _friendsList = <Friend>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    widget.friendStream.asBroadcastStream().listen((Friend friend) {
      _addFriend(friend);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFriends();
  }

  void _addFriend(Friend friend) {
    if (!mounted) {
      return;
    }
    setState(() {
      _friendsList.add(friend);
    });
  }

  Widget _buildFriends() {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.black,
      ),
      itemCount: _friendsList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('${_friendsList[index].name}', style: _biggerFont),
        );
      },
    );
  }
}
