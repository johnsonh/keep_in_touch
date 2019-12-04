import 'friend.dart';
import 'friend_model.dart';
import 'friends_client.dart';

class FriendsContext {
  FriendsContext(this.friendsClient);

  final FriendsClient friendsClient;

  List<Friend> friends = <Friend>[
    Friend('Joe', '', 1),
    Friend('Griffin', '', 1),
    // Friend("Ben chao", "", 1),
    // Friend("Pierce", "", 1),
    // Friend("Jeff", "", 1),
    // Friend("Sean fitz", "", 1),
    // Friend("Sharif", "", 1),
    // Friend("Anta", "", 1),
    // Friend("Chris chalmers", "", 1),
    // Friend("Chives", "", 1),
    // Friend("Tyler", "", 1),
    // Friend("Chelsea", "", 1),
    // Friend("Miles", "", 1),
    // Friend("Logan", "", 1),
    // Friend("Sean Allen", "", 1),
    // Friend("Curty", "", 1),
    // Friend("Trevis", "", 1),
    // Friend("Chris lee", "", 1),
    // Friend("Danny", "", 1),
    // Friend("Bentley", "", 1),
    // Friend("Tim", "", 1),
    // Friend("Rob ", "", 1),
    // Friend("Andy ", "", 1),
    // Friend("Derek", "", 1),
    // Friend("David", "", 1),
    // Friend("Brandon", "", 1),
    // Friend("Segalla", "", 1),
    // Friend("Pentland", "", 1),
    // Friend("Lemon", "", 1),
    // Friend("Philip", "", 1),
    // Friend("McDonough", "", 1),
    // Friend("Zouk", "", 1),
    // Friend("Foss", "", 1),
    // Friend("Klu", "", 1),
    // Friend("Joey", "", 1),
    // Friend("Borke", "", 1),
    // Friend("Tenno", "", 1),
    // Friend("Graham", "", 1),
    // Friend("Jason", "", 1),
    // Friend("Cp", "", 1),
    // Friend("Elliott", "", 1),
    // Friend("Tian", "", 1),
    // Friend("Nick rayl", "", 1),
    // Friend("Guy", "", 1),
    // Friend("Vansh", "", 1),
    // Friend("Eric ", "", 1),
    // Friend("Roy", "", 1),
    // Friend("Jack Stulic ", "", 1),
    // Friend("Kush", "", 1),
    // Friend("Patwari", "", 1),
    // Friend("Geoff", "", 1),
    // Friend("Georgios", "", 1),
    // Friend("Aidan", "", 1),
    // Friend("Lynda", "", 1),
    // Friend("Mike Hall", "", 1),
    // Friend("Rex", "", 1),
    // Friend("Kyle", "", 1),
    // Friend("Alex salvatore", "", 1),
    // Friend("Lim", "", 1),
    // Friend("Tony", "", 1),
    // Friend("Dughi", "", 1),
    // Friend("NK", "", 1),
    // Friend("Neil", "", 1),
    // Friend("Santi", "", 1),
    // Friend("Juliet", "", 1),
    // Friend("Worms", "", 1),
    // Friend("Erik", "", 1),
    // Friend("Ofir", "", 1),
    // Friend("Devin", "", 1),
    // Friend("Drew", "", 1),
    // Friend("Will youngs", "", 1),
    // Friend("Zack pajka", "", 1),
    // Friend("Sam Marshall", "", 1),
    // Friend("Himanshu", "", 1),
    // Friend("Q", "", 1),
    // Friend("Blake", "", 1),
    // Friend("Christine", "", 1),
    // Friend("Irene", "", 1),
    // Friend("Derek", "", 1),
    // Friend("Khoa", "", 1),
    // Friend("Christian", "", 1),
    // Friend("Kyle", "", 1),
    // Friend("Jacob", "", 1),
    // Friend("Sav", "", 1),
    // Friend("Pedro", "", 1),
    // Friend("Clint", "", 1),
    // Friend("Whitney", "", 1),
    // Friend("Chris webb", "", 1),
    // Friend("Iman", "", 1),
    // Friend("Anand", "", 1),
    // Friend("Chris lim", "", 1),
    // Friend("Scott", "", 1),
    // Friend("Sandrine", "", 1),
    // Friend("Cotter", "", 1),
    // Friend("Alex Ross ", "", 1),
    // Friend("Matt Chan", "", 1),
    // Friend("Josh", "", 1),
    // Friend("Aaron He", "", 1),
    // Friend("Demi ", "", 1),
    // Friend("Danielle", "", 1),
    // Friend("Shreyas", "", 1),
    // Friend("Gaurang", "", 1),
    // Friend("Dan", "", 1),
    // Friend("Ara", "", 1),
    // Friend("Siva", "", 1),
    // Friend("Paul Blakely", "", 1),
    // Friend("Rani", "", 1),
    // Friend("Ryan Mick", "", 1),
    // Friend("Garo", "", 1),
    // Friend("Chris Fuller", "", 1),
    // Friend("Rounak", "", 1),
    // Friend("Joe Dao", "", 1),
    // Friend("Devin Thomson", "", 1),
    // Friend("Xiaohu", "", 1),
    // Friend("Dimitar", "", 1),
    // Friend("JunYoung", "", 1),
    // Friend("Yating", "", 1),
    // Friend("Daniel Alkalai", "", 1),
    // Friend("Nick Saretzky", "", 1),
    // Friend("Adil", "", 1),
    // Friend("Kyle Bendickson", "", 1),
    // Friend("Salina", "", 1),
    // Friend("Sophia", "", 1),
    // Friend("Andy Lawton", "", 1),
    // Friend("Hemanth", "", 1),
    // Friend("Siggi", "", 1),
    // Friend("Thomas Yoon", "", 1),
    // Friend("John Morse", "", 1),
    // Friend("Doshi", "", 1),
    // Friend("Serge", "", 1),
    // Friend("Shaheen", "", 1),
    // Friend("Vijay", "", 1),
    // Friend("Andre", "", 1),
    // Friend("Owen Thomas", "", 1),
    // Friend("Andy Phan", "", 1),
  ];

  Future<List<Friend>> getAllFriends() async {
    final List<FriendModel> friends = await friendsClient.getFriends();
    return friends.map((FriendModel f) => Friend(f.name, f.email, f.phoneNumber)).toList();
  }

  Future<List<Friend>> getRandomFriends({int num = 1}) async {
    final List<FriendModel> friendModels = await friendsClient.getFriends();
    final List<Friend> friends = friendModels
        .map((FriendModel f) => Friend(f.name, f.email, f.phoneNumber))
        .toList();

    if (num >= friends.length) {
      return friends;
    }
    return (friends.toList()..shuffle()).take(num).toList();
  }

  Future<void> saveFriend(Friend friend) async {
    final FriendModel friendModel =
        FriendModel(-1, friend.name, friend.email, friend.phoneNumber);
    await friendsClient.insertFriend(friendModel);
    print('Saved friend');
  }
}
