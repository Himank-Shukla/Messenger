import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:messenger/screens/chat_screen.dart';

// class Recents extends StatelessWidget {
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     final size = MediaQuery.of(context).size;
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//     Future<String> OnSearch() async {
//       // FirebaseFirestore _firestore = FirebaseFirestore.instance;
//       //
//       // await _firestore
//       //     .collection('users')
//       //     .where("name", isEqualTo: _search.text)
//       //     .get()
//       //     .then((value) {
//       //   setState(() {
//       //     userMap = value.docs[0].data();
//       //   });
//       //   print(userMap);
//       //   print(_auth.currentUser);
//       // });
//     }
//
//
//     return Expanded(
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             topRight: Radius.circular(30.0),
//           ),
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(30.0),
//             topRight: Radius.circular(30.0),
//           ),
//           child: SingleChildScrollView(
//             child: Container(
//               height: size.height / 1.25,
//               width: size.width,
//               child: Column(
//                 children: <Widget>[
//                   //OnSearch();
//                 ],
//               ),
//               // child: StreamBuilder<QuerySnapshot>(
//               //   stream: _firestore
//               //       .collection('chatroom')
//               //       .doc(chatRoomId)
//               //       .collection('chats')
//               //       .orderBy("time", descending: true)
//               //       .snapshots(),
//               //   builder: (BuildContext context,
//               //       AsyncSnapshot<QuerySnapshot> snapshot) {
//               //     if (snapshot.data != null) {
//               //       return ListView.builder(
//               //         reverse: true,
//               //         itemCount: snapshot.data.docs.length,
//               //         itemBuilder: (context, index) {
//               //           Map<String, dynamic> map =
//               //           snapshot.data.docs[index].data();
//               //           return messages(size, map);
//               //         },
//               //       );
//               //     } else {
//               //       return Container();
//               //     }
//               //   },
//               // ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Recents extends StatelessWidget {
//   TextEditingController _search = TextEditingController();
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   Map<String, dynamic> userMap;
//
//   String chatRoomId(String user1, String user2) {
//     if (user1 != null) {
//       if (user1[0].toLowerCase().codeUnits[0] >
//           user2.toLowerCase().codeUnits[0]) {
//         return "$user1$user2";
//       } else {
//         return "$user2$user1";
//       }
//     }
//   }
//
//   void OnSearch() async {
//     FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//     await _firestore
//         .collection('users')
//         .where("name", isEqualTo: _search.text)
//         .get()
//         .then((value) {
//          setState(() {
//         userMap = value.docs[0].data();
//       });
//       print(userMap);
//       print(_auth.currentUser);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: TextField(
//             textCapitalization: TextCapitalization.words,
//             controller: _search,
//             decoration: InputDecoration(hintText: "Search here"),
//           ),
//           actions: <Widget>[
//             IconButton(
//                 icon: Icon(Icons.search),
//                 iconSize: 30.0,
//                 color: Colors.white,
//                 onPressed: () {
//                   OnSearch();
//                 }),
//           ]),
//       body: userMap != null
//           ? ListTile(
//         onTap: () {
//           String roomId =
//           chatRoomId(_auth.currentUser.displayName, userMap['name']);
//
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (_) => ChatScreen(
//                 chatRoomId: roomId,
//                 userMap: userMap,
//               ),
//             ),
//           );
//         },
//         leading: CircleAvatar(
//           backgroundColor: Colors.red,
//           child: Text(userMap['name'][0]),
//         ),
//         title: Text(userMap['name']),
//         subtitle: Text(userMap['email']),
//       )
//           : Container(),
//     );
//   }
// }

class Recents extends StatefulWidget {
  @override
  _RecentsState createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
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

  @override
  // void initState() {
  //   // TODO: implement initState
  //   allChats();
  //
  //   super.initState();
  // }
  // void allChats() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  //   await _firestore
  //       .collection('users')
  //       .where("status", isEqualTo: "Unavalible")
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       userMap = value.docs[0].data();
  //       userMap = value.docs[2].data();
  //       userMap = value.docs[0].data();
  //     });
  //     print(userMap);
  //     print(_auth.currentUser);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    return  SingleChildScrollView(
            child: Column(children: [
              Container(
                // height: size.height / 1.25,
                // width: size.width,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('users').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.data != null) {
                      return ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> map =
                              snapshot.data.docs[index].data();
                          return messages(map);
                        },
                      );
                    } else {
                      return Container(color: Colors.blue,);
                    }
                  },
                ),
              ),
            ]),
          );
        //     ? ListTile(
        //   onTap: () {
        //     String roomId =
        //     chatRoomId(_auth.currentUser.displayName, userMap['name']);
        //
        //     Navigator.of(context).push(
        //       MaterialPageRoute(
        //         builder: (_) => ChatScreen(
        //           chatRoomId: roomId,
        //           userMap: userMap,
        //         ),
        //       ),
        //     );
        //   },
        //   leading: CircleAvatar(
        //     backgroundColor: Colors.red,
        //     child: Text(userMap['name'][0]),
        //   ),
        //   title: Text(userMap['name']),
        //   subtitle: Text(userMap['email']),
        // )
       // : Container(color: Colors.green,);
  }

  Widget messages(Map<String, dynamic> map) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    Map<String, dynamic> userMap;
    // ignore: missing_return
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

    // void allChats() async {
    //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
    //
    //   await _firestore
    //       .collection('users')
    //       .where("name", isEqualTo: map['name'])
    //       .get()
    //       .then((value) {
    //     setState(() {
    //       userMap = value.docs[0].data();
    //     });
    //     print(userMap);
    //     print(_auth.currentUser);
    //   });
    // }

    return map['email']!=_auth.currentUser.email?ListTile(
      onTap: () async {

        FirebaseFirestore _firestore = FirebaseFirestore.instance;

        await _firestore
            .collection('users')
            .where("name", isEqualTo: map['name'])
            .get()
            .then((value) {
          setState(() {
            userMap = value.docs[0].data();
          });
          print(userMap);
          print(_auth.currentUser);
        });
        String roomId = chatRoomId(_auth.currentUser.displayName, map['name']);
        //allChats();

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
        child: Text(map['name'][0]),
      ),
      title: Text(map['name']),
      subtitle: Text(map['email']),
    ):SizedBox(height: 1,);
    // // Container(
    // width: size.width,
    // alignment: map['sendby'] == _auth.currentUser.displayName
    //     ? Alignment.centerRight
    //     : Alignment.centerLeft,
    // child: Container(
    //   margin: map['sendby'] == _auth.currentUser.displayName
    //       ? EdgeInsets.only(
    //     top: 8.0,
    //     bottom: 8.0,
    //     left: 80.0,
    //   )
    //       : EdgeInsets.only(
    //     top: 8.0,
    //     bottom: 8.0,
    //     right: 80.0,
    //   ),
    //   padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
    //   //width: MediaQuery.of(context).size.width * 0.75,
    //   decoration: BoxDecoration(
    //     color: map['sendby'] == _auth.currentUser.displayName
    //         ? Color(0xFFFEF9EB)
    //         : Color(0xFFFFEFEE),
    //     borderRadius: map['sendby'] == _auth.currentUser.displayName
    //         ? BorderRadius.only(
    //       topLeft: Radius.circular(15.0),
    //       bottomLeft: Radius.circular(15.0),
    //     )
    //         : BorderRadius.only(
    //       topRight: Radius.circular(15.0),
    //       bottomRight: Radius.circular(15.0),
    //     ),
    //   ),
    //   child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Text(
    //           map['timestamp'],
    //           style: TextStyle(
    //             color: Colors.blueGrey,
    //             fontSize: 16.0,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //         SizedBox(height: 8.0),
    //         Text(
    //           map['message'],
    //           style: TextStyle(
    //             color: Colors.blueGrey,
    //             fontSize: 16.0,
    //             fontWeight: FontWeight.w600,
    //           ),
    //         ),
    //       ]),
    // ),
    // );
  }
}
