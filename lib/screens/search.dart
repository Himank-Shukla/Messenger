import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/screens/chat_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _search = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> userMap;

  String chatRoomId(String user1, String user2) {
    if (user1 != null) {
      if (user1[0].toLowerCase().codeUnits[0] >
          user2.toLowerCase().codeUnits[0]) {
        return "$user1$user2";
      } else {
        return "$user2$user1";
      }
    }
  }

  void OnSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore
        .collection('users')
        .where("name", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
      print(userMap);
      print(_auth.currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
            textCapitalization: TextCapitalization.words,
            controller: _search,
            decoration: InputDecoration(hintText: "Search here"),
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  OnSearch();
                }),
          ]),
      body: userMap != null
          ? ListTile(
              onTap: () {
                String roomId =
                    chatRoomId(_auth.currentUser.displayName, userMap['name']);

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatScreen(
                      chatRoomId: roomId,
                      userMap: userMap,
                    ),
                  ),
                );
              },
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(userMap['name'][0]),
              ),
              title: Text(userMap['name']),
              subtitle: Text(userMap['email']),
            )
          : Container(),
    );
  }
}
