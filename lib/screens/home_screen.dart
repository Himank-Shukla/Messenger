import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/models/methods.dart';
import 'package:messenger/screens/recents.dart';
import 'package:messenger/screens/search.dart';
import 'package:messenger/widgets/category_selector.dart';
import 'package:messenger/widgets/favorite_contacts.dart';
import 'package:messenger/widgets/recent_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //FirebaseFirestore _firestore= FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // String chatRoomid(String user1, String user2) {
  //   if (user1[0].toLowerCase().codeUnits[0] >
  //       user2.toLowerCase().codeUnits[0]) {
  //     return "$user1$user2";
  //   } else {
  //     return "$user2$user1";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.menu),
          //   iconSize: 30.0,
          //   color: Colors.white,
          //   onPressed: () => logOut(context),
          // ),
          title: Text(
            'Chats',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchScreen(),
                    ),
                  );
                }),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(_auth.currentUser.displayName),
                accountEmail: Text(_auth.currentUser.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color(0xFFFEF9EB),
                  child: Text(
                    _auth.currentUser.displayName[0],
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                onTap: () {
                  logOut(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Recents()),
            ),
          ],
        )
        //   Column(
        //   children: <Widget>[
        //     //CategorySelector(),
        //     Expanded(
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: Theme.of(context).accentColor,
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(30.0),
        //             topRight: Radius.circular(30.0),
        //           ),
        //         ),
        //         child: Column(
        //           children: <Widget>[
        //             //FavoriteContacts(),
        //             Recents(),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
